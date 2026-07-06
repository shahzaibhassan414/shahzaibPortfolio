# Portfolio Features

This document summarizes the main features included in Shahzaib Hassan's Flutter portfolio website.

## Core Experience

- Responsive Flutter web portfolio for desktop, tablet, and mobile layouts.
- Smooth single-page scrolling between Intro, About, Experience, Skills, Open Source, Projects, Writing, and Contact sections.
- Desktop navigation bar with quick section links and a compact mobile drawer.
- Resume action available from the navigation experience.
- Dark, polished UI with custom typography, gradients, section spacing, and interactive cards.
- Smooth splash/loading experience before entering the main portfolio.

## Intro Section

- Recruiter-focused hero section for a Senior Flutter Developer profile.
- Clear headline, summary, availability message, and action buttons.
- Lightweight animated device-style hero scene built in Flutter.
- Quick proof points to highlight production app delivery and mobile engineering capability.

## About Section

- Professional summary focused on Flutter, Dart, production mobile apps, and real product integrations.
- Capability chips covering Flutter, payments, maps, authentication, KYC, and app-store releases.
- Profile card and stats area to make the section more credible and visual.
- Direct action to view projects.

## Experience Section

- Timeline-style work history.
- Current Senior Flutter Developer role at Code Encoders.
- Previous Flutter Developer role at Rex Technologies.
- Highlights for production delivery, Figma-to-Flutter implementation, RevenueCat, maps, social login, Web3Auth, KYC, app launches, bug fixing, and UI collaboration.

## Skills Section

- Flutter and Dart skill presentation with progress-style indicators.
- Technical skills covering state management, REST APIs, Firebase, authentication, push notifications, subscriptions, offline support, clean architecture, performance optimization, deployments, payments, ASO, GitHub, UI/UX, and blockchain integration.
- Auto-sliding skill icons for tools and platforms.
- Compact mobile layout with a Show All Skills toggle to reduce scroll length.

## Open Source Section

- Flutter package showcase for published or reusable packages.
- Includes package name, description, version, technology tags, and pub.dev links.
- Current packages include `fancy_button_animations` and `inner_curved_circle`.

## Projects Section

- Project portfolio built from structured project data.
- Featured project carousel for stronger first impression.
- Project filtering by areas such as maps, payments, realtime, Web3, and subscriptions.
- Project cards with images, descriptions, tech stacks, role, timeline, impact, and highlights.
- Detail dialogs for deeper case-study style project overviews.
- Store links where available.

## Featured Projects

- Paw Play Love: social community app with Firebase, sockets, RevenueCat, subscriptions, and cached media flows.
- Simman: realtime audio platform using Firebase Realtime Database and GetX.
- BePay Client: Web3 consumer commerce app with wallet creation, OAuth onboarding, REST APIs, blockchain, and KYC.
- BePay Business: merchant platform with KYB verification, product listings, orders, blockchain, and Provider.
- On Scene: location-aware social app with Google Maps, sockets, Firebase, and RevenueCat.
- LawnOlu: service marketplace with multi-role flows, Google Maps tracking, Stripe, Firebase, and realtime updates.
- Zera: data-heavy app with heatmaps, QR scanning, TanStack Query-style caching, APIs, and in-app web views.
- Jatt App: social app foundation with REST APIs, Firebase, and social login.

## Writing Section

- Blog/article cards for technical writing.
- Current topics include adding heatmaps in Flutter Google Maps and converting SVG designs into Flutter widgets.
- External links to detailed Notion playbooks.

## Contact Section

- Contact form for direct outreach.
- Email and phone contact details.
- Social/profile links through custom icon buttons.
- Friendly closing copy for new project conversations.

## Technical Features

- Built with Flutter and Dart.
- Uses Riverpod for app-level setup.
- Custom responsive helper for web, tablet, and mobile views.
- Scroll-to-section behavior powered by indexed scrolling.
- Uses URL launcher for resume, store, package, article, and profile links.
- Uses custom assets for skills, project previews, icons, splash visuals, and branding.
- Optimized for Flutter web deployment with Vercel configuration and build script.

## Complex Logic Used

- Responsive screen resolver: uses a centralized `getScreenType` helper to detect mobile, tablet, and web breakpoints, then renders separate optimized layouts through a reusable responsive widget.
- Indexed scroll navigation: uses `AutoScrollController` and `AutoScrollTag` so the app bar, mobile drawer, hero actions, project actions, and footer can jump smoothly to exact portfolio sections.
- Section repaint isolation: wraps major page sections in `RepaintBoundary` to reduce unnecessary repaints during scrolling and animations.
- Project filtering engine: builds project filters with matcher functions, then searches across each project's name, description, role, timeline, impact, tech stack, and highlights to classify projects by maps, payments, realtime, Web3, and subscriptions.
- Dynamic project visibility logic: shows a limited number of projects by default, changes the limit based on web or mobile layout, and calculates the remaining project count for the Show More button.
- Featured project carousel: keeps an active featured index, supports previous/next navigation, and uses modulo logic so the carousel loops safely from the first item to the last item and back.
- Project detail flow: opens the same structured project data inside a dialog, keeping cards, featured carousel, and deeper case-study views connected to one source of truth.
- Responsive grid calculation: uses available layout width to switch between one, two, and three project columns, then calculates each card width from the current constraints.
- Mobile skills compression: limits mobile skills to the first eight items by default and expands/collapses the full list with a Show All Skills state toggle.
- Contact form workflow: validates form input, starts a Riverpod-powered loading state, sends the message through the EmailJS API, clears fields on success, and shows success/error toast notifications.
- Email request handling: sends a JSON payload with service ID, template ID, user ID, sender details, formatted timestamp, and message content, with a 10-second timeout and safe failure handling.
- External action handling: launches resume, email, WhatsApp, package, article, social, Play Store, and App Store links with `url_launcher` and availability checks where needed.
- Splash animation sequence: runs a single animation controller with separate curved intervals for entrance and progress, then replaces the splash screen with the main app after the animation completes.
- Custom splash painting: uses a `CustomPainter` grid, rotating logo ring, animated progress bar, and responsive sizing for compact and desktop screens.
- Lightweight 3D hero animation: creates a Flutter-only animated mobile device preview using `AnimationController`, `AnimatedBuilder`, `Transform`, `Matrix4` perspective, rotation, lift, shadows, and floating panels.
- Reduced-motion support: checks `MediaQuery.disableAnimations` and freezes the hero animation values when the user prefers reduced motion.
- Hover interaction system: uses hover state with animated containers, scale transitions, text style changes, and border/background changes for cards, links, buttons, skills, project chips, and contact elements.
- Typewriter text logic: animates text reveal using an animation controller and `StepTween` to progressively display characters.
- Centralized portfolio data model: stores packages, blogs, skills, skill icons, contact details, and project case-study data in `AppClass`, keeping the UI data-driven and easier to update.
- Toast notification system: centralizes success and error UI feedback with consistent styling, placement, timing, progress indicator, and close behavior.

## User Experience Details

- Hover effects on cards, buttons, links, and interactive elements.
- Repaint boundaries around page sections for smoother rendering.
- Mobile-first density improvements to avoid overly long sections.
- Project content designed for recruiters, clients, and technical reviewers.
- Portfolio structure emphasizes real app delivery, integrations, and product impact.
