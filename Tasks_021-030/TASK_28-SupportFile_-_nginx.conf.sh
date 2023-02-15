

    include /etc/nginx/conf.d/*.conf;

    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
#	the App server IP should be here:
        server_name  172.16.238.10;
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

# SETTING UP SSL FOR NGINX - step 1:
# Uncomment the following lines to setup SSL for NGINX. 
# Don't forget to add App server's IP on 'Server Name'

    server {
        listen       443 ssl http2 default_server;
        listen       [::]:443 ssl http2 default_server;
        server_name  172.16.238.10;
        root         /usr/share/nginx/html;
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