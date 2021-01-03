#!/bin/bash
set -ex

pg_dump -F tar -f /DATA/backup.tar postgres

pg_dump -F plain -f /DATA/backup.sql postgres

tmp1=$(mktemp -d -p /DATA)
tmp2=$(mktemp -d -p /DATA)

ids=$(psql -d postgres -At -c "
    SET search_path to $NABBLE_EXPORT_PROCESSOR_SCHEMA;
    SELECT node_id FROM node_msg;
")

set +x

for id in $ids; do
    echo $id

    psql -d postgres -At -c "
        SET search_path to $NABBLE_EXPORT_PROCESSOR_SCHEMA;
        SELECT message FROM node_msg WHERE node_id=$id;
    " -o $tmp1/$id.eml

    iconv -f UTF-8 -t ISO88591 -o $tmp2/$id.fixed.eml $tmp1/$id.eml \
    || iconv -f UTF-8 -t UTF-8 -o $tmp2/$id.unfixed.eml $tmp1/$id.eml
done
