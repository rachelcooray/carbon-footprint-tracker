# Carbon Footprint Tracker - Project Documentation 🌿

## 1. Executive Summary
The **Carbon Footprint Tracker** is a full-stack application that gamifies the reduction of carbon emissions. By combining rigorous "Avoided Emissions" accounting with an engaging "Digital Forest" metaphor, it bridges the gap between scientific sustainability and daily consumer behavior.

---

## 2. Scientific Methodology & Math 🧪

Our scoring engine aligns with the **Greenhouse Gas Protocol (GHGP)** principles, specifically using the **"Avoided Emissions"** framework for comparative analysis.

### 2.1 The Core Formula (Linear Scoring Methodology)
We utilize the standard industry method for calculating carbon impact:

$$ \text{Impact (kg CO}_2\text{e)} = \text{Activity Data} \times \text{Emission Factor (EF)} $$

*   **Activity Data**: The quantitative measure of a user's action (e.g., "5 km travelled", "1 meal consumed").
*   **Emission Factor (EF)**: A coefficient representing the CO2 equivalent emissions *avoided* relative to a baseline behavior.

### 2.2 Emission Factors & Baselines
The application's database (`EcoAction` table) stores EFs derived from comparative lifecycle assessments (LCA).

| Action | Activity Unit | Baseline Comparison | Emission Factor (Saved) | Logic Source |
| :--- | :--- | :--- | :--- | :--- |
| **Biking** | km | Average Passenger Vehicle (ICE) | **0.2 kg CO2e / km** | Avoided tailpipe emissions (EPA avg: ~400g/mile). |
| **Walking** | km | Short Urban Car Trip (Inefficient) | **0.1 kg CO2e / km** | Avoided cold-start vehicle emissions. |
| **Plant-Based Meal**| Meal | Average Beef-based Meal | **1.5 kg CO2e / meal** | Difference in emission intensity (Beef ~60kg/kg vs Legumes ~0.8kg/kg). |
| **Recycling** | kg | Landfill Decomposition | **0.2 kg CO2e / kg** | Avoided methane generation & raw material extraction. |

*> **Note:** These factors are stored in the PostgreSQL database, allowing for Over-The-Air (OTA) updates as scientific standards (e.g., IPCC AR6 reports) evolve.*

### 2.3 The "Eco Score" (Gamified Index)
To translate raw scientific data into user motivation, we use a **Linear Scaling System**:

$$ \text{Eco Score} = \text{Total Avoided Emissions (kg)} \times 10 $$

*   **Scope**: Personal Action Scope (focusing on direct behavioral change).
*   **Rationale**: A linear scale ensures transparency. Users understand that *double the effort equals double the reward*.

---

## 3. Technical Architecture

### 3.1 Stack Overview
*   **Frontend**: Flutter (Mobile & Web) - Implementing a Responsive "Glassmorphism" Design System.
*   **Backend**: Serverpod (Dart) - Providing type-safe endpoints for standard CRUD and AI operations.
*   **Database**: PostgreSQL - Relational storage for User Profiles, Actions, and Logs.
*   **AI**: Google Gemini (Flash Model) - Powering the "Eco Butler".

### 3.2 Key Components
*   **`ActionService`**: The business logic layer that:
    1.  Validates `Activity Data` (User Input).
    2.  Fetches `Emission Factors` from the DB.
    3.  Calculates Impact.
    4.  Updates `UserProfile` (Score, Streak, Level).
*   **`ButlerEndpoint`**: Manages the AI persona, injecting `TimeContext` and `UserStats` into the System Prompt to generate context-aware advice.

---

## 4. Feature Implementation

### 4.1 The Eco Butler 🤖
*   **Role**: A Proactive Sustainability Assistant.
*   **Logic**:
    *   **Context Injection**: The client sends local context (e.g., "evening") -> Server adjusts persona -> "Good evening, Agent."
    *   **Vision-Based Logging**: Users upload images/PDFs -> Gemini Vision extracts `Activity Data` -> Server structures this into an `ActionLog`.

### 4.2 The Digital Forest (Progression System)
*   **Concept**: A dynamic visual representation of the user's "Net Impact."
*   **Tiers**:
    *   **Level 1 (Fledgling Woods)**: Score 0-999
    *   **Level 2 (Verdurous Grove)**: Score 1000-1999
    *   ...up to **Level 5 (Earth Guardian)**.
*   **Implementation**: `UserProfile.level` is recalculated transactionally on every logged action.

### 4.3 Eco-Envisioning Simulator
*   **Purpose**: Predictive modeling for Scope 1 (Household) & Scope 2 (Energy) reductions.
*   **Math**:
    *   **Solar**: `Panel Count * Avg Yield (kWh) * Grid Intensity Factor` = Annual Savings.
    *   **EV**: `Weekly Mileage * (ICE Factor - EV Grid Factor)` = Annual Savings.

---

## 5. Future Roadmap: IoT & Smart Grid
*   **Next Steps**: Integrate real-time "Grid Intensity" APIs (e.g., Carbon Intensity API) to dynamically weight energy actions based on the actual cleanliness of the power grid at that hour.

---

*Documentation generated for the Serverpod "Flutter Butler" Hackathon.*
