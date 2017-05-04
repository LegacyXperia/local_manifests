# LegacyXperia Mirror Manifest

Usage: `repo init -u https://github.com/LegacyXperia/local_manifests -b mirror --mirror`

To update the mirror, either edit the manifest manually or use the `mirror-regen.sh` script.  
**WARNING:** The script causes some data usage. Also, it is possible that it fails downloading a page of repositories. As a result, these repositories that were on that page will be missing in the mirror manifest. **Please double check the results**
