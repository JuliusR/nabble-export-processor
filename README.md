# Nabble Export Processor

## Quickstart

```
[ -f .env ] || cp SAMPLE.env .env

# configure NABBLE_EXPORT_PROCESSOR_SCHEMA
$EDITOR .env

source .env

if [ -z "$NABBLE_EXPORT_PROCESSOR_SCHEMA" ]; then
    >&2 echo "ERROR: found empty value of NABBLE_EXPORT_PROCESSOR_SCHEMA"
    exit 1
fi

# prepare the stuff that requires an internet connection
docker-compose build
docker-compose pull

# now, we can disable the internet connection

# cp ~/Downloads/my-export-from-nabble.zip ./DATA/original-export.zip

docker-compose up -d postgres

# wait for database initialization
sleep 10

# import Nabble's export to database
docker-compose run jdbc_pg_backup

# optionally, inspect the database
docker-compose up -d adminer
xdg-open http://localhost:8080/

# export to other formats
docker-compose exec postgres su -c /POSTPROCESS.sh postgres

sudo chown -R $(id -u):$(id -g) DATA

docker-compose down

# containers, volumes, and images may be left behind
```

## Caveats

This is far away from a clean solution

- there is something wrong with the encoding
- limited to small exports (mine had about 5k messages)
- postprocessing outputs are redundant, format should be configurable
  - eml output contains real eml emails iff the message source is an email (as opposed to web post)
- ... (lots more)
