# FinWise – Kế hoạch phong cách thiết kế (theo ảnh tham chiếu)

## 1. Nhận diện phong cách tham chiếu

Bộ ảnh tham chiếu thuộc phong cách **"neo-bank cao cấp"** — thường thấy ở các app ngân hàng số hiện đại (Revolut, Wise, N26...). Đặc điểm nhận diện:

- Nền **gradient xanh dương đậm** phủ toàn bộ khu vực hero/số dư, tạo cảm giác an toàn, đáng tin, "premium".
- Các modal/bottom sheet **nền trắng bo góc lớn**, nổi bật trên nền gradient nhờ đổ bóng nhẹ.
- Nút hành động chính là **pill đen/navy gần đen**, full-width, chữ trắng — tương phản mạnh, cảm giác chắc chắn, dứt khoát.
- Icon dạng **chip tròn/vuông bo góc, nền xanh nhạt, icon outline xanh đậm** — nhất quán cho mọi loại icon tiện ích (wifi, điện, nước...).
- Danh sách (bills, cards) dùng **hàng phẳng**: icon chip bên trái, tên + phụ đề, số tiền căn phải — không viền, không đổ bóng riêng từng hàng.
- Trạng thái thành công: **icon dấu tick trắng trong vòng tròn đen**, giữa modal, kèm nút "Go Home".
- Màn chọn thẻ/lựa chọn: **radio-list** với viền đen 2px + dấu tick khi được chọn.
- Chữ số dư, tiêu đề dùng **sans-serif hình học, sạch**, đậm vừa phải — không serif, không chữ viết tay.

Đây là hướng khác hẳn 2 bản trước (ledger giấy / soft pastel): thiên về **sự tin cậy, chuyên nghiệp, tối giản có chủ đích**, phù hợp nếu FinWise muốn định vị gần với hình ảnh "ngân hàng số" hơn là "sổ chi tiêu cá nhân".

---

## 2. Bảng màu (Design tokens)

| Token | Hex | Vai trò |
|---|---|---|
| `--gradient-top` | `#4C7DF5` | Điểm đầu gradient (xanh dương sáng) |
| `--gradient-bottom` | `#10193B` | Điểm cuối gradient (navy gần đen) |
| `--surface-white` | `#FFFFFF` | Nền modal, card, màn phụ |
| `--surface-muted` | `#F3F4F6` | Nền hàng list không active, nền input |
| `--ink-cta` | `#0B0E17` | Nút hành động chính (pill đen) |
| `--icon-tint-bg` | `#EAF2FE` | Nền chip icon (wifi, điện, nước...) |
| `--icon-tint-fg` | `#3B6FE0` | Màu icon trên chip xanh nhạt |
| `--text-primary` | `#0B0E17` | Chữ chính trên nền trắng |
| `--text-on-gradient` | `#FFFFFF` | Chữ trên nền gradient |
| `--text-secondary` | `#6B7280` | Chữ phụ, nhãn, ngày tháng |
| `--border-hairline` | `#E5E7EB` | Viền mảnh, divider |
| `--success-green` | `#1B8A62` | % thay đổi dương, badge tăng trưởng |

Gradient hero dùng hướng `180deg` (trên sáng → dưới đậm), hoặc `135deg` nếu muốn chéo nhẹ như ảnh gốc.

---

## 3. Typography

- **Font chính**: một họ sans hình học, sạch — đề xuất **Inter** hoặc **General Sans** (web-safe, nhiều độ đậm). Không dùng serif ở phong cách này (khác bản "ledger").
- Số dư lớn: 32–36px, weight 700, tabular numbers (để các chữ số thẳng hàng khi thay đổi).
- Tiêu đề màn hình (VD "Choose card"): 22–24px, weight 600.
- Nhãn phụ, ngày tháng: 12–13px, weight 400, `--text-secondary`.
- Nút CTA: 15px, weight 600, letter-spacing bình thường (không cần in hoa).

---

## 4. Nguyên tắc bố cục & component

### Bo góc & khoảng cách
- Card/modal lớn: bo góc **24–28px**.
- Nút, chip, pill: bo góc **full (9999px)**.
- Icon chip nhỏ: bo góc **12px** (bo mềm, không tròn hoàn toàn).
- Padding trong card: 18–20px. Khoảng cách giữa các khối: 12–16px.

### Đổ bóng
- Modal nổi trên nền gradient: bóng mềm `0 20px 40px rgba(0,0,0,0.12)` — đủ để tách lớp, không quá gắt.
- Hàng trong list: **không bóng riêng**, chỉ cách nhau bằng khoảng trắng hoặc divider mảnh `--border-hairline`.

### Icon
- Toàn bộ icon dạng outline, 1 màu, đặt trong chip nền nhạt cùng tông (`--icon-tint-bg` + `--icon-tint-fg`).
- Logo thẻ (Visa/Mastercard...) dùng hình minh hoạ thật, không icon outline.

### Nút & trạng thái chọn
- CTA chính: pill đen `--ink-cta`, chữ trắng, full-width, luôn nằm cố định ở đáy màn/modal.
- Trạng thái được chọn (radio-list): viền đen 2px quanh toàn bộ hàng + icon tick đen ở góc phải.
- Chip filter (VD "All Bills" / "Need Actions"): pill nhỏ, active = nền đen chữ trắng, inactive = nền xám nhạt chữ xám.

### Modal / Bottom sheet
- Nền phía sau bị mờ/tối nhẹ (dim) để modal nổi bật.
- Cấu trúc modal chuẩn: tiêu đề + nút đóng (X) góc phải → khối thông tin chính (icon chip + tên) → khối "Summary" các dòng label/value → nút CTA pill đen ở đáy.
- Modal trạng thái thành công: icon tick trắng trong vòng tròn đen ở giữa, tiêu đề đậm, mô tả ngắn 1 dòng, nút "Go Home"/"Xong" pill đen.

---

## 5. Áp dụng vào từng màn hình FinWise

Ánh xạ trực tiếp phong cách trên vào các module đã có trong bản kế hoạch chức năng:

| Thành phần tham chiếu | Áp dụng cho màn FinWise |
|---|---|
| Hero gradient + số dư + nút Deposit/Transfer | **Home Dashboard** (mục 7): Total Balance, nút nhanh "Thêm chi" / "Thêm thu", nút vuông đen "Quét hoá đơn" thay cho icon quét vân tay — tận dụng đúng vị trí này cho tính năng **OCR hoá đơn** (mục 58), một điểm khác biệt của app. |
| Card trắng nổi "Bill negotiator" | **Financial Insights** (mục 59): card gợi ý tiết kiệm/tự động phân tích nổi trên hero, VD "Tháng này bạn chi ăn uống nhiều hơn 21%". |
| List "Bills & Payments" (icon chip, tên, hạn, số tiền) | **Recent Transactions** (mục 10) và **Recurring Transactions** (mục 52): mỗi dòng icon chip theo category, tên, ngày, số tiền căn phải. |
| Modal "Confirm Payment" (summary rows + CTA đen) | Màn xác nhận khi **Add Income/Add Expense** (mục 14–15) trước khi lưu: hiển thị tóm tắt số tiền, category, phương thức thanh toán, nút "Xác nhận". |
| Modal "Payment sent" (tick đen + Go Home) | Trạng thái thành công sau khi lưu giao dịch, đổi PIN (mục 41), đổi mật khẩu (mục 43) — dùng chung một mẫu thành công cho toàn app. |
| Màn "Choose Card" (radio-list, viền chọn, Continue) | **Chọn phương thức thanh toán** khi thêm giao dịch (trường Payment method, mục 13/15), hoặc **chọn category** khi phân loại chi tiêu. |
| Bottom nav tối giản | Giữ nguyên cấu trúc 5 tab đã có (mục 51: Home, Analysis, Transactions, Categories, Profile), style icon outline phẳng, tab active tô đậm/nền đen nhỏ quanh icon. |

---

## 6. Bảng thành phần UI cần chuẩn hoá (component checklist)

- [ ] Hero balance card (gradient + số dư + 2 nút hành động)
- [ ] Promo/insight card (nền trắng, icon nhỏ đầu dòng, nút mũi tên)
- [ ] List row chuẩn (icon chip + tên/phụ đề + giá trị phải)
- [ ] Filter chip pill (active/inactive)
- [ ] Bottom sheet chuẩn (title + X, summary rows, CTA đen)
- [ ] Success state chuẩn (tick đen giữa, tiêu đề, mô tả, CTA)
- [ ] Radio-list selection row (viền chọn + tick)
- [ ] Nút CTA pill đen (dùng xuyên suốt toàn app, không đổi màu theo màn)
- [ ] Bottom navigation 5 tab

---

## 7. Bước tiếp theo gợi ý

1. Dựng demo trực quan (mockup) cho Home Dashboard theo đúng token màu/typography ở trên để duyệt trước khi làm các màn khác.
2. Dựng mẫu bottom sheet "Xác nhận giao dịch" — vì đây là màn dùng lại nhiều nhất (Add Income, Add Expense, Change PIN, Change Password).
3. Chốt bộ icon chip màu theo category (Food, Transport, Rent...) thay vì chỉ một tông xanh như ảnh gốc, để phân biệt trực quan giữa các loại chi tiêu.
