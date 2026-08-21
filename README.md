# 🎓 University Leave Management System (Mobile Client)

[![Flutter Version](https://img.shields.io/badge/Flutter-3.41.2-02569B?logo=flutter)](https://flutter.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Feature--First%20%2B%20BLoC-blueviolet)](#-architecture--engineering-standards)
[![Theme](https://img.shields.io/badge/Theme-Light%20%7C%20Dark-orange)](#-core-system-capabilities--integration-pillars)
[![Localization](https://img.shields.io/badge/Language-English%20%7C%20العربية-success)](#-internationalization--rtl-support)

An enterprise-grade, cross-platform mobile application designed to digitize, automate, and govern the full lifecycle of university staff and faculty leave requests. Built in strict compliance with **Egyptian Labor Law**, organizational governance hierarchies, and multi-tier approval workflows.

---

## 🌟 Core System Capabilities & Integration Pillars

### 🔄 1. Complete End-to-End Enterprise Integration

- **Full-Stack REST Architecture:** Flutter client integrated with a Node.js/Express backend (Sequelize ORM & MySQL) and Cloudinary media cloud.
- **Automated Security & Session Pipeline:** Secure JWT token lifecycle with automatic Bearer injection interceptors, dynamic disk-to-RAM auth synchronization, and token-guarded API endpoints.

---

### 👥 2. Strict Role-Based Access Control (RBAC)

- **Role-Tailored Dashboards:** Seamless routing and persistent navigation shells customized for **Employees**, **Department Heads**, **Deans**, **University Presidents**, and **HR Administrators**.
- **Two-Zone Router Protection:** Centralized `GoRouter` redirect guards enforcing authentication state and preventing unauthorized cross-role route access.

---

### ⚖️ 3. Egyptian Labor Law & Smart Rule Engine

- **Tenure & Age-Based Balances:** Automated balance calculations derived from employment category, gender, and years of service with automatic July 1st fiscal year resets.
- **Business Rule Enforcement:** Automated client/server validation for 30-day retroactive limits, fiscal year boundary crossings (June 30 / July 1), minimum gap days, and lifetime limits (e.g. Hajj leave).
- **Early Return Execution ("قطع الإجازة"):** Direct capability for employees to officially cut active leaves short with automatic balance adjustments.

---

### ✍️ 4. Electronic Signatures & Document Verification

- **Signature Gatekeeping:** Pre-submission enforcement requiring users to upload an electronic signature before submitting requests.
- **Multi-File Cloudinary Pipeline:** Multipart document uploads for medical and official attachments with progressive disclosure based on leave policies.

---

### 📊 5. Department Coverage & Operational Intelligence

- **Understaffing Prevention:** Real-time departmental absence calendar enabling managers to check staff availability before approving leaves.
- **Analytical Reporting:** Multi-criteria date range querying, status breakdowns, and $0\text{ms}$ latency in-memory search across university personnel.

---

### 🏛️ 6. HR Administrative Governance & Policy Engine

- **Organizational Hierarchy:** Complete CRUD management for Colleges and Departments with Dean/Head leadership assignment and deletion safety blocks.
- **National ID (SSN) Onboarding:** Seamless staff onboarding where initial accounts are securely seeded with 14-digit National IDs requiring mandatory first-time activation.
- **Dynamic Workflow Engine:** Visual configuration of custom approval sequences (Head $\rightarrow$ Dean $\rightarrow$ President $\rightarrow$ Councils) and category eligibility rules (`Academic`, `Administrative`, `Service`, `All`).
- **Administrative Status Override:** HR emergency override capability (`Approved`/`Rejected`/`Cancelled`) with automatic balance adjustments and instant employee notifications.

---

### 🎨 7. Production-Grade UX, Theming & Localization

- **Material 3 Design System:** Full **Light & Dark mode** support with custom token architecture and persistent runtime state.
- **Complete Bilingual Support:** English & Arabic with code-generated translation keys (`easy_localization`) and bidirectional layout mirroring (RTL/LTR).
- **Theme-Aware Skeleton Shimmers:** Loading UX that mirrors exact layout geometries across both light and dark themes.

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
