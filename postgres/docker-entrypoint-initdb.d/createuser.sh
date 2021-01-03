#!/usr/bin/env -S bash -euxET -o pipefail -O inherit_errexit

if [ -z "$NABBLE_EXPORT_PROCESSOR_SCHEMA" ]; then
    >&2 echo "ERROR: found empty value of NABBLE_EXPORT_PROCESSOR_SCHEMA"
    exit 1
fi

createuser $NABBLE_EXPORT_PROCESSOR_SCHEMA

echo "successfully created $NABBLE_EXPORT_PROCESSOR_SCHEMA"
