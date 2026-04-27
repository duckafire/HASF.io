#!/usr/bin/env sh

APACHE_CONFIG_FILE='/etc/apache2/httpd.conf'
PHP_COMMON_EXT='add php83-common php83-mysqli php83-pgsql php83-sqlite3 php83-gd php83-curl php83-intl php83-mbstring php83-openssl php83-xml php83-zip php83-bcmath php83-soap php83-pcntl php83-posix php83-session php83-ctype php83-dom php83-fileinfo php83-gettext php83-iconv php83-json php83-opcache php83-pdo php83-pdo_mysql php83-pdo_pgsql php83-pdo_sqlite php83-phar php83-simplexml php83-tokenizer php83-xmlreader php83-xmlwriter'

apk update --quiet
apk add --quiet --no-cache apache2 php83-apache2 composer $PHP_COMMON_EXT

# Just a configuration script:
cat << 'APACHE_MAIN_CONF_FILE' > "$APACHE_CONFIG_FILE"
ServerTokens Prod
ServerRoot /app
Listen 80
#ServerAdmin you@example.com
ServerSignature Off
DocumentRoot "/app/prod"
ErrorLog /app/apache/logs/error.log
LogLevel warn
IncludeOptional /etc/apache2/conf.d/*.conf


LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
LoadModule authn_file_module modules/mod_authn_file.so
LoadModule authn_core_module modules/mod_authn_core.so
LoadModule authz_host_module modules/mod_authz_host.so
LoadModule authz_groupfile_module modules/mod_authz_groupfile.so
LoadModule authz_user_module modules/mod_authz_user.so
LoadModule authz_core_module modules/mod_authz_core.so
LoadModule access_compat_module modules/mod_access_compat.so
LoadModule auth_basic_module modules/mod_auth_basic.so
LoadModule reqtimeout_module modules/mod_reqtimeout.so
LoadModule filter_module modules/mod_filter.so
LoadModule mime_module modules/mod_mime.so
LoadModule log_config_module modules/mod_log_config.so
LoadModule env_module modules/mod_env.so
LoadModule headers_module modules/mod_headers.so
LoadModule setenvif_module modules/mod_setenvif.so
LoadModule version_module modules/mod_version.so
LoadModule unixd_module modules/mod_unixd.so
LoadModule status_module modules/mod_status.so
LoadModule autoindex_module modules/mod_autoindex.so
LoadModule dir_module modules/mod_dir.so
LoadModule alias_module modules/mod_alias.so
LoadModule negotiation_module modules/mod_negotiation.so
LoadModule php_module modules/mod_php83.so


<FilesMatch \.php$>
   SetHandler application/x-httpd-php
</FilesMatch>


<IfModule unixd_module>
	User apache
	Group apache
</IfModule>

<IfModule dir_module>
    DirectoryIndex index.php
</IfModule>

<IfModule log_config_module>
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
    LogFormat "%h %l %u %t \"%r\" %>s %b" common

    <IfModule logio_module>
      LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio
    </IfModule>

    CustomLog logs/access.log combined
</IfModule>

<IfModule alias_module>
    ScriptAlias /cgi-bin/ "/app/apache/cgi-bin
</IfModule>

<IfModule headers_module>
    RequestHeader unset Proxy early
</IfModule>

<IfModule mime_module>
    TypesConfig /etc/apache2/mime.types
    AddType application/x-compress .Z
    AddType application/x-gzip .gz .tgz
</IfModule>

<IfModule mime_magic_module>
    MIMEMagicFile /etc/apache2/magic
</IfModule>


<Directory />
    AllowOverride None
    Require All denied
</Directory>

<Directory "/app/prod">
	Require All granted
	AllowOverride All
</Directory>

<Directory "/app/apache/cgi-bin">
    AllowOverride None
    Options None
    Require all granted
</Directory>
APACHE_MAIN_CONF_FILE

