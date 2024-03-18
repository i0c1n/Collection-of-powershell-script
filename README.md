This script provides a configuration menu for managing Office 365 (O365) users and their settings. Here's a quick summary of what it does:
          ShowMenu Function: Displays a menu with options for O365 configuration tasks like connecting to Microsoft Teams, checking users' phone numbers, configuring users, and resetting users.
	  ExecuteAction Function: Executes the action selected by the user.
		
    Main Loop: Continuously prompts the user for input while the script runs.
		Options Handling:
	•	Option 1: Connects to Microsoft Teams.
	•	Option 2: Prompts for a user's phone number and displays user information based on the provided number.
	•	Option 3: Configures a user by setting their phone number, granting Teams calling policy, assigning a tenant dial plan, and assigning an online voice routing policy.
	•	Option 4: Resets a user by removing their phone number assignment.
	•	Other Input Handling: Handles invalid input and provides options to show the menu, quit the script, or clear the console.
		Sleep: Adds a short delay after each operation.

Overall, the script offers a simple menu-driven interface to perform common O365 user management tasks like connecting, checking, configuring, and resetting users.
