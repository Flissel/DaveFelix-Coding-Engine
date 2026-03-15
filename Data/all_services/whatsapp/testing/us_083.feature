@smoke @regression
Feature: Info-Sichtbarkeit konfigurieren
  As a system administrator
  I want to configure the visibility of info/status texts in the system
  So that to control which messages are shown to users and ensure appropriate communication

  Background:
    Given the administrator is authenticated and on the configuration page for info/status texts

  @@smoke @@regression @@happy-path
  Scenario Outline: Display configured info/status text to end users
    # Verifies that a visible text is shown to end users in the relevant context
    Given an info/status text exists for context "<context>" and is currently hidden
    When the administrator sets the text visibility to "visible" and saves the configuration
    Then the system confirms the configuration was saved
    And end users see the text in the "<context>" context

    Examples:
      | context |
      | login page |
      | dashboard |

  @@regression @@happy-path
  Scenario Outline: Hide configured info/status text from end users
    # Verifies that a hidden text is not shown to end users in the relevant context
    Given an info/status text exists for context "<context>" and is currently visible
    When the administrator sets the text visibility to "hidden" and saves the configuration
    Then the system confirms the configuration was saved
    And end users do not see the text in the "<context>" context

    Examples:
      | context |
      | profile page |
      | system status page |

  @@regression @@negative
  Scenario: Prevent saving configuration without required permissions
    # Ensures unauthorized administrators cannot change visibility settings
    Given the administrator account lacks permission to change info/status text visibility
    When the administrator attempts to save changes to visibility settings
    Then the system rejects the change
    And an authorization error message is displayed

  @@regression @@edge-case
  Scenario Outline: Handle no-op save when visibility is unchanged
    # Validates saving without changes does not alter displayed text
    Given an info/status text exists for context "<context>" and is currently "<current_visibility>"
    When the administrator saves the configuration without changing visibility
    Then the system confirms the configuration was saved
    And end users see the text according to "<current_visibility>" in the "<context>" context

    Examples:
      | context | current_visibility |
      | help page | visible |
      | maintenance banner | hidden |

  @@regression @@boundary
  Scenario Outline: Boundary condition: configure maximum number of texts in one save
    # Ensures system supports saving visibility for the maximum allowed texts in a single operation
    Given the system has "<max_count>" configurable info/status texts
    When the administrator sets visibility for all "<max_count>" texts and saves the configuration
    Then the system confirms the configuration was saved
    And end users see each text according to its configured visibility

    Examples:
      | max_count |
      | 100 |
