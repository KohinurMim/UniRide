# 🚌 UniRide — Intelligent University Bus Tracking & Assistance System

**UniRide** is a Flutter-based intelligent university bus tracking and commuting assistance application designed to eliminate waiting uncertainty for campus commuters. It seamlessly connects **Students**, **Drivers**, and **Administrators** in real time using **Firebase** and **Google Maps Platform**.

---

## 📄 SRS Requirements Analysis & Objectives

### 1. Problem Statement
University students frequently face uncertainty regarding campus bus schedules, live locations, estimated arrival times (ETA), and bus crowding. UniRide solves this problem by providing real-time GPS tracking, smart bus recommendations, ETA calculators, digital passes, and emergency support.

### 2. User Roles & Capabilities
* **👨‍🎓 Student:** Live bus tracking on map, route search, ETA countdown, bus occupancy status, digital QR bus pass, emergency SOS alert, feedback/complaints, and push notifications.
* **🚌 Driver:** Assigned bus/route view, start/end trip toggle with live GPS sharing, dynamic occupancy updates, QR pass verification, and trip history log.
* **👨‍💼 Administrator:** Fleet overview, route/bus management, user moderation, system announcements, and student feedback review.

---

## 🎨 Completed Frontend Implementation (14 UI Screens)

The entire frontend UI for UniRide has been designed and implemented in Flutter using a unified design system (**Deep Royal Blue `#1952E8`**, soft grey surfaces, and status badges).

### 📱 Screen Breakdown

| # | Screen | Key UI Components & Features |
| :-: | :--- | :--- |
| **1** | **Splash Screen** | UniRide branding (*"Your Campus. Our Ride. Track • Ride • Reach"*), custom blue bus graphic, primary **Get Started** button, and login link. |
| **2** | **Login Screen** | **Role Switcher Segmented Control** (`Student` \| `Driver` \| `Admin`), email/password fields with visibility toggle, *"Remember me"*, **Login**, **Google Sign-In**, and **Sign Up** footer. |
| **3** | **Home Screen (Student)** | Top header with greeting *"Good Morning, Arafat"*, notification bell with badge, route search bar, **Next Bus Card** (Bus 03, *"On Route"*, ETA *"7 min"*, Occupancy *"Almost Full"*), and **2x2 Quick Action Grid** (*My Routes*, *Live Map*, *Feedback*, *SOS*). |
| **4** | **Live Tracking Map** | Custom Google Maps canvas view with bus location pin, route polylines, Central Library & University pins, and bottom card with stop timeline (*Farmgate → Mohakhali → University*). |
| **5** | **Route & Stops Screen** | Tab bar (`All Routes` \| `My Favorites`) and route cards (Routes 01–04) with stop list summaries and favorite star badges. |
| **6** | **ETA & Stop Details** | Live GPS map snippet, **7 min ETA Highlight Card**, notification switch (*"Notify me when bus is 2 minutes away"*), bus details table, and **View Full Route** action. |
| **7** | **Bus Occupancy** | Interactive occupancy selector (**Empty**, **Available**, **Almost Full**, **Full**), current status warning banner, and **Back to Map** button. |
| **8** | **Notifications** | Real-time alerts (*Bus approaching, Route delayed, Bus arrived, Campus announcement, Feedback received*) with timestamps and category icons. |
| **9** | **Feedback / Complaint** | Issue grid (*Late Bus*, *Overcrowded*, *Route Issue*, *Other*), message text area, image/camera attachment buttons, and **Submit** action. |
| **10** | **Driver Dashboard** | Driver profile (*Rafiq Ahmed - Online*), assigned bus card (*Bus 03*), **Start Trip** (Green) & **End Trip** (Red) live GPS controls, and trip history log. |
| **11** | **Admin Panel** | Navigation drawer, metric stat cards (*Total Buses: 12, Active Buses: 10, Total Routes: 4, Total Users: 1,248*), and recent feedback table with status badges (*Pending*, *In Progress*, *Resolved*). |
| **12** | **SOS Emergency Screen** | Red emergency modal screen, large central **SOS** badge, location broadcast notice, and **Send SOS** trigger. |
| **13** | **Favorite Routes** | Saved routes list (*Home → University*, *Mirpur → University*, *Banani → University*) with star badges. |
| **14** | **Settings / Profile** | Student profile header, **Digital Bus Pass Button** (opens interactive QR Code pass modal dialog), personal info, app settings, and logout. |

---

## 🛠️ Interactive UI Switcher Drawer
To facilitate effortless testing and demonstrations, a **`UI Screens`** floating button and drawer (`lib/widgets/screen_switcher_drawer.dart`) have been built into the app. Tapping this button at any time allows you to jump directly to **any of the 14 UI screens** with a single tap!

---

## 🏗️ Project Architecture & Folder Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── app_colors.dart         # Brand Primary Blue (#1952E8), Occupancy & Status colors
│   ├── theme/
│   │   └── app_theme.dart          # MaterialApp Theme Data & Typography
│   └── models/
│       └── mock_data.dart          # Mock dataset for routes, buses, notifications & admin stats
├── widgets/
│   ├── map_placeholder.dart        # Custom Canvas Google Maps simulation
│   ├── occupancy_badge.dart        # Capacity status pill badge widget
│   └── screen_switcher_drawer.dart # Interactive 14-screen preview drawer
├── screens/
│   ├── splash_screen.dart
│   ├── auth/
│   │   └── login_screen.dart
│   ├── student/
│   │   ├── student_home_screen.dart
│   │   ├── live_tracking_screen.dart
│   │   ├── routes_screen.dart
│   │   ├── eta_details_screen.dart
│   │   ├── bus_occupancy_screen.dart
│   │   ├── notifications_screen.dart
│   │   ├── feedback_screen.dart
│   │   ├── sos_screen.dart
│   │   └── favorite_routes_screen.dart
│   ├── driver/
│   │   └── driver_dashboard_screen.dart
│   ├── admin/
│   │   └── admin_dashboard_screen.dart
│   ├── profile/
│   │   └── profile_screen.dart
│   └── main_navigation_screen.dart # Main app container & role state controller
├── assets/
│   └── images/
│       └── splash_bus.png          # Custom blue bus graphic asset
└── main.dart                       # Flutter entry point
```

---

## 🗄️ System & Database Design Strategy

For full-stack implementation, UniRide utilizes a split Firebase architecture:
1. **Cloud Firestore:** Stores structured data including user profiles, routes, bus fleet details, bus passes, announcements, and feedback.
2. **Firebase Realtime Database:** Low-latency streaming of high-frequency active bus GPS coordinates (`latitude`, `longitude`, `speed`, `heading`).
3. **Google Maps Platform:** Renders real-time bus locations, stop markers, and route polylines.

---

## 🚀 How to Run the Project

### Option A: Run in Web Browser (Chrome / Edge)
```cmd
C:\flutter\bin\flutter.bat run -d chrome
```

### Option B: Run on Physical Android Phone via USB
1. On your phone, go to **Settings → About Phone → tap "Build Number" 7 times**.
2. Go to **Settings → Developer Options → turn ON "USB Debugging" & "Install via USB"**.
3. Connect your phone via USB cable and allow the USB Debugging prompt on your screen.
4. Select your phone in Android Studio's top device dropdown and click **Run ▶** (or press `Shift + F10`).
