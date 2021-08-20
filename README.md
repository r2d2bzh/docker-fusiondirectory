# docker-fusiondirectory
Docker image of FusionDirectory based on [tiredofit/docker-fusiondirectory](https://github.com/tiredofit/docker-fusiondirectory) with additional tweaks.

## Prerequisites

Before running this docker, you should ensure that an openldap is running and accessible to this docker fusiondirectory.
This openldap should already contains all needed objects for fusiondirectory.

## Additional tweaks

### ICP number support

The [ICP](https://en.wikipedia.org/wiki/ICP_license) can be passed as the following environment variable ICP_NUMBER. It is then assigned to the icpNumber variable inside index.php.

If you are using the breezy theme, the [ICP](https://en.wikipedia.org/wiki/ICP_license) number will be displayed on the footer of the login page.

You can also use the icpNumber variable in your own theme to display the ICP number the way you want.

A custom logout redirection URI can be passed in the header `logout-redirect-uri` to bind to your identity provider.

## Development

## Patch files

We use *patch files* in order to update files from the base image.

The fusiondirectory file tree is reproduced under the fusiondirectory path.
For every modified files you will find a patch file.

If you need to modify fusiondirectory behavior, you can modify an existing patch file or create a new one.

To create a patch file, use the following command:
``` sh
diff -u class_user.inc class_user_new.inc > class_user.patch
```
