# Project Stacks & Functionalities

This document provides a detailed overview of the technology stacks, key features, and technical implementations across various projects.

---

## 🛠 Core Technical Stack
- **Framework:** Flutter (Android, iOS, Web)
- **Language:** Dart
- **State Management:** Provider, GetX, Riverpod, Redux
- **Backend/Services:** Firebase (Auth, Firestore, Realtime DB, Cloud Messaging), REST APIs
- **Real-time Communication:** Socket.io, WebSockets
- **Database/Caching:** TanStack Query (Server State), Shared Preferences (Local Storage)
- **Payments & Subscriptions:** Stripe, RevenueCat
- **Maps & Location:** Google Maps API, Heatmaps, Live Tracking
- **Web3 & Blockchain:** Web3Auth, Blockchain Integration
- **Design:** Figma (UI/UX)

---

## 🚀 Projects Breakdown

### 1. Paw Play Love (Social/Community)
*A community-driven platform connecting pet owners through social interactions.*

- **Real-time Chat & Match Updates:** Implemented using **Socket.io** for low-latency communication.
- **Subscriptions & Premium Features:** Integrated via **RevenueCat** for managing cross-platform entitlements (Boosts, Super Likes, Rewinds).
- **Authentication & Push Notifications:** Powered by **Firebase Auth** and **FCM**.
- **State Management:** **Provider** used for lightweight and reactive UI handling.
- **Image Performance:** **Cached Network Image** for smooth scrolling and media loading.

### 2. Simman (Medical Simulation)
*A high-performance platform for live medical simulation sessions.*

- **Real-time Audio Streaming:** Custom architecture built with **Flutter** for low-latency audio transmission.
- **Instant Data Syncing:** Used **Firebase Realtime Database** for immediate instructor-to-student updates during simulations.
- **State Management:** **GetX** utilized for dependency injection and reactive state handling under heavy data loads.
- **Responsive UX:** Designed to remain stable during continuous real-time data changes.

### 3. On Scene (Location-Aware Dating)
*A venue-based social discovery app bridging digital discovery with real-world connections.*

- **Live Venue Check-ins:** Built using **Google Maps** and **Location Services** to facilitate real-world discovery.
- **Real-time Presence updates:** Integrated **Socket.io** with map-based user presence to update nearby activity live.
- **Premium Access:** Managed through **RevenueCat** for multi-platform subscription logic.
- **Engagement Flows:** Powered by **Firebase** for notifications and user engagement.

### 4. LawnOlu (On-Demand Marketplace)
*A service marketplace connecting customers with lawn-care providers.*

- **Live Job Tracking:** Developed with **Google Maps Polylines & Markers** to visualize provider movement in real-time.
- **Secure Payments:** Integrated **Stripe** for handling in-app service transactions.
- **Multi-Role Architecture:** Role-based navigation and state management supporting both Customer and Provider flows in a single codebase.
- **Real-time Updates:** **Socket.io** and **REST APIs** for job lifecycle management.

### 5. Zera (Multi-Vertical Marketplace)
*A unified platform for jobs, goods, services, events, and community.*

- **Server-State Management:** Utilized **TanStack Query** for robust caching, refetching, and predictable API-driven UI updates.
- **Demand Heatmaps:** Custom **Google Maps** integration to visualize high-density marketplace activity.
- **QR Ticket Workflows:** Built with **QR Scanner** for event entry and verification.
- **Data Scaling:** Optimized with pagination-ready data handling for large marketplace listings.

### 6. BePay Client & Business (Web3 Commerce)
*Bridging traditional commerce with decentralized finance.*

- **Web3 Onboarding:** Simplified wallet creation using **Web3Auth** (Social Login based).
- **Blockchain Integration:** Custom flows for blockchain-backed commerce transactions.
- **KYC/KYB Verification:** Multi-step verification flows for user and merchant compliance.
- **Security:** Secure on-device storage for wallet-related metadata.

### 7. Jatt App (Social Networking)
*A foundation for social networking with focused engagement.*

- **Authentication:** Authenticated **REST API** integration with **Dio Interceptors** for token management.
- **Social Login:** Integrated **Firebase Social Auth** for seamless onboarding.
- **Engagement:** Modular **Firebase** services for communication and alerts.

---

## 📦 Open Source Packages

### [fancy_button_animations](https://pub.dev/packages/fancy_button_animations)
- **Stack:** Flutter, Dart, Custom Animations.
- **Functionality:** Provides interactive and beautiful button animations with minimal configuration.

### [inner_curved_circle](https://pub.dev/packages/inner_curved_circle)
- **Stack:** Flutter, Dart, Custom Painters.
- **Functionality:** A widget for creating circles with inner curved effects for custom UI designs.

---

## 📈 Key Technical Highlights
- **Clean Architecture:** Separation of concerns between UI, Business Logic, and Data layers.
- **Performance Optimization:** Efficient use of caching, image optimization, and state management to ensure 60fps performance.
- **Scalability:** Repository-based patterns to handle expanding feature sets.
- **ASO & Deployment:** Experienced in App Store Optimization and deploying high-quality apps to Play Store and App Store.
