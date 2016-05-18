# ToyCity 4 - Udacidata

## To run unit tests:
-- `ruby tests/analyzable_test.rb`
-- `ruby tests/udacidata_test.rb`

## To run the main app:
`ruby app.rb`

* **Udacidata**: The `Udacidata` class has all of the required methods correctly implemented. Each method returns the expected return values outlined in the lesson and in `udacidata_test.rb`.
    * `all`
    * `create`
    * `first` and `first(n)`
    * `last` and `last(n)`
    * `destroy`
    * `update`
    * `find` and `find_by_#{attribute}`
    * `where`
* **Modules**: The `Analyzable` module contains all of the required methods correctly implemented. Each method returns the expected return values outlined in the lesson and in `analyzable_test.rb`
    * `count_by_brand`
    * `count_by_name`
    * `average_price`
    * `print_report`
* **Seeds**: The Faker gem is used to generate fake data in the `db_seed` method inside `seeds.rb`. `db_seed` populates the database with 10 new `Product`s.
* **Test-Driven-Development**: The student uses TDD and all of the tests in both `udacidata_test.rb` and `analyzable_test.rb` pass.
* **Modules**: The `Analyzable` module contains all of the required methods correctly implemented.
* **Final Output**: The code in `app.rb` is uncommented after the tests pass and outputs the expected return values to the terminal. (Code demonstrating error handling can remain commented out.)
* **Errors**: `ProductNotFoundError` is raised when non-existent product IDs are passed in as arguments.
* **.gitignore**: Files like `.DS_Store` and `data.csv` are added and ignored using a `.gitignore`
