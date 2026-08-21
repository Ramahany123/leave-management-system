# 🎓 University Leave Management System (Mobile Client)

[![Flutter Version](https://img.shields.io/badge/Flutter-3.41.2-02569B?logo=flutter)](https://flutter.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Feature--First%20%2B%20BLoC-blueviolet)](#-architecture--design-patterns)
[![Theme](https://img.shields.io/badge/Theme-Light%20%7C%20Dark-orange)](#-theming--global-dark-mode)
[![Localization](https://img.shields.io/badge/Language-English%20%7C%20العربية-success)](#-internationalization--rtl)

An enterprise-grade, cross-platform mobile application designed to digitize, automate, and govern the full lifecycle of university staff and faculty leave requests. Built in strict compliance with **Egyptian Labor Law**, organizational governance hierarchies, and multi-tier approval workflows.

---

## 🌟 Key Highlights & System Capabilities

### 🔐 1. Multi-Tier Role-Based Access Control (RBAC)

The application dynamically adapts its navigation shell, permissions, and available dashboards based on the authenticated user's role:

- **Staff & Academic Employees:** Dashboard leave balance tracking, smart request submission, electronic signature verification, and request timeline tracking.
- **Department Heads, Deans & Presidents:** Pending approval queues with signature stamping, real-time team coverage calendars to prevent understaffing, and multi-criteria analytical reports.
- **HR Administrators:** Central command portal for organizational structure (Colleges & Departments), user onboarding via 14-digit National ID (SSN), leave policy workflow configuration, and global status overrides.

---

### 📋 2. Smart Form Engine & Labor Law Validations

The leave submission engine performs automated client-side and server-side rule verification:

- **Egyptian Labor Law Compliance:** Dynamic tenure-based and age-based balance calculations with automated fiscal year boundary (June 30 / July 1) crossover prevention.
- **Progressive Form Disclosure:** Dynamic rendering of delegate selection dropdowns and required document upload cards based on the selected leave type's policies.
- **Electronic Signature Enforcement:** Pre-submission verification ensuring users upload their digital signature before entering approval workflows.
- **Attachment Pipeline:** Direct multi-file document uploads handled via Cloudinary and multipart form data.

---

### 🏛️ 3. Full Organizational Structure & Governance

- **Colleges & Departments:** Hierarchical management with Dean and Department Head appointment workflows.
- **Safety Deletion Guards:** Backend-aligned safety checks preventing deletion of colleges containing active departments or departments containing active personnel.
- **Dynamic Approval Sequences:** Visual multi-step approval workflow builder supporting Department Heads, Deans, University Presidents, and Academic Councils.

---

## 🎨 Theming & Global Dark Mode

The application features a modular, custom **Material 3 Design System** supporting seamless runtime switching between **Light** and **Dark** modes:

- **Centralized Token Architecture:** Semantic color palette tokens defined in `app_colors.dart` and typography scales in `app_typography.dart`.
- **Global Reactive Theme State:** Root-level `ThemeCubit` provided above `MaterialApp` to manage dynamic brightness transitions.
- **Persistent Preferences:** User theme selection is automatically saved to disk via `CacheHelper` (`shared_preferences`) and restored at startup.
- **Theme-Aware Skeletons & Shimmers:** All loading states (`Shimmer.fromColors`) derive background and highlight fills dynamically from `context.colorScheme.outline` and `context.colorScheme.surface`, ensuring visual contrast and zero UI jank across both modes.

---

## 🏗️ Architecture & Engineering Standards

The project strictly follows **Feature-First Domain-Driven Architecture**, enforcing clean layering and single-responsibility boundaries:

```
lib/
├── core/                        # Shared application spine
│   ├── cache/                   # SecureStorageHelper (JWT) & CacheHelper (Prefs)
│   ├── constants/               # App constants, enums, asset paths
│   ├── language/                # Generated translation keys (EasyLocalization)
│   ├── models/                  # Core shared domain models
│   ├── networking/              # DioFactory, ApiService, ApiErrorHandler, Failures
│   ├── routes/                  # GoRouter configuration & RBAC redirect guards
│   ├── theme/                   # Material 3 ColorScheme, Typography & ThemeCubit
│   ├── utils/                   # Service Locator (GetIt), Result<T>, Extensions
│   └── widgets/                 # Atomic design components (Buttons, Fields, Badges)
│
└── features/                    # Isolated feature modules
    ├── auth/                    # Login, Onboarding, Change Password
    ├── employee_dashboard/      # Balances, Recent requests, Quick actions
    ├── leave_request/           # Smart submission form & dynamic validators
    ├── leave_history/           # Paginated requests history & detail sheets
    ├── manager_dashboard/       # Approval queue & action modals
    ├── manager_coverage/        # Department absent staff calendar & search
    ├── manager_reports/         # Analytical reports, date queries & metrics
    ├── admin_org_structure/     # Colleges & Departments management
    ├── admin_users/             # Staff onboarding & role management
    ├── admin_leave_config/      # Leave types, workflows & category eligibility
    ├── admin_leave_requests/    # Global ledger & administrative override
    └── profile/                 # Personal info, contact updates, signature upload
```

Each feature module contains three strict internal layers:

- **`data/`:** Data contracts, models (`fromJson`/`toJson`), web services, and repositories wrapping responses in `Result<T>` (`SuccessResult` vs `FailureResult`).
- **`logic/`:** Business logic managed via **BLoC / Cubit** using **Dart 3 Sealed Classes** (`Initial`, `Loading`, `Success`, `Error`).
- **`ui/`:** Purely declarative, reactive widgets composed of atomic screens, shimmers, and bottom sheets.

---

## 🛠️ Tech Stack & Libraries

| Category                 | Technology / Package                                                        | Purpose                                                                    |
| :----------------------- | :-------------------------------------------------------------------------- | :------------------------------------------------------------------------- |
| **Framework**            | **Flutter 3.41.2** / Dart 3.x                                               | Cross-platform UI development                                              |
| **Version Manager**      | [FVM](https://fvm.app/)                                                     | Flutter Version Management for deterministic builds                        |
| **State Management**     | [`flutter_bloc`](https://pub.dev/packages/flutter_bloc)                     | Predictable, testable reactive state management                            |
| **Routing**              | [`go_router`](https://pub.dev/packages/go_router)                           | Declarative routing with RBAC redirect guards & persistent stateful shells |
| **Dependency Injection** | [`get_it`](https://pub.dev/packages/get_it)                                 | Service Locator for decoupled dependency lifecycle                         |
| **Networking**           | [`dio`](https://pub.dev/packages/dio)                                       | HTTP client with Bearer auth interceptors & error handler                  |
| **Theming & System**     | Material 3 & Custom `ThemeCubit`                                            | Full Light & Dark mode support with persistent state                       |
| **Secure Storage**       | [`flutter_secure_storage`](https://pub.dev/packages/flutter_secure_storage) | Keychain/Keystore encrypted storage for JWT tokens                         |
| **Local Cache**          | [`shared_preferences`](https://pub.dev/packages/shared_preferences)         | Fast persistent caching for theme and locale settings                      |
| **Localization**         | [`easy_localization`](https://pub.dev/packages/easy_localization)           | Bilingual English / Arabic with code-generated keys                        |
| **Responsive Design**    | [`flutter_screenutil`](https://pub.dev/packages/flutter_screenutil)         | Multi-device density-independent scaling                                   |
| **Loading UX**           | [`shimmer`](https://pub.dev/packages/shimmer)                               | Skeleton loading states mirroring real UI shapes                           |

---

## 🌐 Internationalization & RTL Support

The application is built ground-up for complete bilingual operation (**Arabic** and **English**):

- Zero hardcoded strings: all UI text is accessed via strongly-typed `LocaleKeys.key_name.tr()`.
- Bidirectional layout mirroring using directional positioning (`EdgeInsetsDirectional`, `AlignmentDirectional`).
- Real-time locale switching preserving state and view hierarchies.

To regenerate translation keys:

```bash
fvm dart run easy_localization:generate -S assets/translations -f keys -O lib/core/language -o locale_keys.g.dart
```

---

## 🚀 Getting Started & Setup

### Prerequisites

- Install [FVM (Flutter Version Management)](https://fvm.app/docs/getting_started/installation)
- Flutter SDK `3.41.2` (managed automatically via `.fvmrc`)

### Installation Steps

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Ramahany123/leave-management-system.git
   cd leave-management-system
   ```

2. **Install Flutter SDK via FVM:**

   ```bash
   fvm install
   fvm flutter pub get
   ```

3. **Generate Localization Keys:**

   ```bash
   fvm dart run easy_localization:generate -S assets/translations -f keys -O lib/core/language -o locale_keys.g.dart
   ```

4. **Run the Application:**
   ```bash
   fvm flutter run
   ```

---

## 👨‍💻 Author & Contact

**Rama Hany**

- GitHub: [@Ramahany123](https://github.com/Ramahany123)
- LinkedIn: [Rama Hany](https://www.linkedin.com/in/rama-hany-abd-elsalam-07876b20a/)
- Email: `hanyrama703@gmail.com`
