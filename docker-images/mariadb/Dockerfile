FROM bitnamilegacy/mariadb:11.8.3-debian-12-r0
LABEL maintainer 'Trey Dockendorf <tdockendorf@osc.edu>'

USER 0
RUN chmod 777 /opt/bitnami/mariadb/tmp && \
    chmod 777 /opt/bitnami/mariadb/logs

EXPOSE 3306
USER 1001
ENTRYPOINT [ "/opt/bitnami/scripts/mariadb/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/mariadb/run.sh" ]
