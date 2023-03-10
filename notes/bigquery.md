# Bigquery

Get all labels from datasets

```sql
SELECT
  *
FROM
  INFORMATION_SCHEMA.SCHEMATA_OPTIONS
WHERE
  option_name = "labels"
```
