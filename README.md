# docker-fusiondirectory
Docker image of FusionDirectory based on [tiredofit/docker-fusiondirectory](https://github.com/tiredofit/docker-fusiondirectory) with additional tweaks.

## Prerequisites

Before running this docker, you should ensure that an openldap is running and accessible by this docker fusiondirectory.
This openldap should already contains all needed objects for fusiondirectory.

## Additional tweaks

### icp number support

The icp can be pass as the following environment variable ICP_NUMBER. It is then assigned to the icpNumber variable inside index.php.

You can then use the icpNumber variable in your own theme to display the icp number.

## Development

## Patch files

We use *patch files* in order to update files from the base image.

The fusiondirectory file tree is reproduced under the fusiondirectory path.
For every modified files you will find a patch file.

If you need to create a change, you can execute a bash in this docker and do the wanted changes in a new file.
Once you have both your changes and the original file, you can generate the patch file with the following command:

``` sh
diff -u class_user.inc class_user_new.inc > class_user.patch
```
