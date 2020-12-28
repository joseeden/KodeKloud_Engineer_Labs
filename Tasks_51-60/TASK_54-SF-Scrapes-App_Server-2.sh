
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK_54-SF-Scrapes-App_Server-2

** EDEN:
** The first few parts were cut because the text on the commandline is already long.


 * updates: mirror.checkdomain.de
epel                                                                     | 4.7 kB  00:00:00
(1/3): epel/x86_64/group_gz                                              |  95 kB  00:00:00
(2/3): epel/x86_64/updateinfo                                            | 1.0 MB  00:00:00
(3/3): epel/x86_64/primary_db                                            | 6.9 MB  00:00:01
Resolving Dependencies
--> Running transaction check
---> Package nginx.x86_64 1:1.16.1-3.el7 will be installed

Dependency Updated:
  openssl-libs.x86_64 1:1.0.2k-19.el7

Complete!
[root@stapp02 ~]# systemctl enable nginx
Created symlink from /etc/systemd/system/multi-user.target.wants/nginx.service to /usr/lib/systemd/system/nginx.service.
[root@stapp02 ~]# systemctl start nginx
[root@stapp02 ~]# systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2020-11-28 14:32:15 UTC; 6ms ago
  Process: 332 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
  Process: 331 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
  Process: 330 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
 Main PID: 333 (nginx)
   CGroup: /docker/0a0cce77b0ccec39f5ad2027039c858f9b0ce8f7c4a227d0c1363f3617ee6906/system.slice/nginx.service
           ├─333 nginx: master process /usr/sbin/nginx
           ├─334 nginx: worker process
           └─335 nginx: worker process

Nov 28 14:32:15 stapp02 systemd[1]: Forked /usr/sbin/nginx as 332
Nov 28 14:32:15 stapp02 systemd[1]: nginx.service changed start-pre -> start
Nov 28 14:32:15 stapp02 systemd[332]: Executing: /usr/sbin/nginx
Nov 28 14:32:15 stapp02 systemd[1]: Child 332 belongs to nginx.service
Nov 28 14:32:15 stapp02 systemd[1]: nginx.service: control process exited, code=exited status=0
Nov 28 14:32:15 stapp02 systemd[1]: nginx.service got final SIGCHLD for state start
Nov 28 14:32:15 stapp02 systemd[1]: Main PID loaded: 333
Nov 28 14:32:15 stapp02 systemd[1]: nginx.service changed start -> running
Nov 28 14:32:15 stapp02 systemd[1]: Job nginx.service/start finished, result=done
Nov 28 14:32:15 stapp02 systemd[1]: Started The nginx HTTP and reverse proxy server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp02 ~]#
Display all 771 possibilities? (y or n)
[root@stapp02 ~]#
[root@stapp02 ~]# ls -l /etc/pki/tls/certs/
total 12
lrwxrwxrwx 1 root root   49 Aug  1  2019 ca-bundle.crt -> /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
lrwxrwxrwx 1 root root   55 Aug  1  2019 ca-bundle.trust.crt -> /etc/pki/ca-trust/extracted/openssl/ca-bundle.trust.crt
-rwxr-xr-x 1 root root  610 Aug  9  2019 make-dummy-cert
-rw-r--r-- 1 root root 2516 Aug  9  2019 Makefile
-rwxr-xr-x 1 root root  829 Aug  9  2019 renew-dummy-cert
[root@stapp02 ~]#
[root@stapp02 ~]# ls -l /tmp
total 16
-rwx------ 36 root root  836 Aug  1  2019 ks-script-rnBCJB
-rw-r--r--  1 root root 2170 Nov 28 14:29 nautilus.crt
-rw-r--r--  1 root root 3267 Nov 28 14:29 nautilus.key
drwx------  3 root root 4096 Nov 28 14:32 systemd-private-d54328b730db4a9a81f0c97bc3b80e38-nginx.service-BKgLrO
-rw------- 36 root root    0 Aug  1  2019 yum.log
[root@stapp02 ~]#
[root@stapp02 ~]# mv /tmp/nautilus.crt /etc/pki/tls/certs/
[root@stapp02 ~]# mv /tmp/nautilus.key /etc/pki/tls/certs/
[root@stapp02 ~]#
[root@stapp02 ~]# # Verify that the two items are indeed moved.
[root@stapp02 ~]#
[root@stapp02 ~]# ls -l /etc/pki/tls/certs/
total 20
lrwxrwxrwx 1 root root   49 Aug  1  2019 ca-bundle.crt -> /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
lrwxrwxrwx 1 root root   55 Aug  1  2019 ca-bundle.trust.crt -> /etc/pki/ca-trust/extracted/openssl/ca-bundle.trust.crt
-rwxr-xr-x 1 root root  610 Aug  9  2019 make-dummy-cert
-rw-r--r-- 1 root root 2516 Aug  9  2019 Makefile
-rw-r--r-- 1 root root 2170 Nov 28 14:29 nautilus.crt
-rw-r--r-- 1 root root 3267 Nov 28 14:29 nautilus.key
-rwxr-xr-x 1 root root  829 Aug  9  2019 renew-dummy-cert
[root@stapp02 ~]#
[root@stapp02 ~]# ls -l /tmp
total 8
-rwx------ 36 root root  836 Aug  1  2019 ks-script-rnBCJB
drwx------  3 root root 4096 Nov 28 14:32 systemd-private-d54328b730db4a9a81f0c97bc3b80e38-nginx.service-BKgLrO
-rw------- 36 root root    0 Aug  1  2019 yum.log
[root@stapp02 ~]#
[root@stapp02 ~]# mv /tmp/nautilus.crt /etc/pki/tls/certs/
mv: cannot stat ‘/tmp/nautilus.crt’: No such file or directory
[root@stapp02 ~]# mv /tmp/nautilus.key /etc/pki/tls/certs/
mv: cannot stat ‘/tmp/nautilus.key’: No such file or directory
[root@stapp02 ~]#
[root@stapp02 ~]#
[root@stapp02 ~]# cat /etc/nginx/nginx.conf
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
        }

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }
    }

# Settings for a TLS enabled server.
#
#    server {
#        listen       443 ssl http2 default_server;
#        listen       [::]:443 ssl http2 default_server;
#        server_name  _;
#        root         /usr/share/nginx/html;
#
#        ssl_certificate "/etc/pki/nginx/server.crt";
#        ssl_certificate_key "/etc/pki/nginx/private/server.key";
#        ssl_session_cache shared:SSL:1m;
#        ssl_session_timeout  10m;
#        ssl_ciphers HIGH:!aNULL:!MD5;
#        ssl_prefer_server_ciphers on;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
#
#        location / {
#        }
#
#        error_page 404 /404.html;
#        location = /404.html {
#        }
#
#        error_page 500 502 503 504 /50x.html;
#        location = /50x.html {
#        }
#    }

}

[root@stapp02 ~]#
[root@stapp02 ~]# cd /etc/nginx/
[root@stapp02 nginx]# ll
total 76
drwxr-xr-x 2 root root 4096 Nov  1 02:02 conf.d
drwxr-xr-x 2 root root 4096 Nov  1 02:02 default.d
-rw-r--r-- 1 root root 1077 Nov  1 02:02 fastcgi.conf
-rw-r--r-- 1 root root 1077 Nov  1 02:02 fastcgi.conf.default
-rw-r--r-- 1 root root 1007 Nov  1 02:02 fastcgi_params
-rw-r--r-- 1 root root 1007 Nov  1 02:02 fastcgi_params.default
-rw-r--r-- 1 root root 2837 Nov  1 02:02 koi-utf
-rw-r--r-- 1 root root 2223 Nov  1 02:02 koi-win
-rw-r--r-- 1 root root 5231 Nov  1 02:02 mime.types
-rw-r--r-- 1 root root 5231 Nov  1 02:02 mime.types.default
-rw-r--r-- 1 root root 2455 Nov  1 02:02 nginx.conf
-rw-r--r-- 1 root root 2656 Nov  1 02:02 nginx.conf.default
-rw-r--r-- 1 root root  636 Nov  1 02:02 scgi_params
-rw-r--r-- 1 root root  636 Nov  1 02:02 scgi_params.default
-rw-r--r-- 1 root root  664 Nov  1 02:02 uwsgi_params
-rw-r--r-- 1 root root  664 Nov  1 02:02 uwsgi_params.default
-rw-r--r-- 1 root root 3610 Nov  1 02:02 win-utf
[root@stapp02 nginx]#
[root@stapp02 nginx]# cat > nginx.conf

# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.

   include /etc/nginx/conf.d/*.conf;

    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
#       EDEN: the App server IP should be here:
        server_name  172.16.238.11;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }

# Settings for a TLS enabled server.

# EDEN:
# SETTING UP SSL FOR NGINX - step 1:
# Uncomment the following lines to setup SSL for NGINX.
# Don't forget to add App server's IP on 'Server Name'

    server {
        listen       443 ssl http2 default_server;
        listen       [::]:443 ssl http2 default_server;
        server_name  172.16.238.11;
        root         /usr/share/nginx/html;

# EDEN:
# SETTING UP SSL FOR NGINX - step 2
# Uncomment the following two lines.
# Change the ssl_certificate and ssl_certificate_key values to the correct path
# This is where the SSL and the certificate key must be located.
# Make sure that both are indeed placed/moved there

        ssl_certificate "/etc/pki/tls/certs/nautilus.crt";
        ssl_certificate_key "/etc/pki/tls/certs/nautilus.key";
                }

#        ssl_session_cache shared:SSL:1m;
#        ssl_session_timeout  10m;
#        ssl_ciphers HIGH:!aNULL:!MD5;
#        ssl_prefer_server_ciphers on;
#
#        # Load configuration files for the default server block.

# EDEN:
# SETTING UP SSL FOR NGINX - step 3
# Uncomment the next line for the changes in the TLS enabled server to take effect.

        include /etc/nginx/default.d/*.conf;
#
#        location / {
#        }
#
#        error_page 404 /404.html;
#            location = /40x.html {
#        }
#
#        error_page 500 502 503 504 /50x.html;
#            location = /50x.html {
#        }
#    }

}
[root@stapp02 nginx]#
[root@stapp02 nginx]#
[root@stapp02 nginx]# cat /etc/nginx/nginx.conf

# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.

   include /etc/nginx/conf.d/*.conf;

    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
#       EDEN: the App server IP should be here:
        server_name  172.16.238.11;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }

# Settings for a TLS enabled server.

# EDEN:
# SETTING UP SSL FOR NGINX - step 1:
# Uncomment the following lines to setup SSL for NGINX.
# Don't forget to add App server's IP on 'Server Name'

    server {
        listen       443 ssl http2 default_server;
        listen       [::]:443 ssl http2 default_server;
        server_name  172.16.238.11;
        root         /usr/share/nginx/html;

# EDEN:
# SETTING UP SSL FOR NGINX - step 2
# Uncomment the following two lines.
# Change the ssl_certificate and ssl_certificate_key values to the correct path
# This is where the SSL and the certificate key must be located.
# Make sure that both are indeed placed/moved there

        ssl_certificate "/etc/pki/tls/certs/nautilus.crt";
        ssl_certificate_key "/etc/pki/tls/certs/nautilus.key";
                }

#        ssl_session_cache shared:SSL:1m;
#        ssl_session_timeout  10m;
#        ssl_ciphers HIGH:!aNULL:!MD5;
#        ssl_prefer_server_ciphers on;
#
#        # Load configuration files for the default server block.

# EDEN:
# SETTING UP SSL FOR NGINX - step 3
# Uncomment the next line for the changes in the TLS enabled server to take effect.

        include /etc/nginx/default.d/*.conf;
#
#        location / {
#        }
#
#        error_page 404 /404.html;
#            location = /40x.html {
#        }
#
#        error_page 500 502 503 504 /50x.html;
#            location = /50x.html {
#        }
#    }

}
[root@stapp02 nginx]#
[root@stapp02 nginx]#
[root@stapp02 nginx]# nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
[root@stapp02 nginx]#
[root@stapp02 nginx]# systemctl enable nginx
[root@stapp02 nginx]# systemctl start nginx
[root@stapp02 nginx]# systemctl restart nginx
[root@stapp02 nginx]# systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2020-11-28 14:36:18 UTC; 7ms ago
  Process: 372 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
  Process: 371 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
  Process: 370 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
 Main PID: 373 (nginx)
   CGroup: /docker/0a0cce77b0ccec39f5ad2027039c858f9b0ce8f7c4a227d0c1363f3617ee6906/system.slice/nginx.service
           ├─373 nginx: master process /usr/sbin/nginx
           ├─374 nginx: worker process
           └─375 nginx: worker process

Nov 28 14:36:18 stapp02 systemd[1]: Forked /usr/sbin/nginx as 372
Nov 28 14:36:18 stapp02 systemd[1]: nginx.service changed start-pre -> start
Nov 28 14:36:18 stapp02 systemd[372]: Executing: /usr/sbin/nginx
Nov 28 14:36:18 stapp02 systemd[1]: Child 372 belongs to nginx.service
Nov 28 14:36:18 stapp02 systemd[1]: nginx.service: control process exited, code=exited status=0
Nov 28 14:36:18 stapp02 systemd[1]: nginx.service got final SIGCHLD for state start
Nov 28 14:36:18 stapp02 systemd[1]: Main PID loaded: 373
Nov 28 14:36:18 stapp02 systemd[1]: nginx.service changed start -> running
Nov 28 14:36:18 stapp02 systemd[1]: Job nginx.service/start finished, result=done
Nov 28 14:36:18 stapp02 systemd[1]: Started The nginx HTTP and reverse proxy server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp02 nginx]#
Display all 771 possibilities? (y or n)
[root@stapp02 nginx]#
[root@stapp02 nginx]# cat /etc/nginx/nginx.conf | grep root
        root         /usr/share/nginx/html;
        root         /usr/share/nginx/html;
[root@stapp02 nginx]# ls -l /usr/share/nginx/html/
total 16
-rw-r--r-- 1 root root 3650 Nov  1 02:01 404.html
-rw-r--r-- 1 root root 3693 Nov  1 02:01 50x.html
lrwxrwxrwx 1 root root   20 Nov 28 14:32 en-US -> ../../doc/HTML/en-US
drwxr-xr-x 2 root root 4096 Nov 28 14:32 icons
lrwxrwxrwx 1 root root   18 Nov 28 14:32 img -> ../../doc/HTML/img
lrwxrwxrwx 1 root root   25 Nov 28 14:32 index.html -> ../../doc/HTML/index.html
-rw-r--r-- 1 root root  368 Nov  1 02:01 nginx-logo.png
lrwxrwxrwx 1 root root   14 Nov 28 14:32 poweredby.png -> nginx-logo.png
[root@stapp02 nginx]# cd /usr/share/nginx/html/
[root@stapp02 html]#
[root@stapp02 html]# rm index.html
rm: remove symbolic link ‘index.html’? y
[root@stapp02 html]#
[root@stapp02 html]# ls -l /usr/share/nginx/html/
total 16
-rw-r--r-- 1 root root 3650 Nov  1 02:01 404.html
-rw-r--r-- 1 root root 3693 Nov  1 02:01 50x.html
lrwxrwxrwx 1 root root   20 Nov 28 14:32 en-US -> ../../doc/HTML/en-US
drwxr-xr-x 2 root root 4096 Nov 28 14:32 icons
lrwxrwxrwx 1 root root   18 Nov 28 14:32 img -> ../../doc/HTML/img
-rw-r--r-- 1 root root  368 Nov  1 02:01 nginx-logo.png
lrwxrwxrwx 1 root root   14 Nov 28 14:32 poweredby.png -> nginx-logo.png
[root@stapp02 html]#
[root@stapp02 html]# cd /usr/share/nginx/html/
[root@stapp02 html]# cat > index.html
Welcome!
[root@stapp02 html]#
[root@stapp02 html]# cat index.html
Welcome!
[root@stapp02 html]# Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.

