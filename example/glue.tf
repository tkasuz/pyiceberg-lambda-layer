resource "aws_glue_catalog_database" "this" {
  name = "iceberg-database"
}

resource "aws_glue_catalog_table" "this" {
  name          = "iceberg-table"
  database_name = aws_glue_catalog_database.this.name
  parameters = {
    "format" = "parquet"
  }
  table_type = "EXTERNAL_TABLE"
  open_table_format_input {
    iceberg_input {
      metadata_operation = "CREATE"
    }
  }

  storage_descriptor {
    location = "s3://${aws_s3_bucket.this.id}"
    columns {
      name = "id"
      type = "string"
    }
    columns {
      name = "name"
      type = "string"
    }
  }
}
