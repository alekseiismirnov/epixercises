# Assorted Notes #

## Database Backup ##

Example for PostgreSQL, database name ```database_name```

Backup:

```pg_dump database_name > database_backup.sql```

Restore:

```bash
create_db database_name
psql database_name < database_backup.sql
crete_db -T database_name database_name_test
```

## To Learn ##

Seems not so long:

- [ ] Ruby libs handling
- [x] Markdown. Just have a reference card would be enough.

Long:

- [ ] Ruby methaprogramming
