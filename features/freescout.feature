Feature: Freescout Ticketing Platform

  # Positive Path
  Scenario: Create a new ticket as an agent
    Given the agent is logged in to FreeScout
    And the agent is on the "New Conversation" page
    When the agent fills in the customer email and subject
    And enters a message in the message body
    And clicks the "Send" button
    Then a new ticket is created and appears in the inbox

  Scenario: Reply to a customer ticket
    Given a customer ticket exists in the inbox
    And the agent is viewing the ticket
    When the agent types a reply and clicks "Send"
    Then the reply is added to the conversation
    And the customer is emailed the response

  Scenario: Assign ticket to another agent
    Given a ticket is unassigned
    When the agent clicks "Assign" and selects another team member
    Then the ticket is assigned to the selected agent
    And the assignee is notified

  Scenario: Change ticket status to closed
    Given a ticket is open
    When the agent clicks the "Close" button
    Then the ticket status is changed to "Closed"
    And it is removed from the active inbox view

  Scenario: Tag a ticket with custom label
    Given a ticket exists
    When the agent clicks "Tags" and enters "Billing"
    Then the ticket is labeled with the "Billing" tag
    And it is searchable by the tag

  Scenario: View only assigned tickets
    Given the agent is on the ticket list page
    When the agent selects the "Assigned to Me" filter
    Then only tickets assigned to that agent are displayed

  Scenario: Search for a ticket by subject
    Given the agent is on the ticket list page
    When the agent types a subject keyword in the search box
    Then tickets matching the subject are displayed


  # Negative Path
  Scenario: Attempt to send a ticket without a customer email
    Given the agent is on the "New Conversation" page
    When the agent leaves the email field blank
    And clicks the "Send" button
    Then an error message is shown stating "Customer email is required"

  Scenario: Attempt to reply to a closed ticket
    Given a ticket is marked as "Closed"
    And the agent tries to send a reply
    Then an error or warning is shown
    And the agent is prompted to reopen the ticket

  Scenario: File attachment exceeds size limit
    Given a ticket is being composed
    When the agent attaches a file larger than 10MB
    Then an error is shown indicating the file is too large
