ARG VERSION
FROM bitnami/postgresql:$VERSION
LABEL maintainer 'Trey Dockendorf <tdockendorf@osc.edu>'

USER 0
RUN chmod -R o=u /opt/bitnami/postgresql/conf && \
    chmod -R o=u /opt/bitnami/postgresql/tmp && \
    chmod -R o=u /opt/bitnami/postgresql/logs

VOLUME [ "/bitnami/postgresql", "/docker-entrypoint-initdb.d", "/docker-entrypoint-preinitdb.d" ]
EXPOSE 5432
USER 1001
ENTRYPOINT [ "/opt/bitnami/scripts/postgresql/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/postgresql/run.sh" ]
