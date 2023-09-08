# NASA Photo Viewer App

Welcome to the NASA Photo Viewer app! This Flutter application allows users to explore and discover photos captured by NASA's Mars rovers. The app fetches data from the NASA API, uses Firebase anonymous sign-in for user authentication, and provides a seamless experience for exploring Mars photos.

## Table of Contents

- [NASA Photo Viewer App](#nasa-photo-viewer-app)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Architecture](#architecture)
  - [Error Handling](#error-handling)

## Description

This application provides a curated collection of photos captured by NASA's Mars rovers. The app offers the following features:

- **Authentication**: Users are anonymously signed in using Firebase when they launch the app.

- **Explore Mars Photos**: Users can explore a list of Mars photos fetched from the NASA API. The list displays thumbnail images of each photo.

- **View Full Images**: Tapping on a list item navigates to a detail screen that displays the full image of the selected photo.

- **Error Handling**: The app handles network errors and displays appropriate error messages to users. It ensures smooth user interactions even in the presence of unexpected errors.

- **Rover Tabs**: Recent enhancements include rover tabs for Curiosity, Opportunity, and Spirit. Users can switch between these rover tabs to explore photos captured by different rovers. The data is automatically refreshed when switching between tabs.

The app follows a structured architecture with the following layers:

1. **Models**: Defines data structures representing API objects and provides methods to parse data from JSON.

2. **Remote Data Source**: Fetches data from the NASA API, makes HTTP requests, and transforms responses into model objects using the `fromJson` methods.

3. **Service**: Serves as an abstraction for data fetching, handles exceptions, logs events, and returns either a custom `BaseFailure` or the data.

4. **ViewModel/Provider**: Manages business logic, state, and data flow between the UI and other layers. Utilizes Riverpod for state management and dependency injection.

This architecture promotes separation of concerns, allowing for easy testing, maintainability, and collaboration among developers.

Key Riverpod providers used in the app:

- `roversPhotoServiceProvider`: Provides the service for fetching Mars rover photos from the NASA API.

- `roversPhotosProvider`: Fetches Mars rover photos based on the selected rover name.

- `firebaseAuthenticationServiceProvider`: Provides the Firebase authentication service for anonymous sign-in.

## Installation

To run the app, follow these steps:

1. Clone this repository to your local machine:

git clone https://github.com/your-username/nasa-photo-viewer.git



2. Navigate to the project directory:

cd nasa-photo-viewer

3. Create a `.env` file in the root directory and add your NASA API key and the Nasa API path:

NASA_API_KEY=your_api_key
NASA_URL=https://api.nasa.gov


**Note:** Ensure that the `.env` file is not included in the repository for security reasons.

1. Install the required dependencies:

flutter pub get

## Usage

Run the app on an emulator or a physical device:

flutter run

The app will automatically sign in anonymously using Firebase. You can explore the list of Mars photos and view full images by tapping on the thumbnails. Switch between rover tabs to explore photos from different rovers.

## Architecture

The NASA Photo Viewer App follows a modular and layered architecture to ensure maintainability and scalability. Here's an overview of the different architectural layers:

- **Models**: Defines data structures representing API objects. Models include methods to parse data from JSON.

- **Remote Data Source**: Fetches data from the NASA API, makes HTTP requests, and transforms responses into models using the `fromJson` methods.

- **Service**: Serves as an abstraction for data fetching, handles exceptions, logs events, and returns either a custom `BaseFailure` or the data.

- **ViewModel/Provider**: Manages business logic, state, and data flow between the UI and other layers. Utilizes Riverpod for state management and dependency injection.

This architecture promotes separation of concerns, allowing for easy testing, maintainability, and collaboration among developers.

## Error Handling

The app implements robust error handling to provide a smooth user experience even in the presence of unexpected errors. Error handling is categorized into different exception classes:

- **BaseFailure**: Base class for exceptions, including a message, stack trace, and log level.

- **ServerFailure**: A subclass of `BaseFailure` specifically for server-related errors. It maps DioExceptions to appropriate log levels based on HTTP status codes.

- **UnknownFailure**: Handles unexpected errors that aren't explicitly mapped to other exceptions. Provides a default error message.

