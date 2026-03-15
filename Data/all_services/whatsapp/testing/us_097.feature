@@smoke @@regression
Feature: Verified Business Request
  As a business owner
  I want to request verification for their business profile
  So that to build trust with customers and access verified-business features

  Background:
    Given the business owner is logged in

  @@smoke @@regression @@happy-path
  Scenario: Submit verification request successfully
    # Happy path: a complete profile with required documents creates a pending verification request
    Given the business profile is complete
    And all required verification documents are available
    When the owner submits a verification request
    Then the system records the request
    And the verification status is shown as "Pending Verification"

  @@regression @@happy-path
  Scenario: Verification review completes successfully
    # Happy path: a pending request is approved and the business becomes verified
    Given a verification request is in "Pending Verification" status
    When the system review is completed successfully
    Then the business status is updated to "Verified"
    And a confirmation is shown to the owner

  @@regression @@negative
  Scenario: Block verification request when profile is incomplete or documents are missing
    # Error scenario: submission is blocked and missing information is listed
    Given the business profile is incomplete or required documents are missing
    When the owner attempts to submit a verification request
    Then the system blocks the submission
    And a message lists the missing information

  @@regression @@negative @@edge-case
  Scenario: Prevent duplicate submission when a request is already pending
    # Edge case: avoid creating duplicate verification requests
    Given a verification request is already in "Pending Verification" status
    When the owner submits another verification request
    Then the system prevents creating a duplicate request
    And a message indicates a request is already pending

  @@regression @@boundary
  Scenario Outline: Submit verification with document count boundary
    # Boundary condition: validate submission when the number of uploaded documents meets or exceeds requirements
    Given the business profile is complete
    And the owner has uploaded <document_count> required documents
    When the owner submits a verification request
    Then the system <expected_result> the submission
    And the system shows <expected_status_or_message>

    Examples:
      | document_count | expected_result | expected_status_or_message |
      | the minimum required | accepts | "Pending Verification" status |
      | one less than the minimum required | blocks | a message listing missing documents |

  @@regression @@boundary
  Scenario Outline: Submit verification with profile completeness boundary
    # Boundary condition: handle profile completeness at minimum required fields
    Given the business profile has <profile_state>
    And all required verification documents are available
    When the owner submits a verification request
    Then the system <expected_result> the submission
    And the system shows <expected_status_or_message>

    Examples:
      | profile_state | expected_result | expected_status_or_message |
      | all required fields completed | accepts | "Pending Verification" status |
      | exactly one required field missing | blocks | a message listing missing information |
