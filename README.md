# pelican-panel

This repository was created in order to share a fix in pelican panel related to permissions issues.<br>
It is set to use the *root* user, but change it as you see fit.

---

Build it manually or use the Docker image: `docker.io/energypatrikhu/pelican-panel`

```yaml
services:
  panel:
    # build:
    #   dockerfile_inline: |
    #     FROM ghcr.io/pelican/panel:latest
    #     USER root
    #     RUN sed -i 's/^\[supervisord\]/\[supervisord\]\nuser=root/' /etc/supervisord.conf
    #     RUN sed -i 's/php-fpm -F/php-fpm -F -R/' /etc/supervisord.conf
    #     RUN sed -i 's/user = www-data/user = root/g' /usr/local/etc/php-fpm.d/www.conf
    #     RUN sed -i 's/group = www-data/group = root/g' /usr/local/etc/php-fpm.d/www.conf
    image: docker.io/energypatrikhu/pelican-panel:latest
    container_name: pelican-panel
    restart: unless-stopped
    user: 0:0
    networks:
      - pelican
    env_file:
      - .env
    volumes:
      - /etc/ssl/certs:/etc/ssl/certs:ro
      - ./data/panel/data:/pelican-data
      - ./data/panel/logs:/var/www/html/storage/logs
      - ./data/panel/plugins:/var/www/html/plugins
    healthcheck:
      test: ["CMD", "curl", "http://localhost:80"]
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s

networks:
  pelican:
    name: pelican
    driver_opts:
      com.docker.network.bridge.name: pelican
 ```

## Credits
[Pelican Panel](https://github.com/pelican-dev/panel)
