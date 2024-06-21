

# ChatBox - Flutter Chat Application

ChatBox is a real-time chat application built with Flutter and Firebase. It allows users to sign up, log in, chat with other users.

## Features

- **User Authentication**: Sign up and log in using email and password.
- **Real-time Messaging**: Send and receive messages in real-time.
- **User Profile**: View and update user profile information.
- **Search Users**: Search for other users to start a chat.


## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Firebase Account: [Create a Firebase Project](https://console.firebase.google.com/)

### Installation

**For installation go to releases and download the latest version of apk and install on your android device**

or you can,

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


## Dependencies

- `flutter`
- `firebase_core`
- `firebase_auth`
- `cloud_firestore`
- `firebase_messaging`
- `firebase_storage`
- `google_fonts`
- `uuid`

## Screenshots

<img src="https://github.com/itskartike910/chat_app/assets/96167648/1bf2d23c-cf59-44c0-a150-472c9fe52bca" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/0a163932-d4b3-4600-8551-f32fb5ae30e6" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/c03d9229-a170-4825-b82f-d2c2948aeb5a" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/33b7f338-8af0-492e-b6d1-fdf4db39a440" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/0944c459-1f5c-40ef-9cd5-48a49af5a2d4" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/c21abb1b-70b2-4369-a934-0f3e00ab9e11" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/508b342b-6c89-4147-b732-f60486d21423" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/fdea6ed6-fe2c-4909-a40f-c730b0bcef90" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/157dac0a-9041-40d2-8a48-4b3d2a8b9e35" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/9045cfef-124c-4750-af74-72bd3a784be4" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/474ea33e-c435-4808-aa8c-7d92002f66a1" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/1be80a56-4214-43d9-b724-a97e08eb6e2c" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/3fa3a411-6b07-49eb-a7c3-81ef61516aa1" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/5870e6fe-d265-423c-8054-5a86fd0857f0" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/fb7ad31d-d16c-492f-880d-09e1e7193e3b" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/4c531789-da95-4e76-b8de-e79ffea139ea" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/854263c8-5a05-47a9-ab76-98a5390b93fb" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/8a7de64a-99c6-4421-abc5-f4958f86c468" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/38c1d049-f23b-4089-80ac-94498a71d999" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/6ddc8203-0ebb-4d21-ad61-bef55d3801b5" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/fd4eff15-9723-4a4e-83ef-c6179a1a451a" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/d2d96938-92fe-4589-a27e-d75bcb7ce7f1" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/04ee8098-f567-4477-88fa-320b1920d502" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/5fbafa3d-e055-44c7-9b00-2f1b2dca4be9" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/80c53dc1-fdb0-48de-862f-ddc1b63d0c4b" width="150">
<img src="https://github.com/itskartike910/chat_app/assets/96167648/2bd7f254-cf04-43f7-8c49-4e29ba5ccb46" width="150">


