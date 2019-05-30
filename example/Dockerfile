FROM heyman/postgresql-backup as pg_backup

FROM hannikkala/ssh-tunnel-execute:latest

RUN apk update && apk add postgresql-client

# Install aws-cli
RUN apk -Uuv add groff less python py-pip && pip install awscli
# Cleanup
RUN apk --purge -v del py-pip && rm /var/cache/apk/*

ENV BACKUP_DIR /backups

COPY --from=pg_backup /backup/*.py ./


