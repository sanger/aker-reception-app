@javascript

Feature: Test wrong manifest CSV file

Because I am a collaborator working remotely
And I want to send samples to an internal contact at the institute
I want to to provide all the needed information required for my contact

Background:

Given I have defined labware of type "ABgene AB_0800"
And I have the internal contact "test@test"
And I am logged in
And I have a material service running

Scenario:

Given I visit the homepage

And I click on "Create New Submission"
# For some reason this tests needs us to click on the "Create New Submission"
# twice to move onto the next screen
And I click on "Create New Submission"

Then I am in "Container Type"

Given I select a type of labware
And I want to create 1 labware
And I click on "Next"

Then I am in "Biomaterial Metadata"

Given I upload the file "test/data/incorrect_manifest.csv"
Then I should see "Select CSV mappings"
Then "required-fields" should contain "Position (position)"
Then "required-fields" should contain "Scientific name (scientific_name)"
Then "required-fields" should contain "Supplier name (supplier_name)"
Then "required-fields" should contain "Gender (gender)"
Then "required-fields" should contain "Donor ID (donor_id)"
Then "required-fields" should contain "Phenotype (phenotype)"


Then "fields-from-csv" should contain "Well Positio"
Then "fields-from-csv" should contain "Material"
Then "fields-from-csv" should contain "Dono"
Then "fields-from-csv" should contain "ender"
Then "fields-from-csv" should contain "Common Name"
Then "fields-from-csv" should contain "Phenotyp"

Then "matched-fields-table" should contain 0 rows

When I select "Position (position)" from the "required-fields" select
Then "Position (position)" should be selected for "required-fields"

When I select "Well Positio" from the "fields-from-csv" select
Then "Well Positio" should be selected for "fields-from-csv"

Given I click on "match-fields-button"
Then "matched-fields-table" should contain 1 rows

When I select "Scientific name (scientific_name)" from the "required-fields" select
When I select "Material" from the "fields-from-csv" select

Given I click on "match-fields-button"
Then "matched-fields-table" should contain 2 rows

When I select "Supplier name (supplier_name)" from the "required-fields" select
When I select "Common Name" from the "fields-from-csv" select

Given I click on "match-fields-button"
Then "matched-fields-table" should contain 3 rows

When I select "Gender (gender)" from the "required-fields" select
When I select "ender" from the "fields-from-csv" select

Given I click on "match-fields-button"
Then "matched-fields-table" should contain 4 rows

When I select "Donor ID (donor_id)" from the "required-fields" select
When I select "Dono" from the "fields-from-csv" select

Given I click on "match-fields-button"
Then "matched-fields-table" should contain 5 rows

When I select "Phenotype (phenotype)" from the "required-fields" select
When I select "Phenotyp" from the "fields-from-csv" select

Given I click on "match-fields-button"
Then "matched-fields-table" should contain 6 rows

Given I click on "complete-csv-matching"

Then I should see data from my file like "blood"
Then I should see data from my file like "female"
Then I should see data from my file like "homo sapien"

When I go to next screen
Then I should see validation errors