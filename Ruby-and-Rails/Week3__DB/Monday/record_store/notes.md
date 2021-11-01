Database Backup
===============

Example for PostgreSQL, database name ```database_name```

Backup:

```pg_dump database_name > database_backup.sql```

Restore:

```shell
create_db database_name
psql database_name < database_backup.sql
crete_db -T database_name database_name_test
```

