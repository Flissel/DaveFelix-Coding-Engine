@smoke @regression
Feature: Lokale Sticker
  As a registered customer
  I want to browse and select region-specific sticker packs
  So that so that I can personalize my messages with locally relevant content

  Background:
    Given the customer is registered and logged in
    And the sticker store is available

  @happy-path @smoke @regression
  Scenario Outline: Display region-specific sticker packs when a region is selected
    # Happy path for selecting a region and viewing its sticker packs
    Given the sticker store shows a list of available regions
    When the customer selects the region "<region>"
    Then the system displays sticker packs specific to "<region>"
    And no sticker packs from other regions are shown

    Examples:
      | region |
      | Bavaria |
      | California |

  @happy-path @regression
  Scenario Outline: Pre-filter sticker packs based on customer's profile region
    # Happy path for highlighting or pre-filtering by profile region
    Given the customer has "<profile_region>" set in their profile
    When the customer opens the sticker store
    Then sticker packs for "<profile_region>" are highlighted or pre-filtered
    And the selected region filter shows "<profile_region>"

    Examples:
      | profile_region |
      | Tokyo |
      | Ontario |

  @edge-case @regression
  Scenario Outline: No sticker packs available for selected region
    # Edge case when the selected region has no packs
    Given the region "<region>" has no sticker packs
    When the customer selects the region "<region>"
    Then the system shows a message indicating no regional packs are available
    And the system offers an option to view all packs

    Examples:
      | region |
      | Antarctica |

  @negative @regression
  Scenario Outline: Handle invalid region selection
    # Error scenario for selecting a region not in the available list
    Given the available regions list does not include "<invalid_region>"
    When the customer attempts to select "<invalid_region>"
    Then the system prevents the selection and shows an error message
    And the region filter remains unchanged

    Examples:
      | invalid_region |
      | Atlantis |

  @boundary @regression
  Scenario Outline: Boundary condition for regions list size
    # Boundary test for minimum and maximum number of available regions
    Given the sticker store has "<region_count>" available regions
    When the customer opens the region selector
    Then all "<region_count>" regions are displayed without truncation
    And the customer can select any listed region

    Examples:
      | region_count |
      | 1 |
      | 50 |
