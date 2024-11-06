#!/bin/sh

set -eux

docker compose exec zotprime-dataserver sh -cux 'cd /var/www/zotero/misc && ./init-mysql.sh'
#docker compose exec zotprime-dataserver sh -cux 'cd /var/www/zotero/misc && ./db_update.sh'
docker compose exec zotprime-dataserver sh -cux 'aws --endpoint-url "http://minio:9000" s3 mb s3://zotero'
docker compose exec zotprime-dataserver sh -cux 'aws --endpoint-url "http://minio:9000" s3 mb s3://zotero-fulltext'
docker compose exec zotprime-dataserver sh -cux 'aws --endpoint-url "http://localstack:4575" sns create-topic --name zotero'
docker compose exec zotprime-dataserver sh -cux 'cd /var/www/zotero/admin && php schema_update'
