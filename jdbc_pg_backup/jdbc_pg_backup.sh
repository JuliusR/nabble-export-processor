#!/usr/bin/env -S bash -euxET -o pipefail -O inherit_errexit

java -cp "target/jdbc_pg_backup-1.0-SNAPSHOT.jar:target/lib/*" jdbcpgbackup.JdbcPgBackup $@
