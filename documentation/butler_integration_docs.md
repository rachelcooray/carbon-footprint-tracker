# 🤖 The Eco Butler: AI Integration Guide

## Overview
The "Eco Butler" is not a standard chatbot. It is a context-aware persona engine built using **Google Gemini 1.5 Flash** integrated directly into a **Serverpod** backend.

## 1. Architecture
The AI logic is encapsulated in `ButlerEndpoint.dart`. This ensures that API keys remain secure on the server and allows us to inject "System State" before the user's message ever reaches Gemini.

### The Flow
1.  **Client**: Sends User Message + `TimeContext` (Morning/Evening) + `UserStats` (Score/Streak).
2.  **Server**: Constructs a precise "System Prompt".
3.  **Gemini**: Generates a response aligned with the Butler Persona.
4.  **Client**: Streams the text response to the chat UI.

---

## 2. Prompt Engineering & Persona
We heavily tuned the System Instruction to prevent generic "AI-speak".

### The System Prompt Structure
```dart
final prompt = '''
You are the Eco Butler, a sophisticated, British-accented AI assistant.
Your goal is to help the user reduce their carbon footprint.
CONTEXT:
- Time: $timeContext (Adjust your greeting accordingly)
- User Score: ${stats.ecoScore}
- Forest Level: ${stats.levelLabel}

RULES:
1. Be polite but concise.
2. If the user uploads an image, analyze it for carbon impact.
3. Suggest actionable steps (e.g., "Shall I log that vegan lunch for you?").
''';
```
*   **Why this matters**: By injecting `stats.ecoScore`, the Butler knows if you are a "Newbie" or an "Earth Guardian" and adjusts his respect level accordingly.

---

## 3. Vision Capabilities (Multimodal)
The Butler can "see". We utilize Gemini's multimodal capabilities to reduce friction.
*   **Feature**: "Scan Bill" / "Scan Meal"
*   **Implementation**:
    *   Client captures image (`Uint8List`).
    *   Server converts to `DataPart('image/jpeg', bytes)`.
    *   Gemini Prompt: *"Extract the kWh usage from this bill" or "Estimate the carbon footprint of this meal."*
    *   Result: The AI returns structured data that we parse into an `EcoAction`.

---

## 4. Challenges & Solutions
### The "Time Travel" Bug 🕰️
*   **Issue**: Serverpod runs in UTC (Cloud Run). The Butler was saying "Good Morning" at 8 PM user-time.
*   **Fix**: We implemented a handshake where the Client passes `TimeContext` ("evening") in the API call, making the AI "local-aware" without complex timezone math on the backend.

### The "Hallucination" Guard 🛡️
*   **Issue**: AI suggesting impossible actions (e.g., "Buy a nuclear reactor").
*   **Fix**: We constrained the AI's "Action Suggestions" to a strict list of 4-5 supported app features (Log Meal, Log Transport, View Stats), ensuring every suggestion is actually clickable.

---

*This integration demonstrates the power of Serverpod + Gemini: Type-safe, secure, and context-aware AI.*
