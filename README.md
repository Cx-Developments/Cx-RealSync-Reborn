# Cx-RealSync-Reborn

Cx-RealSync-Reborn is a powerful time and weather synchronization script for FiveM that uses real-world weather data to create an immersive in-game experience. It fetches live weather from any city in the world and syncs it smoothly for all players.

This script includes a full admin management panel built with Vue.js, allowing for manual override and control of all weather aspects, secured by ACE permissions.

## Features

* **Real-World Sync:** Synchronizes in-game time and weather with a real-world city of your choice.
* **Smooth Transitions:** Weather changes occur over time to ensure smooth, natural transitions.
* **Admin Control Panel:** A clean Vue.js NUI for admins to manually set weather, rain, and wind, and view the current sync status.
* **Admin Commands:** Full suite of commands for manual weather control (`/setweather`, `/setrain`, `/setwind`, `/clearoverride`).
* **Permission-Based:** All administrative features are secured using FiveM's ACE permission system.
* **Interior/Housing Support:** Includes commands that can be integrated into housing or interior scripts to temporarily disable weather sync when a player is indoors.
* **Lightweight:** Optimized for performance to ensure minimal server or client impact.

## Requirements

* A running FiveM server.
* An API Key from [weatherapi.com](https://www.weatherapi.com/signup.aspx) (the free plan is sufficient).

## Installation & Setup

1.  **Download:** Download the latest version of `Cx-RealSync-Reborn`.
2.  **Install:** Drag and drop the `Cx-RealSync-Reborn` folder into your server's `resources` directory.
3.  **Configure API Key:**
    * Open `Cx-RealSync-Reborn/server/Config.lua`.
    * Paste your API key from weatherapi.com into the `ApiKey` field.
    * Set your desired `City`.
    * Adjust `RefreshTime` or `UseLocalTime` if needed.
4.  **Edit `server.cfg`:**
    * Add the following line to your `server.cfg` to start the script:
        ```cfg
        ensure Cx-RealSync-Reborn
        ```
    * **Crucially, remove or disable any other weather and time sync scripts** (like vSync, vMenu's weather sync, etc.) to prevent conflicts.

## Permissions Setup

To allow admins to use the weather control panel and commands, you must grant them the `command.setweather` permission in your `server.cfg`.

#### Grant to an Admin Group
To give all users in the "admin" group permission, add this line:
```cfg
add_ace group.admin command.setweather allow
```

## Events

You can use these events in your other scripts to control the weather sync.

* **`Cx-RealSync:stopWeather`**: This event stops the weather synchronization.
    * Example: `TriggerEvent("Cx-RealSync:stopWeather")`

* **`Cx-RealSync:startWeather`**: This event starts the weather synchronization.
    * Example: `TriggerEvent("Cx-RealSync:startWeather")`