ARG NOMINATIM_VERSION
FROM mediagis/nominatim:$NOMINATIM_VERSION

RUN a2enmod rewrite && \
    chmod -R 777 /var/log/apache2 && \
    sed -i -r 's|^ErrorLog.+|ErrorLog /dev/stderr|g' /etc/apache2/apache2.conf && \
    sed -i '/ports.conf/d' /etc/apache2/apache2.conf && \
    sed -i '/APACHE_RUN_USER/d' /etc/apache2/apache2.conf && \
    sed -i '/APACHE_RUN_GROUP/d' /etc/apache2/apache2.conf && \
    rm -f /etc/apache2/ports.conf && \
    chmod 777 /var/run/apache2
ARG NOMINATIM_UI_VERSION
RUN chmod -R 777 $PROJECT_DIR && \
    mkdir /nominatim-ui && cd /nominatim-ui && \
    curl -L https://github.com/osm-search/nominatim-ui/releases/download/v$NOMINATIM_UI_VERSION/nominatim-ui-$NOMINATIM_UI_VERSION.tar.gz | tar -xz --strip-components 1

WORKDIR /app

EXPOSE 5432
EXPOSE 8080
