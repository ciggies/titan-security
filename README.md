# TITAN SECURITY SCRIPT

Runs at ~ 0.00ms to 0.01ms while not inuse and a maximum of 0.17ms while in use
Optimization is lowered due to inbuilding the heli camera script in

# Dependencies
* [qb-core](https://github.com/qbcore-framework/qb-core)
* [cd_drawtextui](https://github.com/dsheedes/cd_drawtextui)
* [nh-context](https://github.com/nerohiro/nh-context)
* [qb-target](https://github.com/BerkieBb/qb-target)

# Features
* Vehicle Spawn Using Ped and or BoxZone's
* Helicopter Take out and Return using cd_drawtext
* Customizable Armory Using qb-target
* Personal Stash using qb-target
* Built-in Helicam Script
* Built-in Rappel Script

# Includes 
* Code for an IFAK located in shared.lua
* IFAK Picture
* Code for qb-target located in qb-target.lua
* qb-target exports inside the client.lua for Personal Stash and Armory

# Change-Logs

### 1.1
* Quality of Life Update
* Added Config.PlateText For Vehicle Plates when spawned
* Added Config.JobName For Job Checks
* Removed Draw3dText
* Removed Unused code
* Moved IFAK Code & qb-target code in Usefull folder

### 1.0
* Intital Release
