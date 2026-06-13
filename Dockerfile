FROM ghcr.io/pelican-dev/panel

#
# These changes allow php-fpm to run as root and supervisord to use root user,
# fixing the permission issues in the container
#

# Set user to root
USER root

# add "user=root" to /etc/supervisord.conf
RUN sed -i 's/^\[supervisord\]/\[supervisord\]\nuser=root/' /etc/supervisord.conf

# replace "php-fpm -F" with "php-fpm -F -R" to allow php-fpm to run as root
RUN sed -i 's/php-fpm -F/php-fpm -F -R/' /etc/supervisord.conf

# set php-fpm user to root
RUN sed -i 's/user = www-data/user = root/g' /usr/local/etc/php-fpm.d/www.conf
RUN sed -i 's/group = www-data/group = root/g' /usr/local/etc/php-fpm.d/www.conf
