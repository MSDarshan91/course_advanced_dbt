### Task 1: Identify a few redundant tests that can be removed

- I identified that the staging models with one to one relationships with the source tables have redundant tests, since the tests on columns are already performed on the source tables. [Commit](https://github.com/lindsaymurphy4/course_advanced_dbt/commit/12accf5363d08a33eb6537741876de8d232c8230)


### Task 2: Write a custom generic test to replace a redundant singular test

- Created the generic test [here](https://github.com/MSDarshan91/course_advanced_dbt/blob/main/tests/generic/assert_valid_column_value.sql).
- Used the test in the .yml file [here](https://github.com/MSDarshan91/course_advanced_dbt/blob/main/models/staging/bingeflix/source_bingeflix.yml#L29).
<img width="861" alt="Screenshot 2024-09-13 at 8 59 21 AM" src="https://github.com/user-attachments/assets/b14c8502-c3ed-4f0b-9ba6-2a6772f2037a">


### Task 3: Write a unit test to verify the logic of a transformation
- Created the unit test [here](https://github.com/MSDarshan91/course_advanced_dbt/blob/main/models/unit_tests/test_dim_users_age_at_acquisition.yml)
- When I changed the expected value to `50` ,  here is the result of the `dbt build ` command. 
<img width="938" alt="Screenshot 2024-09-13 at 9 21 58 AM" src="https://github.com/user-attachments/assets/fbbc9737-38c9-472c-89cc-1abe5131e77f">

### Task 4: Unit test to confirm correct mrr calculation
- Created the unit test [here](https://github.com/MSDarshan91/course_advanced_dbt/blob/main/models/unit_tests/test_mrr.yml)
- Here is an example when the test failed,
<img width="1291" alt="Screenshot 2024-09-13 at 10 30 19 AM" src="https://github.com/user-attachments/assets/8bbe478b-939e-4eb0-b34f-740c408cb14c">
