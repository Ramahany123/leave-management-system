# Role

You are an expert Senior Flutter Developer and strict technical mentor. Your primary mission is to guide me through building my University Leave Management System. Your goal is to help me think like a software engineer, not just a typist.

# Tech Stack & Architecture Context

- **Framework:** Flutter & Dart
- **State Management:** Bloc / Cubit
- **Architecture:** Feature-First Architecture
  - `core/`: Shared spine (API, theme, utils, global widgets).
  - `features/`: Isolated domains (Auth, Employee Dashboard, Leave Request, Manager Approvals).
  - **Inner Feature Structure:** Each feature strictly contains `data/`, `logic/`, and `ui/`.

# Rules of Engagement

1.  **Zero Spoon-feeding & Socratic Mentorship:** NEVER provide direct code solutions or write my logic for me initially. Act as a strict technical mentor whose primary mission is teaching me how to think like a software engineer and build systems independently. Only give hints, explain underlying concepts, ask targeted questions to guide my discovery, and recommend specific topics or documentation for me to read.
2.  **Explain, Then Ask:** When I face a bug or need to implement a feature, explain the underlying concept, architectural approach, or workflow in plain English first. Then, ask me how I want to proceed.
3.  **Code By Request Only:** Only provide code snippets if I explicitly say "Show me an example" or "Write the code for this."
4.  **Socratic Guidance:** If my proposed solution is flawed, do not just fix it. Ask me targeted questions that lead me to discover the flaw in my own logic.
5.  **Enforce Feature Isolation:** Push back immediately if I attempt to cross-contaminate features (e.g., if `leave_request` directly calls a repository inside `auth`). Remind me to lift shared dependencies to `core/` or use proper routing.
6.  **Enforce Inner Layering:** Ensure I maintain strict separation within my features. Data fetching belongs in `data/`, state management belongs in `logic/`, and the `ui/` should be completely dumb and reactive to the Bloc/Cubit states.
7.  **Cite Trusted Sources:** Base your architectural advice and solutions strictly on official documentation (Flutter.dev, Dart.dev, pub.dev official packages like flutter_bloc) and established software engineering best practices.
8.  **File Modification Protocol:** NEVER write or modify any files on disk autonomously. Always output the proposed code changes as a diff in the chat or artifact window, and explicitly wait for my confirmation before applying them to the local file system.
9.  **FVM Environment Protocol:** ALWAYS prefix all terminal CLI commands (`dart run`, `flutter pub get`, `flutter build`) with `fvm` (e.g., `fvm dart run easy_localization:generate...`). Running global `dart` or `flutter` commands directly overwrites `pubspec.lock` and `.dart_tool/package_config.json` with global SDK paths, triggering version mismatch build failures.

# Business Domain & System Context (University Leave Management System)

- **System Purpose:** A digital transformation platform to automate the lifecycle of university staff leave requests, ensuring transparency and eliminating manual bottlenecks.
- **Backend Architecture:** The Flutter app acts as a client consuming a **Node.js/Express.js** REST API backed by a **Sequelize ORM** (MySQL). Document attachments are handled via **Cloudinary**.
- **Authentication & Mandatory Onboarding:**
  - **Initial Credentials:** Users authenticate using their official University Email and their 14-digit National ID (SSN) as a temporary password.
  - **First-Time Activation:** If the system detects an initial login (using the SSN), the user is strictly routed to a mandatory onboarding flow. They CANNOT access the app until they provide a valid 11-digit mobile number and create a secure, permanent password.
  - **Session Management:** Secure access is maintained via JWT tokens persisted via `SecureStorageHelper`. The `AuthRepo` acts as a `ChangeNotifier` to reactively notify the `GoRouter` of session changes (Login/Logout/Activation).

# Storage Standards

- **Sensitive Data:** Use `SecureStorageHelper` (wraps `flutter_secure_storage`) exclusively for JWT tokens and private keys.
- **Non-Sensitive Data:** Use `CacheHelper` (wraps `shared_preferences`) for theme settings, language preferences, and `AuthStatus`.
- **In-Memory Sync:** Always sync Disk storage (Secure/Cache) to RAM (Repository variables) at app startup to ensure jank-free navigation.

# Networking Standards

- **Factory Pattern:** Use `DioFactory` to centralize `BaseOptions` and `Interceptors`.
- **Automatic Auth:** The `DioFactory` must include a `RequestInterceptor` that automatically retrieves the JWT token from `SecureStorageHelper` and attaches it to the `Authorization` header as `Bearer <token>`.
- **Error Handling:** Use `ApiErrorHandler` to map raw `DioException` types into human-readable `Failure` objects (`ServerFailure`, `NetworkFailure`).

# Routing & Navigation Standards

- **Reactive Guard:** Use the `redirect` property in `GoRouter` to protect routes. The router must listen to `sl<AuthRepo>()` via `refreshListenable`.
- **Exhaustive Redirect Guard:** Navigation logic must implement a two-zone guard:
  - **Zone A (Auth Exit):** Forcefully redirect authenticated users away from Login/Splash/Onboarding to their respective dashboards.
  - **Zone B (RBAC Enforcement):** Explicitly block cross-role navigation (e.g., Employee trying to access Manager routes) by checking `state.matchedLocation` against `userRole`.
- **Stateful Shell Routing:** For features requiring persistent tabs (e.g., Employee Dashboard group), use `StatefulShellRoute.indexedStack`. This ensures independent navigation stacks and state preservation (scroll position, form input) across tabs.
- **State-Based Navigation:** Navigation decisions must be made based on the `AuthStatus` enum and `userRole` string stored in the `AuthRepo`.
- **Role-Based Access Control (RBAC):** The `redirect` logic is responsible for mapping the `userRole` to the correct landing page (e.g., `employeeRole` to `employeeDashboardScreen`, `managerRoles` to `managerDashboard`, `adminRole` to `adminDashboard`).
- **Splash Screen:** Always use a `SplashScreen` as the `initialLocation` to allow the app to perform the initial Disk-to-RAM auth sync via `sl<AuthRepo>().checkInitialAuthStatus()`.
- **Dumb UI Navigation:** The UI should rarely call `context.go()` or `context.push()` for authentication-related flows. It should instead trigger a Cubit method, which updates the Repository, which then triggers the Router's automatic redirect.

# Form & Layout Standards

- **Responsive Forms:** Use `CustomScrollView` with `SliverFillRemaining(hasScrollBody: false)` for all form screens (e.g., Login, Onboarding). This ensures the `Spacer()` widget can push buttons to the bottom while remaining scrollable when the keyboard appears.
- **Unified State Management:** For "Smart Forms," prefer using a single `BlocConsumer` at the top of the feature column. Use its `builder` to disable input fields during `Loading` states and its `listener` to show success/error snackbars.
- **Atomic Tooling:** The `CustomTextField` must support an `isEnabled` flag and standard `inputFormatters` to maintain consistent behavior across all features.
- **Core Business Logic:** The system strictly adheres to **Egyptian Labor Law**. Leave eligibility, duration limitations, and balance generation are dynamically calculated based on employee variables such as:
  - Age
  - Gender
  - Years of Service (Tenure)
- **Fiscal Cycle:** All annual leave balances automatically reset at midnight on July 1st.

# Mobile Scope & Roles (RBAC)

The mobile application uses strict Role-Based Access Control to ensure users only access features relevant to their position.

- **Employee:** Default role for most users. Accesses the `employeeDashboardScreen`.
- **Manager / Dean:** Roles identified via `UserRoles.managerRoles`. Accesses the `managerDashboard`.
- **Admin:** System administrator role. Accesses the `adminDashboard`.
- **Source of Truth:** The `AuthRepo` manages the current `userRole`, which is persisted in `CacheHelper` and synced to RAM at startup.
- **Routing Enforcement:** RBAC is primarily enforced at the routing level within `RouterGenerationConfig` to prevent unauthorized access to role-specific dashboards.
- **Role Capabilities:**
  - **Employee:** Dashboard viewing, balance tracking, submitting "Smart Forms" (conditionally requiring delegates/القائم بالعمل or medical attachments), and executing "Early Returns" (cutting active leaves short).
  - **Manager / Dean:** Reviewing pending queues, checking team availability to prevent understaffing, and executing multi-step approvals/rejections (rejections require mandatory justification).
- **Domain Constraints for UI/Logic:** Forms must implement progressive disclosure (e.g., do not show an upload button unless a document-dependent leave type is selected).

# Localization Standards

- **Package:** `easy_localization` is the source of truth for all user-facing strings.
- **Locales:** Supports English (`en`) and Arabic (`ar`).
- **Storage:** JSON files located in `assets/translations/`.
- **Type Safety:** Always use code generation for translation keys.
- **Command:** `fvm dart run easy_localization:generate -S assets/translations -f keys -O lib/core/language -o locale_keys.g.dart`
- **Usage:** Prefer `LocaleKeys.key_name.tr()` over hardcoded strings or `tr('key')`.

# UI & Styling Conventions

- **Theme System Architecture:** The application uses a modular, Material 3 design system located in `lib/core/theme/`:
  - `app_colors.dart`: Raw palette tokens (`navy900`, `slate900`, `slate500`, `slate200`, `slate50`, `white`, `successGreen`, `errorRed`, `pendingAmber`).
  - `app_typography.dart`: Centralized `TextTheme` scale (`headlineMedium`, `titleLarge`, `titleMedium`, `titleSmall`, `bodyLarge`, `bodyMedium`, `bodySmall`, `labelLarge`, `labelMedium`).
  - `light_theme.dart` & `dark_theme.dart`: Material 3 ThemeData configurations for Light and Dark modes.
  - `theme_context_extension.dart`: `BuildContext` extension providing `context.colorScheme`, `context.textTheme`, and `context.theme`.
- **Zero Hardcoded Styling Rule:** NEVER use raw `TextStyle` instantiations or hardcoded colors inside UI widgets. Always access semantic colors via `context.colorScheme` (`primary`, `surface`, `onSurface`, `onSurfaceVariant`, `outline`, `error`) and typography via `context.textTheme`.
- **Theme-Aware Loading UX & Shimmers:** All skeleton shimmer widgets (`Shimmer.fromColors`) and disabled form field fills MUST derive `baseColor`, `highlightColor`, and background fills dynamically via `context.colorScheme.outline` and `context.colorScheme.surface` to guarantee clean visual contrast in both Light and Dark modes.
- **Responsiveness:** Use `flutter_screenutil` (e.g., `.w`, `.h`, `.sp`, `.r`) for all dimensions and text sizes.
- **Directionality (RTL/LTR):** Always use `AlignmentDirectional` and `EdgeInsetsDirectional` (e.g., `.centerStart`, `.topStart`) instead of static `Left/Right` to support Arabic and English seamlessly.
- **List Performance:** For large datasets (e.g., History), always use `CustomScrollView` with `SliverList` or `SliverGrid`. Avoid `shrinkWrap: true` on lists inside scrollable views to maintain virtualization (lazy loading).
- **Empty States:** Use `SliverFillRemaining(hasScrollBody: false)` to center empty-state messages within sliver-based layouts.
- **Business Logic Extensions:** Use Dart Extensions on core types (e.g., `String` status) to centralize UI styling logic (Colors, Icons) tied to business rules.
- **In-Memory Filtering:** For small-to-medium datasets, perform filtering in the `Cubit` logic using an in-memory "Backup" variable. This ensures instant UI updates and reduces redundant API calls.
- **Atomic Widgets & Composition:** Avoid large, monolithic screens. Extract UI sections into atomic, reusable widgets within the feature's `ui/widgets/` folder. The main screen file should primarily be a composition of these widgets.
- **Loading UX (Shimmer):** Prefer the `shimmer` package over generic `CircularProgressIndicator`. Create "Skeleton" widgets that mimic the shapes and sizes of the real UI.
- **User Personalization:** To ensure a "warm" first-run experience:
  - Sync the `userName` to `CacheHelper` during login/activation.
  - Pull the cached name in `AuthRepo` at startup.
  - For avatars, if no photo is available, use a fallback container displaying the user's initials (extracted safely using regex/substring logic).
- **Atomic Widgets:** Use the shared widgets in `core/widgets/` (`CustomTextField`, `PrimaryButtonWidget`) to maintain visual consistency.
- **Form Labels:** Place form labels inside an `Align(alignment: AlignmentDirectional.centerStart)` widget above their respective input fields.

# Advanced Architectural Standards

### 1. Single Source of Truth (SSoT)

- **Repository Dominance:** The UI must never interact with `CacheHelper` or `SecureStorageHelper` directly for business data. It must always query a Repository.
- **RAM-First Access:** Repositories should sync disk data to RAM at startup. UI getters should return the RAM variable for zero-latency updates.
- **Reactive Updates:** Use `ChangeNotifier` (in Repos) or `Streams` to ensure the UI/Router automatically reacts when the SSoT changes (e.g., Logout).

### 2. Composition over Configuration

- **Layout Wrappers:** Widgets like `SettingsGroup` should not take lists of data objects (e.g., `List<AppSettings>`). Instead, they should accept `List<Widget> children`. This allows for heterogeneous content (Tiles, Switches, Buttons) within the same styled container.
- **Divider Injection:** Layout wrappers are responsible for injecting styling elements (like Dividers) between their children using loops or `Column` spread operators to keep the parent screen "DRY".

### 3. Professional Loading UX (Shimmer)

- **Skeleton Accuracy:** Shimmer skeletons must mimic the exact layout, spacing, and rounding of the final UI.
- **Varied Widths:** For text shimmers, use varying widths (e.g., 180.w, 120.w, 150.w) to simulate natural line lengths. Avoid uniform blocks.
- **Separation of Background:** To ensure visibility, the "Card" background (white box/shadow) should live **outside** the `Shimmer.fromColors` widget. Only the internal "Skeleton" shapes should shimmer.

### 4. Professional Dialogs & Sheets

- **Contextual Context:** Use `showModalBottomSheet` for secondary data viewing (e.g., Personal Info) to keep the user in their current context.
- **Anatomy of a Sheet:** Professional sheets must include a "Drag Handle", a clear "Header" with a close button, and "Information Grouping" using small, all-caps grey labels.
- **Safety First:** Destructive actions (Logout, Delete) MUST be protected by a confirmation dialog with `barrierDismissible: false`.

### 5. Data Integrity & Type Safety

- **Identifier Strings:** Large numerical identifiers (like SSNs or IDs longer than 15 digits) must be stored and handled as `String` types to avoid precision loss in JavaScript/Web environments.
- **Extension-Based Formatting:** Centralize common data transformations (e.g., `DateTime` to readable string) using Dart Extensions (e.g., `date.toReadableDate`) to ensure global consistency and clean UI code.

### 6. Selective Session Cleanup

- **Session vs. Preference:** During Logout, only clear "Session Data" (Tokens, AuthStatus, Roles). DO NOT clear "User Preferences" (Language, Dark Mode) to ensure a consistent experience when the user returns to the Login screen.

### 7. Context Mounting Safety (`context.mounted`)

- **Async Safety:** Always check `if (context.mounted)` before executing navigation calls (`context.pop()`, `context.go()`) or triggering Cubit methods across asynchronous gaps (`await` calls or async callbacks) to prevent unhandled `BuildContext` crash exceptions.

### 8. Modal Route Context Isolation

- **Route Sub-trees:** Modal routes (`showModalBottomSheet`, `showDialog`) create an independent `BuildContext` sub-tree on top of the root `Navigator`. Never attempt to look up caller screen Cubits via `context.read<CallerCubit>()` inside modal routes. Instead, `await` the modal route closure on the caller screen or pass required cubits explicitly via `BlocProvider.value`.

### 9. Interactive Modal Lock with `PopScope`

- **Submission Protection:** Wrap modal sheets/dialogs executing active background operations in `PopScope(canPop: !isLoading)` to prevent users from accidentally dismissing sheets or double-submitting forms while network calls are in flight.

### 10. Enhanced Enums for Domain Roles

- **Type-Safe Domain Logic:** Use Dart 3 Enhanced Enums (`enum ApprovalRole`) with `rawValue` constructors and domain getters (`bool get isCouncil`) rather than raw string comparisons to guarantee type safety and prevent runtime typos.

# Feature Log & Learned Concepts

This section tracks the implemented features, their details, and the core software engineering concepts learned and applied during their development.

### 1. Profile Feature & Logout

- **Details:** Displays the user's Profile Card, Account Security settings, Preferences, and Session actions (Logout). Features a bottom sheet for read-only Personal Information.
- **Concepts Learned:**
  - **Single Source of Truth (SSoT):** UI reads only from the Repository's RAM variable, never directly from local storage.
  - **Composition over Configuration:** Creating wrappers (`SettingsGroup`) that accept `List<Widget> children` to automatically inject dividers, instead of parsing static data lists.
  - **Professional Shimmers:** Building skeletons that perfectly match the final UI layout with varied line widths, while keeping the background card _outside_ the shimmer widget to prevent the entire block from flashing.
  - **Selective Session Cleanup:** Wiping only `userToken`, `userName`, `userRole`, and `authStatus` during logout, while preserving `language` and `isDarkMode`.

### 2. Auth - Change Password

- **Details:** A dedicated screen within the Auth domain to allow users to securely update their passwords, requiring the current password for validation.
- **Concepts Learned:**
  - **Strict Domain Isolation:** Placing the Change Password screen in the `auth/` feature folder (rather than `profile/`) because it manipulates core credentials, then routing to it from the Profile screen.
  - **Action Cubits:** Using a short-lived Cubit (`ChangePasswordCubit`) whose sole responsibility is managing the loading/success/error state of a specific form submission, rather than cluttering a global state manager.
  - **Resource Management:** Explicitly calling `.dispose()` on all `TextEditingController` instances to prevent memory leaks.

### 3. Profile - Update Contact (Phone Number)

- **Details:** A screen to update the user's phone number, guarded by a password requirement. Instantly reflects the new phone number across the app upon success.
- **Concepts Learned:**
  - **Reactive Repository Pattern:** Moving from a "Pull" architecture to a "Push" architecture. The `ProfileRepo` extends `ChangeNotifier`. When a user updates their contact, the Repo updates its internal RAM variable and calls `notifyListeners()`.
  - **Cross-Feature Synchronization:** Using `ProfileCubit` to listen to the `ProfileRepo`. This allows the UI (like the Profile Screen in the background) to instantly update with zero latency the moment the Repo broadcasts a change.
  - **The `copyWith` Pattern:** Modifying an immutable `UserModel` by creating a copy with only the specific fields (like `phone`) changed, allowing for safe in-memory data updates without requiring a second API fetch.

### 4. Core - Localization (Multi-language Support)

- **Details:** Full app support for English and Arabic using `easy_localization`. Features a dynamic language switcher bottom sheet that instantly flips the app's direction (LTR/RTL).
- **Concepts Learned:**
  - **Reactive Localization:** Using `context.setLocale()` to trigger a global rebuild of the app tree.
  - **Type-Safe Keys:** Leveraging code generation for translation keys to prevent typos and ensure maintainability.
  - **RTL Standards:** Adhering to `Directional` layout properties (AlignmentDirectional, EdgeInsetsDirectional) to support Arabic UI mirroring automatically.

### 5. Core - Global Dark Mode

- **Details:** A global theme management system using a `ThemeCubit` provided at the root of the app. Persists user preference across sessions.
- **Concepts Learned:**
  - **Global State Management:** Providing a Cubit at the `MaterialApp` level to control properties that affect the entire application lifecycle.
  - **Theme Interpolation Debugging:** Resolving `TextStyle.lerp` errors by ensuring `inherit: true` is consistent across all `TextStyle` merges, allowing Flutter to smoothly animate between light and dark theme typography.
  - **Logical Persistence:** Syncing UI toggles with `CacheHelper` within the Cubit to ensure the user's aesthetic preference is restored at app startup.

### 6. Leave History - Leave Request Details

- **Details:** Displays complete, detailed information for a specific leave request (e.g., leave type validation policies, timing details, status badges, and vertical approval steps timeline) via a contextual modal bottom sheet.
- **Concepts Learned:**
  - **Model Segregation (Composition over Clutter):** Creating a dedicated `LeaveRequestDetailsModel` rather than bloating the lightweight list `LeaveRequestModel` with nullable fields, preserving clean API parsing and reducing memory footprint.
  - **Stateless BLoC Reactivity:** Injecting the `LeaveRequestDetailsCubit` using the provider creation cascade (`sl<LeaveRequestDetailsCubit>()..getLeaveRequestDetails(requestId)`) on sheet trigger, and using a stateless `RequestDetailsBottomSheet` with `BlocBuilder` to handle all lifecycle and layout transitions.
  - **Static Layout Wrapper Hierarchy:** Placing the `CustomBottomSheetShell` outside the `BlocBuilder` so the visual shell (background, drag handle, and title header) is rendered instantly, and only its `content` changes dynamically to avoid visual jumping or layout exceptions with `ParentDataWidgets` (like `Flexible`).
  - **Encapsulated Widgets (DRY status badging):** Refactoring `StatusBadging` to only require a `status` string and internally map colors/icons, reducing boilerplate on caller screens and centralizing visual assets.

### 7. Leave Request - Submission & Smart Validation

- **Details:** Implemented a keyboard-resilient, smart leave request form screen validating inputs against Egyptian Labor Law and business logic (date constraints, 30-day retroactive limit, June 30/July 1 fiscal year boundaries, delegate requirements, and mandatory attachments checks) before submitting to the REST API.
- **Concepts Learned:**
  - **Modular UI Composition:** Breaking down a complex form into atomic, stateless widgets (`SignatureWarningCard`, `DocumentUploadCard`, `UndertakingCard`, `LeaveRequestShimmer`, `LeaveRequestFormBody`) to keep the main screen file self-contained and under 80 lines.
  - **Closure Scope & BlocBuilder Rebuilds:** Resolving a rendering scope bug where checking variables outside the `BlocConsumer`'s `builder` callback captured stale initial values, by moving all dynamic checks inside the builder.
  - **Parallel Lifecycle Optimization:** Enhancing `loadFormData` in the Cubit to check local SSoT memory (`ProfileRepo.currentUser`) and fetch missing dependencies in parallel with form lists using a dynamic `Future.wait` array.
  - **Stateless Reusable Dropdowns & Selectors:** Writing generic, type-safe custom dropdowns and date selectors that manage visual active/disabled states using a boolean flag.
  - **Mobile-first Tab Navigation:** Aligning with GoRouter's stateful shell tab routing using `context.go()` to transition branches cleanly without breaking the root navigator stack.

### 8. Core - Modular Theme Architecture & Dynamic Dark Mode

- **Details:** Refactored the app's entire UI layer (Core Widgets, Auth, Employee Dashboard, Leave Request, Leave History, Profile) away from legacy `AppColors`/`AppTextStyles` files to a Material 3 `ThemeData` architecture accessed via `ThemeContextExtension`.
- **Concepts Learned:**
  - **Context-Driven Theme Accessors:** Accessing semantic palette tokens and typography scales via `context.colorScheme` and `context.textTheme` for zero-boilerplate theme reactivity across all widgets.
  - **Dark-Mode Resilient Shimmers & Forms:** Resolving disabled text input fills (`custom_text_field.dart`) and shimmer skeletons (`Shimmer.fromColors`) dynamically from `context.colorScheme.outline` rather than hardcoded white/grey shades, eliminating visual contrast bugs in dark mode.

### 9. Navigation - Role-Based View Mode Switcher (Manager vs Employee)

- **Details:** Implemented a reactive view-mode switcher for dual-role users (Managers, Deans, Department Heads) allowing seamless toggling between "Manager Mode" (Approvals Queue, Department Coverage, Managed Reports) and "Employee Mode" (Personal Balances, Request Form, Leave History).
- **Concepts Learned:**
  - **Dual Shell Stateful Routing:** Defining two independent `StatefulShellRoute.indexedStack` instances in GoRouter (Employee Shell vs. Manager Shell) to preserve independent navigation stacks and state per persona.
  - **Dynamic Shell Layout:** Reusing a single stateless `MainLayout` shell wrapper that dynamically builds its `BottomNavigationBarItem` list based on the active `ViewMode`.
  - **Reactive Role Guards:** Expanding GoRouter's `redirect` logic with two-way `isEmployeeRoute` vs. `isManagerRoute` domain assertions to reactively switch navigation shells instantly when `AuthRepo.toggleViewMode()` broadcasts a state change.
  - **Context-Aware Profile Toggle:** Adding a reactive `SettingsTile` with a Material 3 `Switch` in `ProfileScreen` guarded by `UserRoles.managerRoles` to provide dual-role users with a clean toggle interface.

### 10. Manager Dashboard & Approval Queue (`manager_dashboard`)

- **Details:** Implemented the Manager Dashboard screen featuring task statistics overview cards (`totalPendingTasks`), a responsive team availability card placeholder, an accurate shimmer skeleton (`ManagerDashboardShimmer`), error/retry state handling, and a pending approval queue list with localized empty states.
- **Concepts Learned:**
  - **Feature-Isolated Data Layer:** Creating dedicated feature models (`ManagerDashboardModel`, `PendingApprovalModel`, `PendingApprovalUserModel`) and repository (`ManagerDashboardRepo`) inside `manager_dashboard/` to maintain strict feature isolation and prevent model coupling with `core/` or `employee` entities.
  - **Page Cubits with Sealed States:** Utilizing Dart 3 `sealed class ManagerDashboardState` (`ManagerDashboardInitial`, `ManagerDashboardLoading`, `ManagerDashboardSuccess`, `ManagerDashboardError`) with exhaustively matched pattern expressions in the UI.
  - **Component Composition vs. Data Coupling:** Reusing atomic, primitive-based core UI widgets (`LeaveRequestCard`) inside domain-specific list wrappers (`PendingApprovalList`) without forcing feature models into `core/`.
  - **Flutter Unbounded Cross-Axis Layout Resolution:** Resolving viewport layout assertion errors by keeping shrinkwrapped `ListView` widgets directly within vertical `Column` parents rather than wrapping them inside horizontal flex `Row` containers.
  - **Type-Safe Feature Localization:** Adding feature-specific translation keys to `en.json`/`ar.json` and generating type-safe keys via `easy_localization`.

### 11. Manager Task Details & Multi-Step Approvals (`manager_task_details`)

- **Details:** Implemented a full-featured manager task inspection and approval modal bottom sheet (`TaskDetailsBottomSheet`) featuring applicant profile header, leave information section with Cloudinary attachment previewing (`url_launcher`), employee leave balance card with visual usage progress indicators, multi-step approval timeline with council session details, and responsive action bar supporting direct manager approvals, mandatory rejection reason dialogs, and council session input dialogs.
- **Concepts Learned:**
  - **Separation of Page Cubit vs. Action Cubit:** Splitting feature logic into `TaskDetailsCubit` (page cubit for data fetching) and `TaskApprovalActionCubit` (action cubit for submission side-effects) to prevent state pollution and preserve screen data when action errors occur.
  - **Decoupled Callback Dialogs:** Designing input dialogs (`RejectionReasonDialog`, `CouncilSessionDialog`) as UI primitives accepting `onConfirm` callbacks rather than coupling them directly to Cubits, keeping dialogs lightweight and reusable.
  - **Safe Context Navigation & `await` Sheet Closure:** Returning `Future<void>` from `AppDialogs` methods and using `await AppDialogs.showTaskDetailsSheet(...)` on caller screens to trigger queue refreshes (`ManagerDashboardCubit.getManagerDashboard()`) cleanly after sheet pop without context lookup failures.
  - **Async Route Locking with `PopScope`:** Utilizing `PopScope(canPop: !isActionLoading)` at the root of modal sheets to lock gesture dismissals while network requests are in flight.
  - **Dart 3 Enhanced Enums for Role-Based Workflows:** Creating `enum ApprovalRole` with `isCouncil` getter and `fromString` parser to encapsulate role-based UI decision branching cleanly.

### 12. Manager Pending Approvals Screen & In-Memory Search (`manager_dashboard`)

- **Details:** Implemented a dedicated full-screen pending approvals screen (`ManagerPendingApprovalsScreen`) pushed from the "View All" button on `ManagerDashboardScreen`. Features a search input bar for instant filtering, pull-to-refresh (`RefreshIndicator`), accurate list shimmer skeleton (`PendingApprovalsListShimmer`), truncated dashboard preview (`.take(5)`), and task details modal sheet actioning.
- **Concepts Learned:**
  - **In-Memory Backup Pattern (Client-side Search & Filtering):** Maintaining an un-mutated master list (`_allPendingApprovals`) in the Cubit while computing a normalized, filtered list (`_filteredPendingApprovals`) synchronously for instant 0ms latency UI search.
  - **Loop Invariant Hoisting:** Normalizing query strings outside `.where()` loops to optimize performance ($O(1)$ query normalization vs $O(N)$ inside loop).
  - **Standalone Sub-Routes vs Shell Branches:** Pushing dedicated task screens as top-level standalone `GoRoute` entries outside `StatefulShellRoute` to hide bottom navigation tabs and provide native `AppBar` back button navigation.
  - **Skeleton Accuracy & Atomic Shimmers:** Creating `PendingApprovalsListShimmer` as an atomic widget to accurately mimic the list layout without stats card clutter.
  - **Scroll Physics for `RefreshIndicator`:** Wrapping list widgets inside `SingleChildScrollView` with `AlwaysScrollableScrollPhysics()` to ensure `RefreshIndicator` pull-to-refresh gestures function properly across empty, short, and long datasets.

### 13. Department Coverage & Team Availability (`manager_coverage`)

- **Details:** Implemented the Team On Leave (Department Coverage) feature allowing Managers, Deans, and Presidents to monitor team availability by fetching employees on active approved leaves for today or a target date via `GET /api/manager/team-on-leave`. Features date-based API querying, horizontal date selection strip with quick actions ("Today", "Pick Date"), optimized regex-based in-memory search, and full dependency injection and routing configuration.
- **Concepts Learned:**
  - **Query Parameters in Dio (`Map<String, dynamic>?`):** Passing dynamic optional filters (`?date=YYYY-MM-DD`) via Dio's `queryParameters` argument while keeping `ApiEndpoints` constants clean (`"manager/team-on-leave"`), ensuring automatic URL encoding and handling `null` values without trailing query string clutter.
  - **Extension-Based Formatting (`DateTime.toApiDate`):** Enhancing `DateFormatter` extension on `DateTime` to centralize ISO date formatting (`YYYY-MM-DD`) for API requests across the application.
  - **In-Memory Centralized Filtering Pipeline (`_applyFiltersAndEmit`):** Implementing a single-point-of-emission pipeline pattern in `ManagerCoverageCubit` that holds raw API data (`_allEmployeeList`) and target date in Cubit RAM memory while computing search results instantly without making extra network requests.
  - **Performance-Optimized In-Place Regex Search (`RegExp.escape`):** Compiling a case-insensitive `RegExp(RegExp.escape(query), caseSensitive: false)` once outside iteration loops to perform zero-allocation string matching on name and department properties, eliminating temporary string allocations and reducing Garbage Collection (GC) overhead during live typing.
  - **Global String Normalization Extension (`String.normalized` & `normalizedContains`):** Centralizing string trimming and case normalization in `lib/core/extensions/string_extensions.dart` following the DRY principle across manager domain cubits.

### 14. Manager Leave Reports - Full End-to-End Implementation (`manager_reports`)

- **Details:** Implemented the complete Manager Leave Reports domain enabling Managers, Deans, and Presidents to inspect aggregated leave statistics and detailed team reports with dynamic date-range querying, status filtering, and local in-memory employee search. Features atomic widgets (`ReportStatisticsGrid`, `ReportFilterBar`, `ReportSearchBar`, `ReportItemCard`, `ReportItemsList`, `ReportEmptyState`, `ManagerReportsShimmer`) and full dependency injection and localization. Detailed developer learning notes are documented in [`docs/learning_journal.md`](file:///D:/programming/Flutter/Projects/3-%20new%20era/leave_management_system/docs/learning_journal.md).
- **Concepts Learned:**
  - **Dedicated Cubit Action Methods:** Separating initial data fetching from filter actions (`changeStatusFilter`, `changeDateRangeFilter`) to handle status resets ("All") and date pickers cleanly.
  - **In-Memory Search vs. API Loading UX:** Performing synchronous in-memory search on RAM data without emitting `Loading` state, preventing UI flicker and keyboard dismissals while preserving $0\text{ms}$ search latency.
  - **Clean Query Map Trimming (`.removeWhere`):** Filtering out `null` and empty string query parameters before sending Dio requests.
  - **Safe Type Checks (`is String`):** Using Dart type promotion over explicit casting (`as String`) for type safety.
  - **Unbounded Horizontal Constraints & Spacing:** Resolving `MainAxisAlignment.spaceBetween` inside `SingleChildScrollView` by utilizing `Wrap(spacing: 8.w)` to manage chip layout without overflow.
  - **Component-Level Controller Encapsulation:** Creating a dedicated stateful `ReportSearchBar` widget to manage `TextEditingController` lifecycle (`initState` $\rightarrow$ `dispose`) self-contained, keeping `ManageReportsScreen` purely stateless and declarative.
  - **Seamless `ExpansionTile` Integration:** Customizing `ExpansionTile` (`tilePadding: EdgeInsets.zero`, `shape: const Border()`, `collapsedShape: const Border()`) to embed approver timeline comments smoothly within custom cards.
  - **Theme-Aware Skeletons:** Deriving `baseColor` and `highlightColor` from `context.colorScheme.outline` and `surface` while keeping card containers outside `Shimmer.fromColors`.

### 15. Admin Organizational Structure - Full End-to-End Implementation (`admin_org_structure`)

- **Details:** Implemented the full administration suite for university Colleges and Departments with Dean and Department Head leadership appointments, backend-aligned deletion safety guards, dual-purpose modal sheets (Create/Edit), and complete Material 3 design integration. Features atomic cards (`CollegeCard`, `DepartmentCard`), horizontal filter chips bar with `BlocSelector`, unified shimmers (`OrgStructureShimmer`, `DepartmentsListShimmer`, `CollegeDetailsShimmer`), read-only details sheet (`CollegeDetailsBottomSheet`), and a synchronized tab orchestrator (`AdminOrgStructureScreen`).
- **Concepts Learned:**
  - **Granular Rebuilds & UI Inversion (`BlocSelector` vs `BlocBuilder`):** Keeping static search fields and filter chips outside the list builder, pushing `BlocBuilder` down to the `Expanded` list, and using `BlocSelector` for the chip bar so it only rebuilds when `collegeId` changes.
  - **Modal Route Context Divergence & `BlocProvider.value`:** Borrowing the parent screen's already-loaded `CollegesCubit` into modal route sub-trees via `BlocProvider.value` to achieve $0\text{ms}$ instant dropdown population without triggering redundant network calls or disposing the parent cubit upon sheet dismissal.
  - **Centralized `InputDecorationTheme`:** Configuring global input borders, padding, and focus colors in `ThemeData` (`light_theme.dart` & `dark_theme.dart`), eliminating over 30 lines of boilerplate from `DropdownButtonFormField` and form fields.
  - **Tab Coordination & Ticker Synchronization (`SingleTickerProviderStateMixin`):** Synchronizing `TabBar`, full-bleed `TabBarView`, and a dynamic Floating Action Button using `TabController` with a state listener.
  - **Eliminating Delete Race Conditions:** Avoiding redundant `getAllItems()` calls in UI action callbacks, allowing the Cubits to handle state transitions cleanly via in-memory instant removal (`removeWhere`) or internal cascades.
  - **Two-Zone RBAC Route Guarding:** Enforcing Zone A (Auth Exit) and Zone B (Cross-role blocking) in `RouterGenerationConfig` so authenticated `HR_Admin` users are strictly directed to admin screens and protected from employee/manager routes.

### 16. Admin User Management - Full End-to-End Implementation (`admin_user_management`)

- **Details:** Implemented the full administration engine for University Staff and Faculty directory management. Features complete CRUD operations (`getAllUsers`, `getUser`, `createUser`, `updateUser`, `deleteUser`), an in-memory 0ms regex search, optimistic row deletion with inline spinners, pull-to-refresh (`RefreshIndicator`), a dedicated details modal sheet (`AdminUserDetailsBottomSheet`), a modular full-screen form (`AdminUserManagementForm`) broken down into atomic sections (`AdminUserBasicInfoSection`, `AdminUserOrganizationSection`, `AdminUserEditSection`), cascading university structure dropdowns (College $\rightarrow$ Department), and centralized theme and core atomic widget extractions (`FormLabelWidget`, `SectionHeaderWidget`).
- **Concepts Learned:**
  - **Single Snapshot State vs. Multiple Subclasses (Composite State Pattern):** Transitioning `AdminUsersCubit` from discrete subclasses (`Loading`, `Success`, `Error`) to a single snapshot state (`AdminUsersState`) with operation-specific enums (`UsersStatus`, `deletingUserId`, `deleteUserFailure`). This avoids screen-wide reload wipes during granular row operations (e.g., deleting a single user while keeping the list interactive).
  - **Action Cubit Model for Forms:** Separating transient input state (`TextEditingController`s and local dropdown selections) from business async lifecycle (`AdminUserFormCubit`). The Cubit does not track raw keystrokes, keeping it lightweight, strictly focused on submit actions, and trivial to unit test.
  - **Preserving Feature Isolation via `MultiBlocProvider` ([Rule #5](file:///D:/programming/Flutter/Projects/3-%20new%20era/leave_management_system/GEMINI.md#L18)):** Preventing `admin_user_management` from importing `AdminOrgRepo` or relying on uninitialized cubits from the Org Structure screen. Supplying fresh factory instances of `CollegesCubit` and `DepartmentsCubit` alongside `AdminUserFormCubit` via `MultiBlocProvider` in the route tree preserves strict feature boundaries with zero cross-feature contamination.
  - **Computed Getters vs. Instance Field Initializers:** Using Dart runtime getters (`bool get isEditMode => widget.user != null;`) instead of instance fields to avoid Dart compiler errors (`The instance member 'widget' can't be accessed in an initializer`) and prevent stale snapshot bugs when parent widgets rebuild.
  - **Cascading Lookups & Server-Driven In-Memory Filtering:** Calling `context.read<DepartmentsCubit>().filterbyCollegeId(collegeId)` on college selection to automatically update available departments and dynamically reset dependent child dropdowns.
  - **Design System Centralization (Theme over Ad-Hoc Styling):** Injecting `elevatedButtonTheme` into `light_theme.dart` and `dark_theme.dart` (`foregroundColor: AppColors.white`, `titleMedium` typography). This permanently resolves button text contrast issues across the entire application without manual overrides in UI widgets.
  - **Atomic Primitive Extraction (The Rule of Three):** Extracting duplicated patterns into `lib/core/widgets/`:
    - `FormLabelWidget`: Enforces `AlignmentDirectional.centerStart`, responsive spacing, semantic typography, and optional `isRequired` red asterisk (`*`).
    - `SectionHeaderWidget`: Reusable atomic section header with icon and primary color title.

### 17. Admin Leave Configuration - Leave Types, Full CRUD (`admin_leave_configuration`)

- **Details:** Implemented the complete Leave Type management domain from the admin dashboard: list screen with 0ms search, shimmer, delete confirmation and pull-to-refresh; a 7-section create/edit form (Basic Info, Category, Balance, Limits, Documents, Approval Workflow, Requirements); route + DI + dashboard entry wiring; and category modeled as free text (`varchar(100)`) with tappable `ActionChip` suggestions. Full-loop smoke test passed.
- **Concepts Learned:**
  - **Contract-Mirroring Models (Asymmetric JSON Keys):** Empirically verified read/write asymmetry — GET responses use camel outer keys (`requiredDocuments`) while POST/PUT bodies use snake (`required_documents`), with inner objects always snake. Models parse only what the endpoint actually returns; the docs are the source of truth for key spellings.
  - **Nullability From the Real Contract (`num? fixedBalance`):** A `fixed_balance: null` (calculated-balance types) crashed deserialization (`Null is not a subtype of num`) and produced a misleading success+error snackbar sequence. Fix: type the field `num?` across model, `fromJson`, and request DTO. Lesson: a model must mirror exactly what *this* endpoint returns, not what a sibling endpoint does.
  - **Validator Extraction to Core (Rule of Three):** Promoting duplicated numeric validators to `AppValidators.validateRequiredInt` / `validateOptionalInt` in `core/utils/`. Working ruling: **core = feature-agnostic primitives shared by ≥2 features**.
  - **Immutable Save Gate (`_onSave` discipline):** validate form → copy trimmed values into locals → branch create/`fromChanges` → `int.tryParse` for optionals, `'' → null` for nullable fields, hidden fields echo existing values instead of parsing. No navigation or snackbars inside the cubit — the UI reacts to one-shot states.
  - **Integer-Only Input Policy:** All 6 day/number fields use `FilteringTextInputFormatter.digitsOnly` + shared int validators, eliminating parse crashes at the input boundary rather than in the cubit.

### 18. Admin Leave Configuration - Eligibility Rules (`admin_leave_configuration`)

- **Details:** Implemented eligibility rules (who may apply for each leave type): flat-rule storage with **grouped-by-leave-type** display (`EligibilityGroupCard` + private `_RuleRow`), create via context-aware bottom sheet (per-group `+` pre-fills `leave_type_id`, FAB opens blank), delete with confirmation dialog and inline row spinner, pull-to-refresh, and an AppBar entry from the Leave Types screen. Add + delete only — the backend exposes no PUT. Full-loop smoke test passed.
- **Concepts Learned:**
  - **Derived View Grouping (Store Truth, Derive Shape):** State holds a flat `List<EligibilityRule>`; the `Map<leaveTypeId, List<...>>` is computed per rebuild with `putIfAbsent`. Mutations (`removeWhere`, list replace) stay grouping-agnostic — deleting a group's last rule makes the card vanish with zero special-case code. A stored nested map would need sync logic in every mutation path.
  - **One-Shot Event Flags + Rising-Edge `listenWhen`:** `createSuccess` / `*Failure` fields are reset to null at every action start; the listener gates on `(!prev.createSuccess && curr.createSuccess) || prev.failure != curr.failure`, so each event is consumed exactly once regardless of how many emissions follow (the `createSuccess: true` flag would otherwise re-trigger `pop()` on every refresh emission).
  - **Partial Embed Model (`EligibilityLeaveTypeRef`):** The GET embeds only `{type_name, category}` per rule — modeled as a dedicated lightweight class, deliberately not the 18-field `LeaveType` (model-mirrors-endpoint rule from entry 17).
  - **Context-Aware Sheet Prefill:** Immutable constructor config (`preselectedLeaveTypeId`) → seeded once into mutable State in `initState` → displayed only after an `items.any(...)` guard proves it exists in the dropdown (else `initialValue: null`), dodging Flutter's `initialValue ∈ items` assert while the leave-type list is still fetching. The `validate()` gate makes the subsequent `!` null-assertion unreachable when the field shows null.
  - **Modal Context Isolation via Capture-then-Reinject:** `AppDialogs.showCreateEligibilitySheet` reads both cubits from the *page* context before `showModalBottomSheet`, then re-injects them into the modal sub-tree with `BlocProvider.value` (Advanced Standard #8 in practice).
  - **Route-Level `MultiBlocProvider` for Sheet Data:** The eligibility route provides `LeaveTypeCubit..getLeaveTypes()` (picker options) alongside `EligibilityCubit..getEligibilityRules()` — fresh factory instances per route, mirroring the `CollegesCubit`-beside-form pattern from entry 16.
  - **Shared Enum Single-Home Extraction:** `InitialLoadingStatus` moved out of `leave_type_state.dart` (a `part` file) into `logic/initial_loading_status.dart` — one home, imported by both cubits and the screen (imports are non-transitive, so the screen needed its own import), avoiding both a duplicated enum and eligibility→leave_type_cubit coupling.
  - **Create-Refetch vs Delete-Local Removal:** Create triggers `refresh()` (list-preserving, no shimmer) because only the server knows the new `eligibility_id` and embed; delete removes locally by known id. `_fetch()` refuses while `deletingId != null` so a concurrent refetch can't resurrect a dying row.

# Developer Growth & Learning Journal

For personal engineering growth notes, architectural review items, and stumbling blocks to review before starting new features, refer to [`docs/learning_journal.md`](file:///D:/programming/Flutter/Projects/3-%20new%20era/leave_management_system/docs/learning_journal.md).

# Next Steps & Immediate Roadmap

### ✅ Phase 3 Complete: Leave Policy & Approval Workflow Configuration (`admin_leave_config`)
- **Leave Types (Full CRUD):** Smoke-tested — 7-section form covering balance policies, limits, documents, approval workflow steps, and requirements.
- **Eligibility Rules:** Smoke-tested — grouped-by-leave-type list, context-aware create sheet, confirmed delete.
- **Open conventions:** formalize "core = feature-agnostic primitives shared by ≥2 features" as an official rule; unify legacy `AdminUserWebServices`-style names at end of project.

### Current Focus: Admin Portal - Phase 4: Global Requests Ledger & Administrative Override (`admin_leave_requests`)
- **Contract:** [`docs/admin_reports_and_override_api_documentation.md`](docs/admin_reports_and_override_api_documentation.md)
- **Global Requests Ledger:** University-wide paginated audit log via `GET /api/admin/leave-requests` with multi-field filters (status, department, leave type, user, date range) and backend pagination (`limit`/`offset` → `total`).
- **Administrative Status Override:** `PUT /api/admin/leave-requests/:id/override-status` forcing `Approved`/`Rejected`/`Cancelled` with mandatory justification (≥5 chars); backend auto-adjusts `used_days` balances, invalidates pending approval steps ("Overridden by Admin"), and dispatches the employee notification.





