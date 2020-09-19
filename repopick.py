#!/usr/bin/env python
#
# Copyright (C) 2013-2015 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# Run repopick.py -h for a description of this utility.
#

from __future__ import print_function

import sys
import json
import os
import subprocess
import re
import argparse
import textwrap

try:
    # For python3
    import urllib.error
    import urllib.request
except ImportError:
    # For python2
    import imp
    import urllib2
    urllib = imp.new_module('urllib')
    urllib.error = urllib2
    urllib.request = urllib2

# Parse the command line
parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter, description=textwrap.dedent('''\
    repopick.py is a utility to simplify the process of cherry picking
    patches from CyanogenMod's Gerrit instance.

    Given a list of change numbers, repopick will cd into the project path
    and cherry pick the latest patch available.

    With the --start-branch argument, the user can specify that a branch
    should be created before cherry picking. This is useful for
    cherry-picking many patches into a common branch which can be easily
    abandoned later (good for testing other's changes.)

    The --abandon-first argument, when used in conjuction with the
    --start-branch option, will cause repopick to abandon the specified
    branch in all repos first before performing any cherry picks.'''))
parser.add_argument('change_number', nargs='*', help='change number to cherry pick.  Use {change number}/{patchset number} to get a specific revision.')
parser.add_argument('-i', '--ignore-missing', action='store_true', help='do not error out if a patch applies to a missing directory')
parser.add_argument('-s', '--start-branch', nargs=1, help='start the specified branch before cherry picking')
parser.add_argument('-a', '--abandon-first', action='store_true', help='before cherry picking, abandon the branch specified in --start-branch')
parser.add_argument('-b', '--auto-branch', action='store_true', help='shortcut to "--start-branch auto --abandon-first --ignore-missing"')
parser.add_argument('-q', '--quiet', action='store_true', help='print as little as possible')
parser.add_argument('-v', '--verbose', action='store_true', help='print extra information to aid in debug')
parser.add_argument('-f', '--force', action='store_true', help='force cherry pick even if commit has been merged')
parser.add_argument('-p', '--pull', action='store_true', help='execute pull instead of cherry-pick')
parser.add_argument('-t', '--topic', nargs='*', help='pick all commits from a specified topic')
parser.add_argument('-Q', '--query', nargs='*', help='pick all commits using the specified query')
args = parser.parse_args()
if args.start_branch == None and args.abandon_first:
    parser.error('if --abandon-first is set, you must also give the branch name with --start-branch')
if args.auto_branch:
    args.abandon_first = True
    args.ignore_missing = True
    if not args.start_branch:
        args.start_branch = ['auto']
if args.quiet and args.verbose:
    parser.error('--quiet and --verbose cannot be specified together')
if len(args.change_number) > 0:
    if args.topic or args.query:
        parser.error('cannot specify a topic (or query) and change number(s) together')
if args.topic and args.query:
    parser.error('cannot specify a topic and a query together')
if len(args.change_number) == 0 and not args.topic and not args.query:
    parser.error('must specify at least one commit id or a topic or a query')

# Helper function to determine whether a path is an executable file
def is_exe(fpath):
    return os.path.isfile(fpath) and os.access(fpath, os.X_OK)

# Implementation of Unix 'which' in Python
#
# From: http://stackoverflow.com/questions/377017/test-if-executable-exists-in-python
def which(program):
    fpath, fname = os.path.split(program)
    if fpath:
        if is_exe(program):
            return program
    else:
        for path in os.environ["PATH"].split(os.pathsep):
            path = path.strip('"')
            exe_file = os.path.join(path, program)
            if is_exe(exe_file):
                return exe_file

    return None

# Simple wrapper for os.system() that:
#   - exits on error if !can_fail
#   - prints out the command if --verbose
#   - suppresses all output if --quiet
def execute_cmd(cmd, can_fail=False):
    if args.verbose:
        print('Executing: %s' % cmd)
    if args.quiet:
        cmd = cmd.replace(' && ', ' &> /dev/null && ')
        cmd = cmd + " &> /dev/null"
    if os.system(cmd):
        if not args.verbose:
            print('\nCommand that failed:\n%s' % cmd)
        if not can_fail:
            sys.exit(1)

# Verifies whether pathA is a subdirectory (or the same) as pathB
def is_pathA_subdir_of_pathB(pathA, pathB):
    pathA = os.path.realpath(pathA) + '/'
    pathB = os.path.realpath(pathB) + '/'
    return(pathB == pathA[:len(pathB)])

# Find the necessary bins - repo
repo_bin = which('repo')
if repo_bin == None:
    repo_bin = os.path.join(os.environ["HOME"], 'repo')
    if not is_exe(repo_bin):
        sys.stderr.write('ERROR: Could not find the repo program in either $PATH or $HOME/bin\n')
        sys.exit(1)

# Find the necessary bins - git
git_bin = which('git')
if not is_exe(git_bin):
    sys.stderr.write('ERROR: Could not find the git program in $PATH\n')
    sys.exit(1)

# Change current directory to the top of the tree
if 'ANDROID_BUILD_TOP' in os.environ:
    top = os.environ['ANDROID_BUILD_TOP']
    if not is_pathA_subdir_of_pathB(os.getcwd(), top):
        sys.stderr.write('ERROR: You must run this tool from within $ANDROID_BUILD_TOP!\n')
        sys.exit(1)
    os.chdir(os.environ['ANDROID_BUILD_TOP'])

# Sanity check that we are being run from the top level of the tree
if not os.path.isdir('.repo'):
    sys.stderr.write('ERROR: No .repo directory found. Please run this from the top of your tree.\n')
    sys.exit(1)

# If --abandon-first is given, abandon the branch before starting
if args.abandon_first:
    # Determine if the branch already exists; skip the abandon if it does not
    plist = subprocess.Popen([repo_bin,"info"], stdout=subprocess.PIPE)
    needs_abandon = False
    while(True):
        pline = plist.stdout.readline().rstrip()
        if not pline:
            break
        matchObj = re.match(r'Local Branches.*\[(.*)\]', pline.decode())
        if matchObj:
            local_branches = re.split('\s*,\s*', matchObj.group(1))
            if any(args.start_branch[0] in s for s in local_branches):
                needs_abandon = True

    if needs_abandon:
        # Perform the abandon only if the branch already exists
        if not args.quiet:
            print('Abandoning branch: %s' % args.start_branch[0])
        cmd = '%s abandon %s' % (repo_bin, args.start_branch[0])
        execute_cmd(cmd)
        if not args.quiet:
            print('')

# Get the list of projects that repo knows about
#   - convert the project name to a project path
project_name_to_path = {}
plist = subprocess.Popen([repo_bin,"list"], stdout=subprocess.PIPE)
project_path = None
while(True):
    pline = plist.stdout.readline().rstrip()
    if not pline:
        break
    ppaths = re.split('\s*:\s*', pline.decode())
    project_name_to_path[ppaths[1]] = ppaths[0]

# Get all commits for a specified topic
if args.topic:
    for argument in args.topic:
        gerrit, tag = argument.rsplit('_', 1)

        if 'LAOS' in gerrit:
            url = 'http://review.lineageos.org/changes/?q=topic:%s' % tag
        elif 'LX' in gerrit:
            url = 'http://review.msm7x30.org/changes/?q=topic:%s' % tag

        if args.verbose:
            print('Fetching all commits from topic: %s\n' % tag)
        f = urllib.request.urlopen(url)
        d = f.read().decode("utf-8")
        if args.verbose:
            print('Result from request:\n' + d)

        # Clean up the result
        d = d.split(')]}\'\n')[1]
        matchObj = re.match(r'\[\s*\]', d)
        if matchObj:
            sys.stderr.write('ERROR: Topic %s was not found on the server\n' % tag)
            sys.exit(1)
        # d = re.sub(r'\[(.*)\]', r'\1', d)
        if args.verbose:
            print('Result from request:\n' + d)

        data = json.loads(d)
        changelist = []
        for c in xrange(0, len(data)):
            changelist.append(int(data[c]['_number']))

        # For compatibility with other gerrit commit (these 2 "reverse" will be delete later)
        changelist.sort(reverse=True)

        # Add the gerrit argument to the new list
        changelist = [('%s_' % gerrit) + str(listitem) for listitem in changelist]

        # Reverse the array as we want to pick the lowest one first
        args.change_number += reversed(changelist)

# Get all commits for a specified query
if args.query:
    for argument in args.query:
        gerrit, pquery = argument.rsplit('_', 1)
        if 'LAOS' in gerrit:
            url = 'http://review.lineageos.org/changes/?q=%s' % pquery
        elif 'LX' in gerrit:
            url = 'http://review.msm7x30.org/changes/?q=%s' % pquery
        if args.verbose:
            print('Fetching all commits using query: %s\n' % pquery)
        f = urllib.request.urlopen(url)
        d = f.read().decode("utf-8")
        if args.verbose:
            print('Result from request:\n' + d)

        # Clean up the result
        d = d.split(')]}\'\n')[1]
        matchObj = re.match(r'\[\s*\]', d)
        if matchObj:
            sys.stderr.write('ERROR: Query %s was not found on the server\n' % pquery)
            sys.exit(1)
        # d = re.sub(r'\[(.*)\]', r'\1', d)
        if args.verbose:
            print('Result from request:\n' + d)

        data = json.loads(d)
        changelist = []
        for c in xrange(0, len(data)):
            changelist.append(data[c]['_number'])

        # For compatibility with other gerrit commit (these 2 "reverse" will be delete later)
        changelist.sort(reverse=True)

        # Add the gerrit argument to the new list
        changelist = [('%s_' % gerrit) + str(listitem) for listitem in changelist]

        # Reverse the array as we want to pick the lowest one first
        args.change_number += reversed(changelist)

# Check for range of commits and rebuild array
changelist = []
for argument in args.change_number:
    gerrit, change = argument.split('_', 1)
    c=str(change)
    if '-' in c:
        templist = c.split('-')
        for i in range(int(templist[0]), int(templist[1]) + 1):
            changelist.append(('%s_' % gerrit) + str(i))
    else:
        changelist.append(('%s_' % gerrit) + c)

args.change_number = changelist

# Iterate through the requested change numbers
for argument in args.change_number:
    gerrit, changeps = argument.split('_', 1)

    if '/' in changeps:
        change = changeps.split('/')[0]
        patchset = changeps.split('/')[1]
    else:
        change = changeps
        patchset = ''

    if not args.quiet:
        if len(patchset) == 0:
            print('Applying change number %s ...' % change)
        else:
            print('Applying change number {change}/{patchset} ...'.format(change=change, patchset=patchset))

    if len(patchset) == 0:
        query_revision = 'CURRENT_REVISION'
    else:
        query_revision = 'ALL_REVISIONS'

    # Fetch information about the change from Gerrit's REST API
    #
    # gerrit returns two lines, a magic string and then valid JSON:
    #   )]}'
    #   [ ... valid JSON ... ]
    if 'LAOS' in gerrit:
        url = 'http://review.lineageos.org/changes/?q={change}&o={query_revision}&o=CURRENT_COMMIT&pp=0'.format(change=change, query_revision=query_revision)
    elif 'LX' in gerrit:
        url = 'http://review.msm7x30.org/changes/?q={change}&o={query_revision}&o=CURRENT_COMMIT&pp=0'.format(change=change, query_revision=query_revision)
    if args.verbose:
        print('Fetching from: %s\n' % url)
    try:
        f = urllib.request.urlopen(url)
    except urllib.error.URLError:
        sys.stderr.write('ERROR: Server reported an error, or cannot be reached\n')
        sys.exit(1)
    d = f.read().decode("utf-8")
    if args.verbose:
        print('Result from request:\n' + d)

    # Clean up the result
    d = d.split('\n')[1]
    matchObj = re.match(r'\[\s*\]', d)
    if matchObj:
        sys.stderr.write('ERROR: Change number %s was not found on the server\n' % change)
        sys.exit(1)
    d = re.sub(r'\[(.*)\]', r'\1', d)

    # Parse the JSON
    try:
        data = json.loads(d)
    except ValueError:
        sys.stderr.write('ERROR: The response from the server could not be parsed properly\n')
        if not args.verbose:
            sys.stderr.write('The malformed response was: %s\n' % d)
        sys.exit(1)

    # Extract information from the JSON response
    date_fluff       = '.000000000'
    project_name     = data['project']
    project_branch   = data['branch']
    change_number    = data['_number']
    status           = data['status']
    patchsetfound    = False

    if len(patchset) > 0:
        try:
            for revision in data['revisions']:
                if (int(data['revisions'][revision]['_number']) == int(patchset)) and not patchsetfound:
                    target_revision = data['revisions'][revision]
                    if args.verbose:
                        print('Using found patch set {patchset} ...'.format(patchset=patchset))
                    patchsetfound = True
                    break
            if not patchsetfound:
                print('ERROR: The patch set could not be found, using CURRENT_REVISION instead.')
        except:
            print('ERROR: The patch set could not be found, using CURRENT_REVISION instead.')
            patchsetfound = False

    if not patchsetfound:
        target_revision = data['revisions'][data['current_revision']]

    current_revision = data['revisions'][data['current_revision']]

    patch_number     = target_revision['_number']
    fetch_url        = target_revision['fetch']['anonymous http']['url']
    fetch_ref        = target_revision['fetch']['anonymous http']['ref']
    author_name      = current_revision['commit']['author']['name']
    author_email     = current_revision['commit']['author']['email']
    author_date      = current_revision['commit']['author']['date'].replace(date_fluff, '')
    committer_name   = current_revision['commit']['committer']['name']
    committer_email  = current_revision['commit']['committer']['email']
    committer_date   = current_revision['commit']['committer']['date'].replace(date_fluff, '')
    subject          = current_revision['commit']['subject']

    # Check if commit has already been merged and exit if it has, unless -f is specified
    if status == "MERGED":
        if args.force:
            print("!! Force-picking a merged commit !!\n")
        else:
            print("Commit already merged. Skipping the cherry pick.\nUse -f to force this pick.")
            continue;

    # Convert the project name to a project path
    #   - check that the project path exists
    if project_name in project_name_to_path:
        project_path = project_name_to_path[project_name];

        if project_path.startswith('hardware/qcom/'):
            split_path = project_path.split('/')
            # split_path[2] might be display or it might be display-caf, trim the -caf
            split_path[2] = split_path[2].split('-')[0]

            # Need to treat hardware/qcom/{audio,display,media} specially
            if split_path[2] == 'audio' or split_path[2] == 'display' or split_path[2] == 'media':
                split_branch = project_branch.split('-')

                # display is extra special
                if split_path[2] == 'display' and len(split_path) == 3:
                    project_path = '/'.join(split_path)
                else:
                    project_path = '/'.join(split_path[:-1])

                if len(split_branch) == 4 and split_branch[0] == 'cm' and split_branch[2] == 'caf':
                    project_path += '-caf/msm' + split_branch[3]
                # audio and media are different from display
                elif split_path[2] == 'audio' or split_path[2] == 'media':
                    project_path += '/default'
        elif project_path.startswith('hardware/ril'):
            project_path = project_path.rstrip('-caf')
            if project_branch.split('-')[-1] == 'caf':
                project_path += '-caf'
    elif args.ignore_missing:
        print('WARNING: Skipping %d since there is no project directory for: %s\n' % (change_number, project_name))
        continue;
    else:
        sys.stderr.write('ERROR: For %d, could not determine the project path for project %s\n' % (change_number, project_name))
        sys.exit(1)

    # If --start-branch is given, create the branch (more than once per path is okay; repo ignores gracefully)
    if args.start_branch:
        cmd = '%s start %s %s' % (repo_bin, args.start_branch[0], project_path)
        execute_cmd(cmd)

    # Print out some useful info
    if not args.quiet:
        print('--> Subject:       "%s"' % subject)
        print('--> Gerrit:        %s' % gerrit)
        print('--> Project path:  %s' % project_path)
        print('--> Change number: %d (Patch Set %d)' % (change_number, patch_number))
        print('--> Author:        %s <%s> %s' % (author_name, author_email, author_date))
        print('--> Committer:     %s <%s> %s' % (committer_name, committer_email, committer_date))

    # Try fetching from GitHub first
    if 'LAOS' in gerrit:
        github_remote = 'github'
    elif 'LX' in gerrit:
        github_remote = 'msm7x30'
    if args.verbose:
        print('Trying to fetch the change from GitHub')
    if args.pull:
        cmd = 'cd %s && git pull --no-edit %s %s' % (project_path, github_remote, fetch_ref)
    else:
        cmd = 'cd %s && git fetch %s %s' % (project_path, github_remote, fetch_ref)
    execute_cmd(cmd, True)
    # Check if it worked
    FETCH_HEAD = '%s/.git/FETCH_HEAD' % project_path
    if os.stat(FETCH_HEAD).st_size == 0:
        # That didn't work, fetch from Gerrit instead
        if args.verbose:
            print('Fetching from GitHub didn\'t work, trying to fetch the change from Gerrit')
        if args.pull:
            cmd = 'cd %s && git pull --no-edit %s %s' % (project_path, fetch_url, fetch_ref)
        else:
            cmd = 'cd %s && git fetch %s %s' % (project_path, fetch_url, fetch_ref)
        execute_cmd(cmd)
    # Perform the cherry-pick
    cmd = 'cd %s && git cherry-pick FETCH_HEAD' % (project_path)
    if not args.pull:
        execute_cmd(cmd)
    if not args.quiet:
        print('')
