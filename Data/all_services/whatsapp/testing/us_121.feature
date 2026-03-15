@@smoke @@regression
Feature: Meta AI Chat
  As a registered user
  I want to start a chat with the integrated AI assistant and submit questions
  So that to receive immediate guidance and information without leaving the system

  Background:
    Given the user is logged in
    And the AI assistant is available

  @@smoke @@regression @@happy-path
  Scenario Outline: Successful AI response for valid questions
    # Verify the system returns an AI-generated response for valid questions
    Given the user opens the AI chat
    When the user submits the question "<question>"
    Then the system returns an AI-generated response within the acceptable time
    And the response is displayed in the chat window

    Examples:
      | question |
      | How do I reset my password? |
      | What are the support hours? |

  @@regression @@negative @@edge
  Scenario Outline: Reject empty or unsupported questions
    # Validate that invalid queries are blocked without sending a request
    Given the user opens the AI chat
    When the user submits the question "<question>"
    Then the system prompts the user to enter a valid question
    And no request is sent to the AI service

    Examples:
      | question |
      |  |
      |     |
      | <unsupported> |

  @@regression @@negative @@error
  Scenario Outline: Handle AI service unavailability or timeout
    # Ensure the system shows an error and allows retry when the AI service fails
    Given the user opens the AI chat
    And the AI service is unavailable or times out
    When the user submits the question "<question>"
    Then the system displays an error message
    And the user is allowed to retry the request

    Examples:
      | question |
      | Explain account security best practices |

  @@regression @@boundary
  Scenario Outline: Boundary validation for question length
    # Verify behavior at minimum and maximum allowed question lengths
    Given the user opens the AI chat
    When the user submits a question with length "<lengthType>"
    Then the system processes the question and returns a response within the acceptable time

    Examples:
      | lengthType |
      | minimum allowed |
      | maximum allowed |
