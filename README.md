# docker-fusiondirectory
Docker image of FusionDirectory based on [tiredofit/docker-fusiondirectory](https://github.com/tiredofit/docker-fusiondirectory) with additional tweaks.

## Prerequisites

Before running this docker, you should ensure that an openldap is running and accessible by this docker fusiondirectory.
This openldap should already contains all needed objects for fusiondirectory.

## Additional tweaks

### icp number support

The icp can be pass as the following environment variable ICP_NUMBER. It is then assigned to the icpNumber variable inside index.php.

You can then use the icpNumber variable in your own theme to display the icp number.
