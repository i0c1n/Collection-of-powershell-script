This script provides a configuration menu for managing users and their settings in Office 365 (O365). Here's a quick summary of its operation:

ShowMenu Function: Displays a menu with options for O365 configuration tasks such as connecting to Microsoft Teams, checking users' phone numbers, configuring users, resetting users, and getting user details.

ExecuteAction Function: Executes the action selected by the user.

GetUserDetails Function: Allows getting details of a user by entering their name.

Main Loop: Continuously prompts the user for input while the script is running.

Options Handling:

Option 1: Connects to Microsoft Teams.
Option 2: Prompts for a user's phone number and displays user information based on the provided number.
Option 3: Configures a user by setting their phone number, granting a Teams calling policy, assigning a tenant dial plan, and assigning an online voice routing policy.
Option 4: Resets a user by removing their phone number assignment.
Option 5: Gets details of a user by entering their name.
Other Input Handling: Handles invalid input and provides options to show the menu, quit the script, or clear the console.

Sleep: Adds a short delay after each operation.

This script offers a simple menu-driven interface to perform common O365 user management tasks such as connection, checking, configuration, and resetting of users, as well as obtaining their details.
