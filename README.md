# TradeFlow

An end-to-end data engineering pipeline that extracts e-commerce data, loads it to S3, and transforms it using dbt + Snowflake.

## Architecture

```
DummyJSON API → Python Extract → S3 (Raw) → Snowflake → dbt Transforms → Analytics
```

**Orchestration:** Apache Airflow (Dockerized)

## Tech Stack

- **Orchestration:** Apache Airflow 2.9
- **Extract:** Python + boto3
- **Storage:** AWS S3
- **Warehouse:** Snowflake
- **Transform:** dbt-core + dbt-snowflake

## Project Structure

```
├── airflow/           # Airflow docker-compose & DAGs
│   ├── dags/          # Pipeline definitions
│   └── docker-compose.yaml
├── dbt/               # dbt models
│   ├── models/
│   │   ├── staging/   # Raw data cleaning
│   │   ├── intermediate/  # Business logic
│   │   └── marts/     # Analytics-ready tables
│   └── profiles.yml   # (gitignored - contains credentials)
├── ingestion/         # Python extraction scripts
└── data/              # Sample data
```

## Setup

### 1. Environment Variables

Copy `.env.example` to `.env` and fill in your credentials:

```bash
cp .env.example .env
cp .env airflow/.env
```

### 2. Install Dependencies

```bash
python -m venv venv
source venv/Scripts/activate  # Windows
pip install -r requirements.txt
```

### 3. Start Airflow

```bash
cd airflow
docker compose up -d
```

Access UI at http://localhost:8080 (airflow/airflow)

### 4. Configure dbt

Create `dbt/profiles.yml` with your Snowflake credentials (see `.env.example` for required values).

## Data Models

| Model | Description |
|-------|-------------|
| `stg_products` | Cleaned product catalog |
| `stg_users` | Cleaned user data |
| `stg_carts` | Cleaned cart/order data |
| `int_cart_products` | Cart items with product details |
| `mart_customer_summary` | Customer analytics |
| `mart_product_performance` | Product metrics |
| `mart_inventory_health` | Inventory insights |