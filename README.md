#ComputerCraft Railway System Status and Announcement System (CRSSAS)
Description

CRSSAS is a ComputerCraft-based system designed to manage and display the status and announcements for a railway system. The system consists of a server and multiple clients, providing real-time updates and announcements across the network.
##Features

Server: Manages the railway system status and broadcasts updates to clients.
Client: Displays the status and announcements on a 2x3 monitor.
Announcements: Supports large announcements and custom messages.
Status Updates: Displays the railway status

##Requirements

Server: Requires a wireless modem and must be chunk-loaded.
Client: Requires a 2x3 monitor and a wireless modem (preferably ender).

##Installation

###Server:
Place the server.lua script on a ComputerCraft computer.
provide it with Poster Files which consist of a image file(.nfp) and a text file(optional)
Ensure the computer has a wireless modem attached.
Run the script on the server computer.

###Client:
Place the client.lua script on a ComputerCraft computer.
Attach a 2x3 monitor and a wireless modem to the computer.
Run the script on the client computers.

##Usage
##Server

Start the server: Run the server.lua script on the server computer.
Configure GUI: Use the GUI to add lines and customize the status messages.
Broadcast updates: Press Send to update the information on all conencted clients

##Client

Start the client: Run the client.lua script on the client computers.
Display status: The client will receive updates from the server and display them on the monitor.
View announcements: Large announcements can be displayed on a separate screen if configured.
    
##Poster Image and Text Format

Poster Image: The poster image file must be 18x19 pixels. You can use this tool to achieve the desired file format.
Text File Format: The text file associated with the poster image should follow this format:
|xPosition|yPosition|The text|text color|background color|

##License

This project is licensed under the MIT License.
Authors

    Stacode

For more details, refer to the source code comments in server.lua and client.lua or make an issue.
