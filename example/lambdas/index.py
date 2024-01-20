import os

from aws_lambda_powertools import Logger
from pyiceberg.catalog import load_catalog

DATABASE = os.getenv("DATABASE", "")
TABLE = os.getenv("TABLE", "")
logger = Logger()

catalog = load_catalog("glue", **{"type": "glue"})


@logger.inject_lambda_context(log_event=True)
def lambda_handler(event, context):
    try:
        logger.info(catalog.list_namespaces())
        logger.info(catalog.list_tables(DATABASE))
        table = catalog.load_table(f"{DATABASE}.{TABLE}")
        logger.info(table.metadata)
        logger.info(table.scan())
    except Exception as e:
        logger.exception(e)
        raise e
