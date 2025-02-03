# ComputerCraft Railway System Status and Announcement System (CRSSAS)

## Description

CRSSAS is a ComputerCraft-based system designed to manage and display railway system status and announcements.

## Features

- **Server:** Manages the railway system status and broadcasts updates.
- **Client:** Displays the status and announcements on a 2x3 monitor.
- **Announcements:** Supports large announcements and custom messages.
- **Status Updates:** Displays the line status.

## Requirements

- **Server:** Requires a wireless modem and must be chunk-loaded.
- **Client:** Requires a 2x3 monitor and a wireless modem (preferably wireless).

## Installation

### Server
1. Place the `server.lua` and `basalt.lua` script on a ComputerCraft computer.
2. Provide it with Poster Files which consist of an image(see format below)
3. Ensure the computer has a wireless modem attached.
4. Run the script on the server computer.

### Client
1. Place the `client.lua` script on a ComputerCraft computer.
2. Attach a 2x3 monitor and a wireless modem to the computer.
3. Run the script on the client computers.

## Usage

### Server
1. Start the server: Run the `server.lua` script on the server computer.
2. I recomend adding `startup.lua` to the computer to automaticlly run the code
3. Configure GUI: Use the GUI to add lines and customize.
4. Broadcast updates: Press Send to update the information on all clients.

### Client
1. Start the client: Run the `client.lua` script on the client computer.
2. I recomend adding `startup.lua` to the computer to automaticlly run the code
3. Display status: The client will receive updates from the server.
4. View announcements: Large announcements can be displayed on a separate screen.

## Current Limitations:

### The status screen
The status screen uses the "Poster1" file for the background and static texts but the status information are currently hardcoded int place so i recomend using the same poster image as provided in the repo.





## Poster Image and text file format
Poster Image: 
The poster image file must be 18x19 pixels. You can use this [tool](https://github.com/DownrightNifty/computercraft-stuff) to achieve the desired file format.

Text File Format:
The text file associated with the poster image should follow this format:

|xPosition|yPosition|The text|text color|background color|

License

This project is licensed under the MIT License.
Authors:

Stacode

For more details, refer to the source code comments in server.lua and client.lua or make an issue.
