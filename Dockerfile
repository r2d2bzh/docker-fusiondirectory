FROM tiredofit/fusiondirectory:2.6.2

ARG FUSION_PATH=/www/fusiondirectory/
ARG FUSION_PLUGIN_PATH=./assets/fusiondirectory-plugins/
ARG LOCAL_FUSION_PATH=fusiondirectory/

COPY $LOCAL_FUSION_PATH /tmpFusion/
RUN find /tmpFusion -name '*.patch' -type f | xargs -i cp {} /www/fusiondirectory/ && rm -rf /tmpFusion

COPY ${LOCAL_FUSION_PATH}html/ ${FUSION_PATH}html/
COPY ${LOCAL_FUSION_PATH}html/index.patch ${FUSION_PATH}html/index.patch
COPY ${LOCAL_FUSION_PATH}html/main.patch ${FUSION_PATH}html/main.patch
COPY ${LOCAL_FUSION_PATH}nginx/404.html /etc/nginx/html/404.html
COPY ${LOCAL_FUSION_PATH}nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ${LOCAL_FUSION_PATH}php/php.ini /etc/php7/php.ini
COPY ${LOCAL_FUSION_PATH}php/php-fpm.conf /etc/php7/php-fpm.conf

RUN patch -i ${FUSION_PATH}class_CSRFProtection.patch ${FUSION_PATH}include/class_CSRFProtection.inc && \
    patch -i ${FUSION_PATH}class_filterLDAP.patch ${FUSION_PATH}include/class_filterLDAP.inc && \
    patch -i ${FUSION_PATH}class_ldap.patch ${FUSION_PATH}include/class_ldap.inc && \
    patch -i ${FUSION_PATH}class_simpleManagement.patch ${FUSION_PATH}include/simpleplugin/class_simpleManagement.inc && \
    patch -i ${FUSION_PATH}class_simplePlugin.patch ${FUSION_PATH}include/simpleplugin/class_simplePlugin.inc && \
    patch -i ${FUSION_PATH}class_password-methods.patch ${FUSION_PATH}include/password-methods/class_password-methods.inc && \
    patch -i ${FUSION_PATH}class_password-methods-crypt.patch ${FUSION_PATH}include/password-methods/class_password-methods-crypt.inc && \
    patch -i ${FUSION_PATH}class_user.patch ${FUSION_PATH}plugins/personal/generic/class_user.inc && \
    patch -i ${FUSION_PATH}class_Language.patch ${FUSION_PATH}include/class_Language.inc && \
    patch -i ${FUSION_PATH}class_dashBoardPPolicy.patch ${FUSION_PLUGIN_PATH}ppolicy/addons/dashboard/class_dashBoardPPolicy.inc && \
    patch -i ${FUSION_PATH}class_dashboardSystems.patch ${FUSION_PLUGIN_PATH}systems/addons/dashboard/class_dashBoardSystems.inc && \
    patch -i ${FUSION_PATH}user-list.patch ${FUSION_PATH}plugins/admin/users/user-list.xml && \
    patch -i ${FUSION_PATH}class_userManagement.patch ${FUSION_PATH}plugins/admin/users/class_userManagement.inc && \
    patch -i ${FUSION_PATH}class_ogroup.patch ${FUSION_PATH}plugins/admin/groups/class_ogroup.inc && \
    patch -i ${FUSION_PATH}class_roleGeneric.patch ${FUSION_PATH}plugins/admin/groups/class_roleGeneric.inc && \
    patch -i ${FUSION_PATH}class_department.patch ${FUSION_PATH}plugins/admin/departments/class_department.inc && \
    patch -i ${FUSION_PATH}class_auditEvent.patch ${FUSION_PLUGIN_PATH}audit/admin/audit/class_auditEvent.inc && \
    patch -i ${FUSION_PATH}class_StringAttribute.patch ${FUSION_PATH}include/simpleplugin/attributes/class_StringAttribute.inc && \
    patch -i ${FUSION_PATH}functions.patch ${FUSION_PATH}include/functions.inc && \
    patch -i ${FUSION_PATH}html/index.patch ${FUSION_PATH}html/index.php && \
    patch -i ${FUSION_PATH}html/main.patch ${FUSION_PATH}html/main.php && \
    patch -i ${FUSION_PATH}class_msg_dialog.patch ${FUSION_PATH}include/class_msg_dialog.inc && \
    patch -i ${FUSION_PATH}login.patch ${FUSION_PATH}ihtml/themes/breezy/login.tpl && \
    patch -i ${FUSION_PATH}framework.patch ${FUSION_PATH}ihtml/themes/breezy/framework.tpl && \
    patch -i ${FUSION_PATH}headers.patch ${FUSION_PATH}ihtml/themes/breezy/headers.tpl && \
    patch -i ${FUSION_PATH}php_setup.patch ${FUSION_PATH}include/php_setup.inc && \
    rm -f ${FUSION_PATH}*.patch ${FUSION_PATH}html/*.patch

RUN apk add openldap-clients

HEALTHCHECK --start-period=30s \
    CMD curl --fail localhost || exit 1;
