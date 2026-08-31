# FinWise – Plan chức năng cho app quản lý chi tiêu & scan hóa đơn

## 1. Định hướng sản phẩm

FinWise tập trung vào **quản lý chi tiêu cá nhân**, đặc biệt là các khoản chi từ mua sắm hằng ngày.

Trọng tâm của ứng dụng:

- Ghi nhận chi tiêu nhanh.
- Scan hóa đơn bằng camera.
- OCR tự động lấy thông tin hóa đơn.
- Tự động tổng hợp chi tiêu.
- Phân loại khoản chi.
- Quản lý chi tiêu theo **hũ / ngân sách**.
- Theo dõi lịch sử mua sắm.
- Phân tích thói quen chi tiêu.
- Cảnh báo khi sắp vượt ngân sách.
- Hỗ trợ người dùng kiểm soát việc mua sắm tốt hơn.

> App không cần tập trung mạnh vào quản lý thu nhập, đầu tư, ngân hàng hay tiết kiệm như một ứng dụng tài chính tổng hợp.

---

## 2. Cấu trúc chức năng chính

Ứng dụng có thể chia thành các module chính:

1. Authentication.
2. Home Dashboard.
3. Scan hóa đơn.
4. Quản lý chi tiêu.
5. Hũ chi tiêu / Budget.
6. Danh mục chi tiêu.
7. Mua sắm.
8. Phân tích chi tiêu.
9. Tìm kiếm & lịch sử.
10. Thông báo.
11. Profile.
12. Settings & Security.

---

## 3. Launch / Splash Screen

Khi mở ứng dụng:

```text
Launch App
   ↓
Splash Screen
   ↓
Kiểm tra trạng thái đăng nhập
   ↓
Chưa đăng nhập → Login / Sign Up
Đã đăng nhập   → Home
```

Chức năng:

- Hiển thị logo.
- Kiểm tra session.
- Kiểm tra PIN / biometric nếu người dùng bật bảo mật.
- Điều hướng đến Home hoặc Login.

---

## 4. Authentication

### 4.1 Đăng ký

Thông tin:

- Họ tên.
- Email.
- Số điện thoại.
- Password.
- Confirm Password.

Có thể bổ sung:

- OTP email.
- Email verification.

### 4.2 Đăng nhập

Hỗ trợ:

- Email.
- Password.
- Show / Hide password.
- Remember Login.
- Forgot Password.
- Login bằng fingerprint / Face ID nếu đã bật.

### 4.3 Quên mật khẩu

```text
Forgot Password
      ↓
Nhập Email
      ↓
Nhận OTP
      ↓
Xác nhận OTP
      ↓
Nhập Password mới
      ↓
Hoàn tất
```

---

## 5. Home Dashboard

Home chỉ nên tập trung vào **tình hình chi tiêu**.

Hiển thị:

- Tổng chi hôm nay.
- Tổng chi tuần này.
- Tổng chi tháng này.
- Ngân sách còn lại.
- % ngân sách đã sử dụng.
- Hũ chi tiêu sắp hết.
- Giao dịch gần đây.
- Nút Scan hóa đơn nhanh.
- Nút thêm chi tiêu thủ công.
- Cảnh báo chi tiêu.

Ví dụ:

```text
Chi tiêu tháng này: 3.250.000đ
Ngân sách:           5.000.000đ
Đã sử dụng:          65%
Còn lại:             1.750.000đ
```

---

## 6. Quick Actions trên Home

Các thao tác nhanh:

- Scan hóa đơn.
- Thêm chi tiêu.
- Xem lịch sử.
- Xem hũ chi tiêu.
- Xem báo cáo.

---

## 7. Scan hóa đơn – Chức năng trọng tâm

Đây là chức năng quan trọng nhất của app.

```text
Camera / Upload ảnh
        ↓
Tiền xử lý ảnh
        ↓
OCR hóa đơn
        ↓
Nhận diện thông tin
        ↓
AI phân loại
        ↓
User kiểm tra
        ↓
Confirm
        ↓
Tạo Expense
        ↓
Cập nhật Dashboard / Budget
```

---

## 8. Chụp / Upload hóa đơn

Người dùng có thể:

- Chụp hóa đơn bằng camera.
- Chọn ảnh từ thư viện.
- Chụp lại.
- Crop hóa đơn.
- Rotate ảnh.
- Làm rõ ảnh.
- Xác nhận ảnh trước khi OCR.
- Hỗ trợ hóa đơn dài hoặc nhiều ảnh cho một hóa đơn.

---

## 9. OCR hóa đơn

Sau khi scan, hệ thống tự động lấy:

- Tên cửa hàng.
- Ngày mua.
- Giờ mua.
- Tổng tiền.
- Thuế.
- Giảm giá.
- Phương thức thanh toán.
- Danh sách sản phẩm.
- Số lượng.
- Giá từng sản phẩm.
- Tổng từng dòng sản phẩm.

Ví dụ:

```text
Cửa hàng: WinMart
Ngày: 31/08/2026

Sản phẩm:
- Sữa tươi          32.000đ
- Bánh mì           18.000đ
- Nước ngọt         15.000đ

Tổng: 65.000đ
```

---

## 10. Review kết quả Scan

Sau OCR không nên lưu ngay. Người dùng cần có màn hình kiểm tra.

Có thể chỉnh:

- Tên cửa hàng.
- Ngày.
- Tổng tiền.
- Danh mục.
- Sản phẩm.
- Giá sản phẩm.
- Số lượng.
- Note.

Nút:

- Save.
- Scan lại.
- Edit.
- Cancel.

---

## 11. AI phân loại hóa đơn

Sau khi OCR, hệ thống gợi ý category.

Ví dụ:

```text
Highlands Coffee → Food & Drink
Guardian         → Health / Personal Care
Uniqlo           → Clothing
Grab             → Transport
```

Người dùng có thể:

- Chấp nhận category.
- Đổi category.
- Tạo category mới.

---

## 12. Phân loại từng sản phẩm trong hóa đơn

Nếu muốn app nổi bật hơn, không chỉ phân loại cả hóa đơn mà có thể phân loại từng item.

Ví dụ:

```text
WinMart

Coca Cola → Food & Drink
Dầu gội   → Personal Care
Pin AA    → Household
```

Nhờ vậy báo cáo chi tiêu sẽ chính xác hơn.

---

## 13. Phát hiện hóa đơn trùng

Khi người dùng scan cùng một hóa đơn nhiều lần, hệ thống kiểm tra:

- Merchant.
- Date.
- Total amount.
- Receipt content.

Nếu giống nhau:

```text
Hóa đơn này có thể đã được thêm trước đó.
```

Cho phép:

- Xem hóa đơn cũ.
- Vẫn thêm.
- Hủy.

---

## 14. Lưu ảnh hóa đơn

Mỗi expense scan từ hóa đơn nên lưu:

- Ảnh hóa đơn gốc.
- Kết quả OCR.
- Expense tương ứng.

Người dùng có thể:

- Mở lại hóa đơn.
- Zoom.
- Xem sản phẩm.
- Edit dữ liệu OCR.

---

## 15. Thêm chi tiêu thủ công

Không phải lúc nào cũng có hóa đơn.

Cho phép nhập:

- Số tiền.
- Danh mục.
- Tên khoản chi.
- Cửa hàng.
- Ngày.
- Giờ.
- Phương thức thanh toán.
- Note.
- Ảnh đính kèm.

---

## 16. Expense Detail

Khi mở một khoản chi, hiển thị:

- Số tiền.
- Category.
- Merchant.
- Date.
- Time.
- Payment method.
- Note.
- Receipt.
- Danh sách item nếu có.

Actions:

- Edit.
- Delete.
- Duplicate.
- Move to another category.
- Move to another spending jar.

---

## 17. Expense CRUD

### Create
- Scan hóa đơn.
- Nhập thủ công.

### Read
- Xem chi tiết.

### Update
- Chỉnh amount.
- Chỉnh category.
- Chỉnh merchant.
- Chỉnh note.
- Chỉnh hũ chi tiêu.

### Delete
- Xóa expense.
- Hoàn lại số tiền vào budget tương ứng.

---

## 18. Hũ chi tiêu

Đây nên là một module cốt lõi của app.

Người dùng chia ngân sách thành nhiều **hũ chi tiêu**.

| Hũ | Ngân sách |
|---|---:|
| Ăn uống | 2.000.000đ |
| Mua sắm | 1.500.000đ |
| Đi lại | 800.000đ |
| Giải trí | 500.000đ |
| Cá nhân | 700.000đ |

---

## 19. Tạo hũ chi tiêu

Người dùng nhập:

- Tên hũ.
- Ngân sách.
- Thời gian áp dụng.
- Category liên quan.
- Ngày bắt đầu.
- Ngày kết thúc.

Ví dụ:

```text
Tên hũ: Ăn uống
Ngân sách: 2.000.000đ
Chu kỳ: Monthly
```

---

## 20. Theo dõi hũ chi tiêu

Mỗi hũ hiển thị:

- Tổng ngân sách.
- Đã chi.
- Còn lại.
- % đã sử dụng.
- Số transaction.
- Thời gian còn lại.

---

## 21. Gắn Expense vào hũ

Khi thêm expense, app tự động gợi ý hũ.

```text
Expense: Highlands - 65.000đ
Category: Food
Suggested Jar: Ăn uống
```

Người dùng có thể đổi hũ.

---

## 22. Cảnh báo hũ chi tiêu

Các mức:

```text
50%  → Thông báo nhẹ
80%  → Cảnh báo sắp hết
100% → Đã hết ngân sách
>100% → Vượt ngân sách
```

Ví dụ:

```text
Bạn đã sử dụng 82% ngân sách Ăn uống tháng này.
```

---

## 23. Reset hũ theo chu kỳ

Hỗ trợ:

- Weekly.
- Monthly.
- Custom period.

Lịch sử kỳ cũ vẫn được lưu để phân tích.

---

## 24. Category – Danh mục chi tiêu

Danh mục mặc định:

- Food & Drink.
- Groceries.
- Shopping.
- Transport.
- Rent.
- Bills.
- Health.
- Personal Care.
- Entertainment.
- Education.
- Travel.
- Gifts.
- Household.
- Other.

---

## 25. Custom Category

Người dùng có thể:

- Tạo category.
- Đổi tên.
- Chọn icon.
- Edit.
- Delete.

Nếu category đã có expense, cần chuyển expense sang category khác trước khi xóa.

---

## 26. Mua sắm – Shopping Management

Vì app thiên về chi tiêu và mua sắm, nên có riêng module Shopping.

Chức năng:

- Lưu lịch sử mua sắm.
- Xem các cửa hàng đã mua.
- Theo dõi số tiền mua sắm.
- Xem sản phẩm đã mua.
- Xem hóa đơn liên quan.

---

## 27. Shopping History

Có thể xem theo merchant:

```text
August 2026

Uniqlo     850.000đ
WinMart    620.000đ
Shopee   1.150.000đ
Highlands  430.000đ
```

Filter theo:

- Ngày.
- Merchant.
- Category.
- Amount.

---

## 28. Purchase Item History

Nếu hóa đơn OCR được item, người dùng có thể tìm lại sản phẩm.

Ví dụ search:

```text
Dầu gội
```

App hiển thị:

- Mua ở đâu.
- Ngày mua.
- Giá.
- Hóa đơn.

---

## 29. Shopping List

Có thể bổ sung danh sách cần mua.

Người dùng tạo:

- Tên sản phẩm.
- Số lượng.
- Giá dự kiến.
- Category.

Sau khi mua:

- Mark as purchased.
- Link với expense / receipt.

---

## 30. Planned Purchase

Cho phép lưu khoản mua dự kiến:

- Tên món đồ.
- Giá dự kiến.
- Ngày muốn mua.
- Category.
- Hũ chi tiêu.

App có thể kiểm tra:

```text
Nếu mua sản phẩm này → Hũ Shopping còn bao nhiêu?
```

---

## 31. Transaction History

Danh sách toàn bộ khoản chi.

Có thể group theo:

- Today.
- Yesterday.
- Week.
- Month.

Mỗi transaction hiển thị:

- Tên.
- Merchant.
- Category.
- Amount.
- Date.
- Receipt indicator.

---

## 32. Search Expense

Search theo:

- Tên khoản chi.
- Merchant.
- Item.
- Category.
- Amount.

Ví dụ:

```text
Search: Highlands
```

→ trả về tất cả các lần mua tại Highlands.

---

## 33. Filter Expense

Filter theo:

- Today.
- This week.
- This month.
- Custom date.
- Category.
- Merchant.
- Hũ.
- Payment method.
- Expense amount.

---

## 34. Calendar

Calendar hiển thị:

- Ngày có expense.
- Tổng tiền từng ngày.
- Ngày chi tiêu cao.

Khi chọn ngày:

```text
31/08/2026

Highlands     65.000đ
Grab          42.000đ
WinMart      350.000đ

Total        457.000đ
```

---

## 35. Analysis – Phân tích chi tiêu

Các chế độ:

- Daily.
- Weekly.
- Monthly.
- Yearly.
- Custom date range.

---

## 36. Daily Analysis

Hiển thị:

- Tổng chi hôm nay.
- Số transaction.
- Category chi nhiều nhất.
- Merchant chi nhiều nhất.
- Average transaction.
- So sánh Today vs Yesterday.

---

## 37. Weekly Analysis

Hiển thị:

- Tổng chi tuần.
- Chi trung bình/ngày.
- Ngày chi nhiều nhất.
- Category chi nhiều nhất.
- Hũ sử dụng nhiều nhất.
- So sánh This Week vs Last Week.

---

## 38. Monthly Analysis

Hiển thị:

- Tổng chi.
- Budget.
- Remaining budget.
- Average/day.
- Top categories.
- Top merchants.
- Top purchases.
- So sánh This Month vs Last Month.

---

## 39. Yearly Analysis

Hiển thị:

- Expense từng tháng.
- Tổng expense năm.
- Average monthly expense.
- Tháng chi cao nhất.
- Category lớn nhất.

---

## 40. Biểu đồ

Có thể dùng:

- Bar Chart: chi tiêu theo ngày / tuần / tháng.
- Pie / Donut: chi tiêu theo category.
- Line Chart: xu hướng chi tiêu.
- Progress: mức sử dụng từng hũ.

---

## 41. Merchant Analysis

Phân tích theo cửa hàng:

```text
Shopee     3.250.000đ
WinMart    2.100.000đ
Highlands    950.000đ
```

Cho phép người dùng biết mình thường chi tiền ở đâu.

---

## 42. Item Analysis

Nếu OCR có item-level data:

```text
Coffee       8 lần   520.000đ
Fast Food    6 lần   670.000đ
Cosmetics    4 lần 1.200.000đ
```

Đây là điểm khác biệt mạnh so với expense tracker cơ bản.

---

## 43. Smart Spending Insights

Hệ thống tự tạo nhận xét.

Ví dụ:

```text
Chi tiêu ăn uống tháng này tăng 22% so với tháng trước.
```

```text
Bạn đã mua sắm online 8 lần trong tuần này.
```

```text
Hũ Shopping có nguy cơ vượt ngân sách trước cuối tháng.
```

---

## 44. Spending Forecast

Dựa vào lịch sử chi tiêu:

```text
Đã chi:              3.200.000đ
Ngày hiện tại:       20/30
Dự đoán cuối tháng: 4.800.000đ
Budget:              4.500.000đ
```

App cảnh báo:

```text
Bạn có khả năng vượt ngân sách khoảng 300.000đ.
```

---

## 45. Expense Anomaly Detection

Phát hiện khoản chi bất thường.

Ví dụ:

```text
Bạn thường chi khoảng 80.000đ/ngày cho Food.
Hôm nay: 420.000đ
→ Chi tiêu cao bất thường.
```

---

## 46. Notification Center

Các loại thông báo:

- Budget Alert.
- Overspending.
- Expense Reminder.
- Scan Result.
- Smart Insight.
- Monthly Report.

---

## 47. Receipt Notifications

Ví dụ:

```text
Hóa đơn WinMart đã được scan thành công.
```

Hoặc:

```text
Không thể nhận diện tổng tiền. Vui lòng kiểm tra lại.
```

---

## 48. Monthly Spending Report

Cuối tháng app tạo summary:

```text
Tổng chi:       5.250.000đ
Top Category:   Food - 1.450.000đ
Top Merchant:   Shopee - 1.200.000đ
Budget:         6.000.000đ
Remaining:        750.000đ
```

Có thể xem lại report các tháng trước.

---

## 49. Export báo cáo

Hỗ trợ:

- CSV.
- Excel.
- PDF.

Có thể export:

- Expense history.
- Receipt data.
- Category report.
- Monthly report.

---

## 50. Profile

Hiển thị:

- Avatar.
- Full name.
- Email.

Menu:

- Edit Profile.
- Security.
- Settings.
- Notifications.
- Help.
- Logout.

---

## 51. Edit Profile

Cho phép chỉnh:

- Avatar.
- Full name.
- Username.
- Phone.
- Email.

---

## 52. Security

Có:

- Change Password.
- PIN.
- Fingerprint / Face ID.
- Logout all devices.
- Delete account.

---

## 53. Notification Settings

Toggle:

- Budget alerts.
- Overspending alerts.
- Expense reminder.
- Receipt scan notification.
- Weekly report.
- Monthly report.
- Smart insights.
- Sound.
- Vibration.

---

## 54. App Settings

Có:

- Language.
- Currency.
- Date format.
- Theme.
- Default budget period.
- Default category.
- Camera / scan settings.

---

## 55. Data Backup & Sync

Nếu dùng cloud:

- Sync expense.
- Sync receipt.
- Sync categories.
- Sync jars.
- Sync user settings.
- Đổi điện thoại vẫn giữ dữ liệu.

---

## 56. Offline Mode

Khi không có mạng:

- Nhập expense.
- Xem lịch sử cache.
- Chụp receipt.

Khi có mạng:

```text
Local Data → Sync → Cloud
```

OCR có thể được xử lý sau khi thiết bị online nếu backend yêu cầu mạng.

---

## 57. Delete Account

```text
Profile
   ↓
Settings
   ↓
Delete Account
   ↓
Password Confirmation
   ↓
Final Confirmation
   ↓
Delete
```

Cảnh báo:

- Expense bị xóa.
- Receipt bị xóa.
- Hũ chi tiêu bị xóa.
- Category tùy chỉnh bị xóa.
- Dữ liệu report bị xóa.

---

## 58. Help Center

FAQ tập trung vào:

- Cách scan hóa đơn.
- OCR sai thì sửa thế nào.
- Cách tạo hũ chi tiêu.
- Cách sửa expense.
- Cách xóa hóa đơn.
- Cách xem báo cáo.
- Cách reset password.
- Data privacy.

---

## 59. Bottom Navigation đề xuất

App nên có 5 tab chính:

```text
Home
Analysis
Scan
Expenses
Profile
```

Trong đó **Scan** nằm ở giữa vì đây là chức năng trọng tâm.

Một phương án khác:

```text
Home
History
Scan
Budget
Profile
```

---

## 60. Functional Flow tổng thể

```text
START APP
    │
    ▼
Splash
    │
    ├── Chưa login → Login / Sign Up
    │
    └── Đã login → Home
                    │
       ┌────────────┼───────────────┬───────────────┐
       ▼            ▼               ▼               ▼
     Scan        Expenses         Budget         Analysis
       │            │               │               │
       │            ├─ History      ├─ Jars          ├─ Daily
       │            ├─ Search       ├─ Progress      ├─ Weekly
       │            ├─ Filter       ├─ Alerts        ├─ Monthly
       │            └─ Detail       └─ Reset         └─ Yearly
       │
       ├─ Camera
       ├─ Upload
       ├─ OCR
       ├─ Detect Merchant
       ├─ Detect Items
       ├─ Detect Total
       ├─ Auto Category
       ├─ Select Jar
       ├─ Review
       └─ Save Expense
```

---

## 61. Luồng Scan hóa đơn hoàn chỉnh

```text
User nhấn Scan
      ↓
Mở Camera
      ↓
Chụp hóa đơn
      ↓
Crop / chỉnh ảnh
      ↓
OCR
      ↓
Extract Data
      │
      ├─ Merchant
      ├─ Date
      ├─ Items
      ├─ Price
      ├─ Discount
      └─ Total
      ↓
AI Category
      ↓
Gợi ý hũ chi tiêu
      ↓
Review
      ↓
User sửa nếu cần
      ↓
Save
      ↓
Expense Database
      ↓
Update Budget
      ↓
Update Analytics
      ↓
Update Dashboard
```

---

## 62. Các module khi code

| Module | Chức năng |
|---|---|
| Auth | Login, Sign Up, Forgot Password |
| Home | Spending dashboard |
| Receipt Scanner | Camera, upload, OCR |
| Receipt Parser | Merchant, items, amount, date |
| Expense | CRUD khoản chi |
| Category | Phân loại expense |
| Spending Jar | Hũ chi tiêu |
| Shopping | Lịch sử mua sắm |
| Search | Tìm expense / merchant / item |
| Analytics | Daily / Weekly / Monthly / Yearly |
| Insights | Phân tích thói quen |
| Notification | Budget & spending alerts |
| Profile | User information |
| Settings | Security & preferences |

---

## 63. Database Entity chính

Nếu thiết kế database, các bảng / entity chính có thể gồm:

```text
users
expenses
receipts
receipt_items
categories
spending_jars
jar_transactions
merchants
shopping_lists
shopping_list_items
notifications
monthly_reports
user_settings
```

Quan hệ chính:

```text
User
 │
 ├── Expenses
 │      ├── Receipt
 │      │      └── Receipt Items
 │      ├── Category
 │      ├── Merchant
 │      └── Spending Jar
 │
 ├── Spending Jars
 ├── Shopping Lists
 ├── Notifications
 └── Reports
```

---

## 64. MVP – Phiên bản nên làm trước

Các chức năng bắt buộc:

- Sign Up.
- Login.
- Forgot Password.
- Home Dashboard.
- Thêm expense thủ công.
- Scan hóa đơn.
- OCR tổng tiền.
- OCR ngày.
- OCR merchant.
- Review kết quả OCR.
- Lưu receipt.
- Expense CRUD.
- Category.
- Hũ chi tiêu.
- Budget progress.
- Expense history.
- Search.
- Filter.
- Daily analysis.
- Monthly analysis.
- Category chart.
- Budget warning.
- Profile.
- Settings.
- Logout.

---

## 65. Phiên bản nâng cao

Sau MVP có thể bổ sung:

- OCR từng item.
- AI auto category.
- Duplicate receipt detection.
- Merchant analysis.
- Item analysis.
- Shopping list.
- Planned purchase.
- Spending forecast.
- Anomaly detection.
- Smart financial insights.
- Monthly auto report.
- Export PDF / Excel.
- Offline sync.
- Biometric login.

---

## 66. Chức năng nên ưu tiên để tạo điểm khác biệt

### 1. Scan hóa đơn

```text
Ảnh → OCR → Extract → Confirm → Expense
```

Đây là tính năng trung tâm.

### 2. Hũ chi tiêu

```text
Budget
   ↓
Expense
   ↓
Remaining
   ↓
Alert
```

Giúp app không chỉ ghi lại lịch sử mà còn hỗ trợ kiểm soát chi tiêu.

### 3. Phân tích hành vi mua sắm

Không chỉ báo:

```text
Bạn đã chi 5 triệu.
```

Mà phân tích:

```text
Bạn chi nhiều nhất vào Food.
Chi tiêu Shopee tăng 30%.
Shopping Jar sắp vượt ngân sách.
```

### 4. OCR từng sản phẩm

Nếu làm được:

```text
Receipt
  ↓
Items
  ↓
Categories
  ↓
Item-level Analytics
```

Đây sẽ là tính năng nổi bật nhất so với expense tracker thông thường.

---

## 67. Phạm vi nên giảm so với plan FinWise cũ

Vì app tập trung vào quản lý chi tiêu, có thể bỏ hoặc giảm ưu tiên:

- Quản lý thu nhập phức tạp.
- Investment.
- Bank account.
- Financial portfolio.
- Saving Goal kiểu đầu tư / mua nhà.
- Income analytics chi tiết.
- Banking sync.
- Chuyển tiền.
- Ví điện tử.
- Quản lý tài sản.

Thay vào đó ưu tiên:

- Receipt scanning.
- Shopping expense.
- Expense categories.
- Spending jars.
- Budget.
- Shopping history.
- Spending analytics.
- Smart alerts.
- OCR / AI.
