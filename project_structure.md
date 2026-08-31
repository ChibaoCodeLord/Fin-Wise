# Cấu trúc Dự án FinWise (Modular Architecture)

Dự án được tổ chức theo kiến trúc **Modular Feature-based Architecture** (chia theo từng module tính năng độc lập, trong mỗi module có `state/bloc`, `presentations/`, `widgets/`, `models/` và `services/`).

```text
lib/
├── core/                                    # Tầng Core dùng chung toàn app
│   ├── constants/
│   │   └── app_constants.dart
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_styles.dart
│   │   └── app_theme.dart
│   ├── utils/
│   │   ├── currency_formatter.dart
│   │   └── date_formatter.dart
│   └── widgets/                            # Widget hệ thống dùng chung
│       ├── buttons/
│       │   └── neo_pill_button.dart
│       ├── chips/
│       │   ├── neo_icon_chip.dart
│       │   └── neo_filter_chip.dart
│       └── modals/
│           ├── neo_bottom_sheet.dart
│           └── neo_success_modal.dart
│
├── modules/                                # Toàn bộ Feature Modules
│   ├── app/                                # Module App & Bottom Navigation
│   │   ├── state/
│   │   │   └── app_state_manager.dart
│   │   └── presentations/
│   │       └── main_navigation_screen.dart
│   │
│   ├── home/                               # Module Trang chủ (Dashboard)
│   │   └── presentations/
│   │       ├── widgets/
│   │       │   ├── cards/
│   │       │   │   ├── neo_hero_card.dart
│   │       │   │   └── neo_insight_card.dart
│   │       │   └── tiles/
│   │       │       └── neo_transaction_tile.dart
│   │       └── home_dashboard_screen.dart
│   │
│   ├── receipt_scanner/                    # Module Quét hoá đơn OCR
│   │   ├── models/
│   │   │   └── receipt_model.dart
│   │   └── presentations/
│   │       ├── receipt_scanner_screen.dart
│   │       └── receipt_review_screen.dart
│   │
│   ├── expense/                            # Module Quản lý Chi tiêu & Giao dịch
│   │   ├── models/
│   │   │   ├── category_model.dart
│   │   │   └── expense_model.dart
│   │   └── presentations/
│   │       ├── widgets/
│   │       │   ├── modals/
│   │       │   │   └── expense_detail_sheet.dart
│   │       │   └── tiles/
│   │       │       └── neo_radio_tile.dart
│   │       ├── expense_list_screen.dart
│   │       └── add_expense_screen.dart
│   │
│   ├── budget/                             # Module Hũ chi tiêu (Budget Jars)
│   │   ├── models/
│   │   │   └── spending_jar_model.dart
│   │   └── presentations/
│   │       ├── widgets/
│   │       │   ├── cards/
│   │       │   │   └── neo_jar_progress_card.dart
│   │       │   └── modals/
│   │       │       └── add_edit_jar_sheet.dart
│   │       └── spending_jars_screen.dart
│   │
│   ├── analysis/                           # Module Phân tích Chi tiêu & Biểu đồ
│   │   ├── models/
│   │   │   └── insight_model.dart
│   │   └── presentations/
│   │       └── spending_analysis_screen.dart
│   │
│   ├── shopping/                           # Module Lịch sử Mua sắm theo Sản phẩm OCR
│   │   ├── models/
│   │   │   └── shopping_item_model.dart
│   │   └── presentations/
│   │       └── shopping_history_screen.dart
│   │
│   └── profile/                            # Module Hồ sơ, Cài đặt & Thông báo
│       └── presentations/
│           ├── profile_screen.dart
│           └── notifications_screen.dart
│
└── main.dart                               # Entry point ứng dụng
```
