### Task 1: Add SQLFluff to pre-commit hook

- set up pre commit initially and fixed all the issues. [Commit](https://github.com/lindsaymurphy4/course_advanced_dbt/commit/9f12425e3bd1c1ef1a527d61fef3a37f840e3704). 
- Testing pre commit hook with sqlfluff. <img width="1427" alt="Screenshot 2024-09-06 at 8 40 49 AM" src="https://github.com/user-attachments/assets/21765bc0-85e5-41be-927b-1b08e68eaace">

### Task 2: Add dbt-checkpoint pre-commit hook

- Changes associated with the dbt-checkpoint pre commit hook are in this [commit](https://github.com/lindsaymurphy4/course_advanced_dbt/commit/0a616b02b7340afb58672282f3ceee5970b38653).
    - The dbt-checkpoint pre commit hook made us aware that the descriptions of 2 columns in the dim_users model was missing and we needed to add them before pushing the changes.
      <img width="936" alt="Screenshot 2024-09-06 at 8 53 47 AM" src="https://github.com/user-attachments/assets/c9b21436-dcd5-4f8a-9713-189c3719679a">
- Testing Tags on models present in the core folder. [Commit](https://github.com/lindsaymurphy4/course_advanced_dbt/commit/bf5a07a6aa550bb9792a3d4530775d0fdc2cdbf4).
  <img width="941" alt="Screenshot 2024-09-06 at 9 11 56 AM" src="https://github.com/user-attachments/assets/c69145f8-56ad-4b83-bf75-f80993b081fa">

### Task 3: Generalize a custom macro
- Updated the rolling_aggregation_n_periods macro. https://github.com/MSDarshan91/course_advanced_dbt/blob/main/macros/rolling_aggregation_n_periods.sql
- Used the macro in fct_subscription_plans_monthly_report model https://github.com/MSDarshan91/course_advanced_dbt/blob/main/models/marts/product/fct_subscription_plans_monthly_report.sql

### Task 4: Write a custom macro to improve another part of the codebase
- Added a new truncate_to_month macro https://github.com/MSDarshan91/course_advanced_dbt/blob/main/macros/truncate_to_month.sql 
- Used the macro in fct_mrr model https://github.com/MSDarshan91/course_advanced_dbt/blob/main/models/marts/finance/fct_mrr.sql 

