@@smoke @@regression
Feature: Kontakt hinzufuegen
  As a end user
  I want to add a new contact through different available methods
  So that so that I can save contacts using the most convenient option and maintain my contact list efficiently

  Background:
    Given the user is on the contact management page

  @@smoke @@regression @@happy-path
  Scenario: Create contact using standard form with valid data
    # Verifies a contact is created and listed when using the standard form
    When the user submits the standard contact form with valid data
    Then the contact is created successfully
    And the new contact appears in the contact list

  @@regression @@happy-path
  Scenario Outline: Create contact using alternative methods with valid data
    # Verifies contacts can be created via import, scan, or quick add
    When the user adds a contact using the "<method>" method with valid data
    Then the contact is created successfully
    And the new contact appears in the contact list

    Examples:
      | method |
      | import |
      | scan |
      | quick add |

  @@regression @@negative
  Scenario Outline: Prevent contact creation when required data is missing or invalid
    # Ensures validation errors are shown and no contact is created for invalid input
    When the user submits a contact using the "<method>" method with invalid or missing "<field>"
    Then the system prevents the contact from being created
    And a clear validation error message is displayed for "<field>"

    Examples:
      | method | field |
      | standard form | name |
      | standard form | email |
      | import | phone |

  @@regression @@edge-case
  Scenario Outline: Boundary conditions for contact field lengths and formats
    # Verifies system behavior at minimum and maximum allowed field sizes
    When the user submits the standard contact form with "<field>" set to "<value>"
    Then the system validates the "<field>" according to boundary rules
    And the contact is created only when the "<field>" value is within allowed limits

    Examples:
      | field | value |
      | name | A |
      | name | AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA |
      | phone | +1234567890 |
      | phone | 123 |
