

# ChatBox - Flutter Chat Application

ChatBox is a real-time chat application built with Flutter and Firebase. It allows users to sign up, log in, chat with other users, and receive notifications for new messages.

## Features

- **User Authentication**: Sign up and log in using email and password.
- **Real-time Messaging**: Send and receive messages in real-time.
- **User Profile**: View and update user profile information.
- **Push Notifications**: Receive notifications for new messages.
- **Search Users**: Search for other users to start a chat.

## Screenshots

<!-- Include some screenshots of your app -->

## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Firebase Account: [Create a Firebase Project](https://console.firebase.google.com/)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/chatbox.git
   cd chatbox
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase:**
   - Go to the [Firebase Console](https://console.firebase.google.com/).
   - Create a new project.
   - Add an Android app and download the `google-services.json` file.
   - Place the `google-services.json` file in the `android/app` directory.
   - Add an iOS app and download the `GoogleService-Info.plist` file.
   - Place the `GoogleService-Info.plist` file in the `ios/Runner` directory.
   - Enable Firestore, Authentication, and Firebase Cloud Messaging in your Firebase project.

4. **Configure Firebase:**
   Replace the `firebase_options.dart` file with your Firebase configuration. You can generate this file using the Firebase CLI or manually configure it.

5. **Run the app:**
   ```bash
   flutter run
   ```

## Firebase Setup

Ensure you have the following Firebase services enabled:

- **Authentication**: Enable email/password sign-in method.
- **Firestore**: Create necessary collections such as `users`, `chatrooms`, etc.
- **Cloud Messaging**: Enable Firebase Cloud Messaging for push notifications.

## Usage

### Authentication

Users can sign up and log in using their email and password. The authentication state is handled using Firebase Authentication.

### Messaging

Users can chat in real-time with other users. Messages are stored in Firestore under `chatrooms` collection.

### Notifications

Firebase Cloud Messaging is used to send push notifications for new messages. Notifications are handled using the `firebase_messaging` package.

### User Profile

Users can view and update their profile information. Profile pictures are stored in Firebase Storage.

## Code Structure

- **lib**
  - **authentication**: Contains login and signup pages.
  - **helper**: Firebase helper functions and constants.
  - **models**: Data models for User and ChatRoom.
  - **pages**: Main pages like Home, Chat, and Search.
  - **screens**: Splash screen.
  - **widgets**: Custom widgets used in the app.
  - `main.dart`: Entry point of the application.

## Notifications

To enable notifications:

1. Ensure you have configured Firebase Cloud Messaging correctly.
2. Initialize Firebase Messaging and Local Notifications in `main.dart`.
3. Handle message reception and display notifications using `flutter_local_notifications` package.

## Dependencies

- `flutter`
- `firebase_core`
- `firebase_auth`
- `cloud_firestore`
- `firebase_messaging`
- `firebase_storage`
- `flutter_local_notifications`
- `google_fonts`
- `uuid`
