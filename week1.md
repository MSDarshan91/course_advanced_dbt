### Task 2: Add docs blocks to populate missing documentation and maintain consistency

Added all the description to `models/docs/docs_bingeflix.md` and referenced the docs blocks in `source_ads_platform.yml` & `source_bingeflix.yml` files.

### Task 3: Install dbt_project_evaluator package to enforce best practices
- I added the missing fct_events.yml file. The file includes the description of the fct_events model and the columns. In addition to that, the unit tests associated with the columns are are also added. This one change resolved the following issues 
    - `valid_documentation_coverage`
    - `is_empty_fct_undocumented_models_`
    - `is_empty_fct_missing_primary_key_tests_`
    - `valid_test_coverage`

- I renamed the mrr model to fct_mrr. Also update the .yml file. This resolved the `is_empty_fct_model_naming_conventions_`. 

- Since we don't have real time data, I disabled the `is_empty_fct_sources_without_freshness_` test. The configuration was added to dbt_project.yml file.

- I added the documentation for ads_platform source table. This resolved the `is_empty_fct_undocumented_sources_` issue. 

- In fct_active_users model, I replaced the reference table from stg_bingeflix__events to fct_events. This helped reolve the `is_empty_fct_model_fanout_` issue. 

### Task 4: Install SQLFluff and run it to fix violations
Installed sqlfluff and fixed the violations with `sqlfluff fix -p0` command.
