@smoke @regression
Feature: US-080 Zuletzt online - Online-Status Sichtbarkeit
  As a registered user
  I want to configure the visibility of my online status
  So that so that I can control who sees when I was last online and protect my privacy

  Background:
    Given the user is logged in

  @@smoke @@regression @@happy-path
  Scenario: Save online status visibility successfully
    # Verifies that a valid visibility option is stored and applied
    Given the user opens the privacy settings
    When the user selects the visibility option 'public' and saves
    Then the system stores the setting
    And the online status is visible to any user viewing the profile

  @@regression @@happy-path
  Scenario: Online status visibility for contacts only
    # Ensures non-contacts cannot see online status when set to contacts only
    Given the user has set online status visibility to 'contacts only'
    When a non-contact views the user’s profile
    Then the online status is hidden from the non-contact

  @@regression @@happy-path
  Scenario Outline: Save visibility option with scenario outline
    # Validates multiple supported visibility options are saved and applied
    Given the user opens the privacy settings
    When the user selects the visibility option '<option>' and saves
    Then the system stores the setting
    And the online status visibility matches '<option>'

    Examples:
      | option |
      | public |
      | contacts only |

  @@regression @@negative @@error
  Scenario Outline: Reject invalid visibility option
    # Ensures invalid or unsupported options are rejected with an error
    Given the user opens the privacy settings
    When the user attempts to save the invalid visibility option '<invalid_option>'
    Then the system rejects the change
    And an error message is displayed

    Examples:
      | invalid_option |
      | friends only |
      |  |
      | PUBLIC |

  @@regression @@edge-case
  Scenario: Boundary: visibility option list contains only supported values
    # Verifies UI restricts selection to supported options
    Given the user opens the privacy settings
    When the user opens the visibility option selector
    Then only supported options are displayed
    And unsupported options cannot be selected
