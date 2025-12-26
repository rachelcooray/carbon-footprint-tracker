# Devpost Submission: Carbon Footprint Tracker 🌿

## Project Title
**Carbon Footprint Tracker: Your Digital Eco-Butler**

## Elevator Pitch (One Sentence)
A premium, AI-powered "Eco-Butler" that uses Serverpod and Google Gemini to turn carbon tracking from a chore into a rewarding, gamified journey of preserving a digital forest.

---

## 💡 The Problem & The Solution (The Pitch)

**Climate anxiety is real, but taking action feels like homework.**
Most carbon trackers are glorified spreadsheets—dry, guilt-inducing, and tedious. We asked: *What if sustainability had a concierge?*

**Enter the Carbon Footprint Butler.**
We didn't just build a tracker; we built a **Digital Eco-Assistant**.
*   **Why people will use it**: Because it's easier than doing it alone. You don't type; you snap a photo. You don't calculate; the Butler does the math.
*   **Why it sticks**: We replaced "Data Entry" with "Forest Caretaking". Your actions directly grow a beautiful, living digital forest.
*   **The Value**: It turns the invisible (CO2) into the visible (Trees), making every small action feel meaningful.

*Inspired by the elegance of Iron Man's JARVIS and the serenity of Stardew Valley, this is sustainability for the modern, busy human.*

## 🚀 What it does
The **Carbon Footprint Tracker** is a full-stack Flutter application that:
*   **Gamifies Sustainability**: Your actions directly impact a living, breathing **Digital Forest**. Save CO2, and watch your "Fledgling Woods" evolve into an "Earth Guardian Realm."
*   **AI Butler Service**: An intelligent "Eco Butler" (powered by **Google Gemini**) that provides context-aware briefings ("Good evening, Agent"), smart suggestions, and motivates you to keep your streak.
*   **Vision-Powered Logging**: Don't want to type? Snap a photo of your meal or upload a PDF energy bill. The Butler's computer vision extracts the data and logs the carbon impact automatically.
*   **Eco-Envisioning**: A simulator that lets you "preview" the future. Toggle sliders for "Solar Installation" or "EV Adoption" to see exactly how much money and CO2 you could save annually.

## ⚙️ How we built it
We leveraged the full power of **Flutter** and **Serverpod** to build a robust, type-safe ecosystem.
*   **Backend (Serverpod)**: We used Serverpod as our backend-for-frontend. Its code generation features meant we never had to write manual JSON serialization. We used endpoints for `ActionLogging`, `Leaderboards`, and `AI Processing`.
*   **AI (Google Gemini)**: We integrated the `google_generative_ai` package on the server. The Butler isn't just a chatbot; it has a "System Persona" that adapts to the time of day and user stats.
*   **Frontend (Flutter)**: We built a custom "Glassmorphism" design system. The UI is fully responsive, adapting from a mobile app feel to a wide-screen dashboard on desktop, thanks to `LayoutBuilder` and custom responsive wrappers.
*   **Database**: PostgreSQL stores our user profiles, action logs, and forest states, managed seamlessly by Serverpod's ORM.

## 🚧 Challenges we ran into
*   **Timezone Travel**: One of our biggest bugs was the Butler wishing users "Good Morning" at 8 PM. We realized the server runs in UTC! We had to implement a handshake where the client sends its `TimeContext` ("evening") to the server, and ensuring all logs convert to `.toLocal()` before display.
*   **The "Blank Page" Problem**: Generative AI can sometimes be too vague. We had to heavily tune the System Prompts to ensure the Butler didn't just say "Save energy," but offered executable actions like "Shall I switch to Eco Mode?"
*   **Web Compatibility**: The `dart:io` library broke our web build when handling file uploads. We refactored our file picker logic to use byte streams (`FileType.any`) to ensure the Butler could analyze PDFs on both Web and Mobile.

## 🏅 Accomplishments that we're proud of
*   **The "Fill Screen" Experience**: We spent extra time ensuring the app isn't just a stretched mobile view. On desktop, the layout expands, text scales up, and grids reorganize.
*   **Silent Sync**: We implemented a "Silent Polling" mechanism that keeps the Eco Score and Leaderboard live-updated without spinning loaders interrupting the user.
*   **The Butler's Personality**: He genuinely feels like a character. He's polite, slightly witty, and makes the app feel premium.

## 🧠 What we learned
*   **Serverpod is a Superpower**: The speed of iterating when your backend models are instantly available in your Flutter code is unmatched. It cut our development time in half.
*   **Prompt Engineering is Coding**: Writing the "System Instruction" for the Butler was just as critical as writing the Dart code.
*   **UI Polish Matters**: Small touches—like the "Glass" card effect and the dynamic Forest image—transform the app from a tool into an experience.

## 🔮 What's next for Carbon Footprint Tracker
*   **IoT Integration**: We want the Butler to talk to smart plugs (e.g., "I've turned off the lights in the empty room").
*   **Community Challenges**: "Neighborhood vs. Neighborhood" carbon saving races.
*   **AR Forest**: Using Flutter's AR capabilities to project your digital forest into your real living room.
