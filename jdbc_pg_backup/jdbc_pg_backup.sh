#!/bin/bash
set -ex

java -cp "target/jdbc_pg_backup-1.0-SNAPSHOT.jar:target/lib/*" jdbcpgbackup.JdbcPgBackup $@
