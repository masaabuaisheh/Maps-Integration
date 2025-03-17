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
![Main Map View](assets/screenshots/main_map_view.png)

### Custom Info Window
![Custom Info Window](assets/screenshots/custom_info_window.png)

### Filtering Locations
![Filtering Locations](assets/screenshots/filtering_locations.png)

### Live Location & Weather
![Live Location & Weather](assets/screenshots/live_location_weather.png)

### Saved Markers List
![Saved Markers List](assets/screenshots/saved_markers_list.png)

## Installation

To run this project locally, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/masaabuaisheh/Maps-Integration.git
   cd maps_integration
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
