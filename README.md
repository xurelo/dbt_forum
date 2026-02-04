# dbt_test_copilot

This project demonstrates a dbt project for a simple post site with users, posts, comments and likes.

Structure:
- data/: seed CSVs for raw tables (raw_users, raw_posts, raw_comments, raw_likes)
- models/staging/: staging models for each raw table
- models/marts/: marts with aggregated metrics and time series

How to run:
1. Configure `profiles.yml` with your Postgres connection
2. Install dbt: pip install dbt-postgres (or use homebrew)
3. Run seeds: dbt seed
4. Run models: dbt run
5. Run tests: dbt test

Tests:
- Not null and unique constraints on primary id fields
- Not null constraints on important foreign keys and date fields

Notes:
- Models use recommended project structure with staging and marts
- Seeds are configured to be loaded into `raw` schema

## Cómo cargar los seeds

1. Asegúrate de tener configurado el archivo de conexión: [profiles.yml](profiles.yml).  
2. Los seeds están en la carpeta [data/](data/) (archivos: [data/raw_users.csv](data/raw_users.csv), [data/raw_posts.csv](data/raw_posts.csv), [data/raw_comments.csv](data/raw_comments.csv), [data/raw_likes.csv](data/raw_likes.csv)).  
3. Cargar todos los seeds:
   ```sh
   dbt seed

4. Cargar un seed específico.
   dbt seed --select raw_users

   Si tu profiles.yml está en la raíz: 
   dbt seed --profiles-dir .
