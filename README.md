# Maps-Integration

## Overview

The **Maps Integration Project** is a Flutter application that integrates Google Maps to display various points of interest (POIs) in Palestine. The app allows users to view different types of locations such as mosques, churches, religious sites, archaeological sites, historic sites, museums, castles, monasteries, gardens, and ports. Users can filter these locations by type and view detailed information about each location through custom info windows. Additionally, the app provides live location tracking, weather information, and the ability to save custom markers.

## Features

1. **Google Maps Integration**:
   - Display various points of interest on the map.
   - Custom markers for different types of locations.
   - Live location tracking with a marker indicating the user's current position.

2. **Custom Info Windows**:
   - Display detailed information about each location when a marker is tapped.
   - Includes the location's name and an image.

3. **Filtering**:
   - Filter markers by type (e.g., Mosque, Church, Religious Sites, etc.).
   - Toggle between different map types (Normal and Satellite).

4. **Live Location & Weather**:
   - Track the user's live location.
   - Display current weather information based on the user's location.

5. **Save Custom Markers**:
   - Save custom markers with a user-defined name.
   - View and manage saved markers in a list.

6. **User-Friendly Interface**:
   - Intuitive UI with floating action buttons for easy access to features.
   - Smooth animations and transitions.

## Screenshots

Here are some screenshots of the app in action:

### Main Map View
<img src="https://github.com/user-attachments/assets/e9aaa26f-bad4-4e8c-9772-526f60c70961" alt="Main Map View" width="300" />

### Custom Info Window
<img src="https://github.com/user-attachments/assets/c58678d6-1fe5-4db9-94d9-9cbfa35292f2" alt="Custom Info Window" width="300" />

### Filtering Locations
| <img src="https://github.com/user-attachments/assets/7687ddcd-a637-4980-9b09-a2a8a0c5d47f" alt="Filtering Locations 1" width="300" /> | <img src="https://github.com/user-attachments/assets/14009956-a5c1-4d09-bb7c-a8f4e8e30ab6" alt="Filtering Locations 2" width="300" /> |

### Live Location & Weather
| <img src="https://github.com/user-attachments/assets/7f847680-1bd1-45bf-a6ab-74a92eb4f340" alt="Live Location & Weather 1" width="300" /> | <img src="https://github.com/user-attachments/assets/06a3e48d-8ac8-4e04-a11b-225707a89bee" alt="Live Location & Weather 2" width="300" /> |


### Saved Markers List
<img src="https://github.com/user-attachments/assets/f74d1a8f-baf4-413b-88d0-76c8c9d1ef5e" alt="Saved Markers List" width="300" />


## Installation

To run this project locally, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/masaabuaisheh/Maps-Integration.git
   cd Maps-Integration
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the App**:
   ```bash
   flutter run
   ```

## Dependencies

This project uses the following dependencies:

- `google_maps_flutter`: For integrating Google Maps.
- `geolocator`: For accessing the device's location.
- `custom_info_window`: For displaying custom info windows on the map.
- `location`: For live location tracking.
- `http`: For making HTTP requests to fetch weather data.

## Configuration

To use Google Maps in your Flutter app, you need to configure your API keys:

1. **Android**:
   - Add your Google Maps API key in the `android/app/src/main/AndroidManifest.xml` file:
     ```xml
     <meta-data
         android:name="com.google.android.geo.API_KEY"
         android:value="YOUR_API_KEY"/>
     ```

2. **iOS**:
   - Add your Google Maps API key in the `ios/Runner/AppDelegate.swift` file:
     ```swift
     GMSServices.provideAPIKey("YOUR_API_KEY")
     ```

## Usage

1. **Viewing Locations**:
   - Open the app to view the map with all the markers.
   - Tap on a marker to see detailed information in a custom info window.

2. **Filtering Locations**:
   - Use the filter button to toggle between different types of locations.
   - Select a specific type to view only those markers on the map.

3. **Live Location & Weather**:
   - The app will automatically track your live location and display it on the map.
   - Current weather information will be displayed at the top of the screen.

4. **Saving Custom Markers**:
   - Tap anywhere on the map to save a custom marker.
   - Enter a name for the marker when prompted.
   - View and manage your saved markers using the saved markers list.

## Contributing

Contributions are welcome! If you have any suggestions, bug reports, or feature requests, please open an issue or submit a pull request.
