# Carbon Footprint Tracker

A premium, glassmorphism-inspired carbon footprint tracking application built with **Flutter** and **Serverpod**.

## 🌟 Features
- **AI Eco Butler**: Personalized morning briefings and real-time eco-suggestions powered by Google Gemini.
- **Baseline Calculator**: Establish a personalized monthly carbon budget based on driving, diet, and energy habits.
- **Community Groups**: Join or create interest-based communities for collective impact.
- **Gamification**: Earn trophies (badges) and compete on global leaderboards.
- **Dynamic Action Logging**: Track various eco-actions with real-time impact visualization.

## 🚀 Tech Stack
- **Frontend**: Flutter (Mobile & Web)
- **Backend**: Serverpod (Dart-based)
- **AI**: Google Gemini (generative AI integration)
- **Database**: PostgreSQL

## 📂 Project Structure
- `carbon_footprint_flutter/`: The Flutter application.
- `carbon_footprint_server/`: The Serverpod backend server.
- `carbon_footprint_client/`: The generated client code for the Flutter app.

## 🛠 Setup & Installation
1.  **Backend**:
    - Ensure Docker is running.
    - `cd carbon_footprint_server`
    - `docker-compose up --build -d`
    - `dart bin/main.dart --apply-migrations`
2.  **Frontend**:
    - `cd carbon_footprint_flutter`
    - `flutter run`

---
*Crafted with 🌿 by the Carbon Tracker Team.*
