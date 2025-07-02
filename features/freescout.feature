Feature: Freescout Ticketing Platform

  # Positive Path
  Scenario: Create a new bug ticket as a user in the platform
    Given the user is logged in to FreeScout
    And the user is in the "Bugs" mailbox
    And the user is on the "New Conversation" page
    When the user fills in the customer email and subject
    And enters a message in the message body
    And clicks the "Send" button
    Then a new ticket is created and appears in the bugs mailbox

  Scenario: Create a new feature ticket as a user in the platform
    Given the user is logged in to FreeScout
    And the user is in the "Features" mailbox
    And the user is on the "New Conversation" page
    When the user fills in the customer email and subject
    And enters a message in the message body
    And clicks the "Send" button
    Then a new ticket is created and appears in the features mailbox

  Scenario: Reply to a customer ticket
    Given a customer ticket exists in the inbox
    And the user is viewing the ticket
    When the user types a reply and clicks "Send"
    Then the reply is added to the conversation
    And the customer is emailed the response

  Scenario: Assign ticket to another user
    Given a ticket is unassigned
    When the user clicks "Assign" and selects another team member
    Then the ticket is assigned to the selected user
    And the assignee is notified

  Scenario: Change ticket status to closed
    Given a ticket is open
    When the user clicks the "Closed" button
    Then the ticket status is changed to "Closed"
    And it is removed from the active inbox view
    And it moves to the "Done" column in the kanban

  Scenario: Tag a ticket with custom label
    Given a ticket exists
    When the user clicks "Tags" and enters "task"
    Then the ticket is labeled with the "task" tag
    And it is searchable by the tag

  Scenario: View only assigned tickets
    Given the user is on the kanban board
    When the user selects their own user in the filter
    Then only tickets assigned to that user are displayed

  Scenario: Search for a ticket by subject
    Given the user is on the kanban page
    When the user types a subject keyword in the search box
    Then tickets matching the subject are displayed
  
  Scenario: Toggle Dark Mode in all modules
    Given the user has access to all modules
    And can see the dark mode toggle
    When the user toggles dark mode on
    Then dark mode is activated across all modules
    When the user toggles dark mode off
    Then dark mode is deactivated and light mode is restored

  Scenario: Mention a team member on a ticket
    Given the user has a ticket open
    When the user "@s" a team member in the ticket
    Then the team member is notified and alerted in the freescout alert system

  '
  Scenario: Recover access using the "Forgot Your Password?" feature
    Given the user has an active FreeScout account
    And the user is on the login page
    When the user clicks the "Forgot Your Password?" link
    Then the user is redirected to the "Reset Password" page
  '

    When the user enters their valid email address
    And clicks the "Send Password Reset Link" button
    Then a "Reset Password" email is sent to the user's inbox

    When the user follows the link in the email
    And sets a new valid password
    Then the user can log in to FreeScout using the new password

  # Negative Path
  Scenario: Attempt to send a ticket without a customer email
    Given the user is on the "New Conversation" page
    When the user leaves the email field blank
    And clicks the "Send" button
    Then an error message is shown stating "This value is required"

  Scenario: Attempt to reply to a closed ticket
    Given a ticket is marked as "Closed"
    And the user tries to send a reply
    Then an error or warning is shown
    And the user is prompted to reopen the ticket

  Scenario: File attachment exceeds size limit
    Given a ticket is being composed
    When the user attaches a file larger than the system limit
    Then an error is shown indicating the file is too large

  Scenario: Attempt to reset account password with incorrect email
    Given a user tries to reset an account password which is not setup as a user
    When the user clickc "Send Password Reset Link"
    Then an error appears "We can't find a user with that e-mail address."