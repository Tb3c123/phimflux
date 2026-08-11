# 🧪 Hướng Dẫn Kiểm Thử & Kiểm Định Chất Lượng (Testing & QA Guide) - PhimFlux

> **Tài liệu hướng dẫn kiểm thử toàn diện sau khi hoàn tất xây dựng code**  
> *Phiên bản: 1.0.0 | Ngày tạo: 11/08/2026*  
> *Mục đích: Cung cấp quy trình kiểm thử từng bước (Automated Unit/Widget Test & Manual QA Test) cho ứng dụng PhimFlux trên Mobile và Smart TV.*

---

## 📑 Mục Lục
1. [Quy Trình Kiểm Thử Tự Động (Automated Testing)](#1-quy-trình-kiểm-thử-tự-động)
2. [Kiểm Thử Độc Lập Micro-Widget (Widget Isolation Test)](#2-kiểm-thử-độc-lập-micro-widget)
3. [Bảng Kiểm Thử Thủ Công Trên Smart TV (Android TV & Apple TV QA Checklist)](#3-bảng-kiểm-thử-thủ-công-trên-smart-tv)
4. [Bảng Kiểm Thử Thủ Công Trên Mobile (Android & iOS QA Checklist)](#4-bảng-kiểm-thử-thủ-công-trên-mobile)
5. [Kiểm Thử Khả Năng Kháng Lỗi & Mạng Yếu (Resilience & Edge Case Test)](#5-kiểm-thử-khả-năng-kháng-lỗi--mạng-yếu)
6. [Kiểm Tra Bộ Nhớ & Hiệu Năng (Memory & Performance Audit)](#6-kiểm-tra-bộ-nhớ--hiệu-năng)

---

## 1. Quy Trình Kiểm Thử Tự Động

Sau khi triển khai mã nguồn, thực hiện chạy lệnh kiểm thử tự động bằng Flutter CLI:

### 1.1 Kiểm Thử Đơn Vị (Unit Tests) - Data & Logic Layer
Kiểm tra khả năng parse JSON API, quản lý State và Repository:

```bash
# Chạy tất cả Unit Test trong thư mục test/
flutter test test/data/
```

* **Các kịch bản kiểm thử bắt buộc (Unit Test Scenarios)**:
  - [ ] `ApiServiceTest`: Gọi API `phim-moi-cap-nhat` parse đúng danh sách `MovieSummary` không bị null field.
  - [ ] `MovieDetailTest`: Parse dữ liệu phim chi tiết kèm danh sách `Episode` và URL `embed`.
  - [ ] `BookmarkProviderTest`: Thêm phim vào danh sách yêu thích -> Lưu vào LocalStorage thành công.
  - [ ] `HistoryProviderTest`: Cập nhật thời gian xem dở của phim (vd: `34:20`) -> Lấy lại đúng thời gian.

---

## 2. Kiểm Thử Độc Lập Micro-Widget

Do ứng dụng được tách thành các file micro-widget cực nhỏ (<100 dòng/file), ta có thể viết Widget Test kiểm tra riêng từng tính năng UI:

```bash
# Chạy toàn bộ Widget Test cho UI
flutter test test/ui/
```

* **Các kịch bản kiểm thử Micro-Widget**:
  - [ ] `NeonGlowBorderTest`: Kiểm tra khi `isFocused = true` thì viền đổi màu `#00E5FF` và hiển thị BoxShadow.
  - [ ] `FocusScaleWrapperTest`: Kiểm tra khi Focus vào thì phần tử phóng to tỉ lệ `1.05x`.
  - [ ] `QualityTagBadgeTest`: Hiển thị đúng text badge `4K`, `HDR`, `HD` theo dữ liệu API.
  - [ ] `EpisodeButtonTest`: Kiểm tra nút chọn tập phản hồi sự kiện click/tap.

---

## 3. Bảng Kiểm Thử Thủ Công Trên Smart TV

Dành riêng cho việc thử nghiệm với **Remote TV (D-Pad Navigation)** trên Android TV Emulator hoặc Google TV thực tế:

### 🎮 Danh Sách Kiểm Tra D-Pad Remote TV:

| Kịch Bản | Thao Tác Remote TV | Kết Quả Mong Đợi | Đạt / Lỗi |
| :--- | :--- | :--- | :--- |
| **Khởi chạy App** | Mở ứng dụng trên TV | Nút "XEM NGAY" ở Banner chính nhận Focus mặc định với viền Cyan sáng rực. | [ ] Pass |
| **Di chuyển D-Pad** | Bấm phím Phải `▶` / Trái `◀` | Viền phát sáng Cyan di chuyển mượt sang Card phim bên cạnh. Card cũ trở lại bình thường. | [ ] Pass |
| **Mở TV Sidebar** | Bấm phím Trái `◀` từ lề trái | Tiêu điểm chuyển sang Sidebar bên trái, Sidebar tự mở rộng hiển thị tên các mục Menu. | [ ] Pass |
| **Bấm chọn phim** | Bấm phím `OK` / `Select` | Mở màn hình Chi Tiết Phim tương ứng với hiệu ứng chuyển trang mượt. | [ ] Pass |
| **Chọn Tập Phim** | Di chuyển D-Pad xuống danh sách tập & bấm `OK` | Nút số tập phát sáng, màn hình phát Video tự động mở tập phim vừa chọn. | [ ] Pass |
| **Điều khiển Video OSD**| Bấm phím `Down` hoặc `OK` khi đang phát phim | Khung OSD hiện ra (Timeline, Play/Pause, Tua 10s). Sau 3 giây không bấm gì thì OSD tự ẩn. | [ ] Pass |
| **Bấm Nút Back** | Bấm phím `Back` / `Return` từ Remote | Thoát màn hình phát phim, dừng phát âm thanh và trở về màn hình trước. | [ ] Pass |

---

## 4. Bảng Kiểm Thử Thủ Công Trên Mobile

Dành cho thiết bị di động Android & iOS (Thao tác vuốt chạm Touch Screen):

- [ ] **Cuộn mượt (Smooth Scroll)**: Vuốt danh sách phim theo hàng ngang và dọc không bị khựng frame (FPS luôn đạt 60fps/120fps).
- [ ] **Chạm mở phim (Tap Response)**: Chạm nhẹ vào bất kỳ Card phim nào -> Phản hồi lập tức.
- [ ] **Xoay màn hình (Orientation)**: Xem phim ở chế độ dọc -> Bấm nút Toàn Màn Hình -> Tự xoay ngang màn hình (Landscape Video Player).
- [ ] **Bottom Navigation Bar**: Chuyển đổi giữa các tab Trang Chủ, Khám Phá, Tìm Kiếm, Tủ Phim mượt mà.

---

## 5. Kiểm Thử Khả Năng Kháng Lỗi & Mạng Yếu

Thử nghiệm ứng dụng trong các điều kiện môi trường bất lợi:

1. **Kiểm thử Mạng Yếu / Mất Mạng (Offline & Slow 3G)**:
   - Ngắt kết nối Wi-Fi/Internet -> Màn hình hiển thị giao diện báo lỗi thân thiện kèm nút **"Thử lại" (Retry)**.
   - Khi có lại mạng -> Bấm "Thử lại" ứng dụng tự động tải dữ liệu bình thường.
2. **Kiểm thử Lỗi Mất Ảnh Poster**:
   - Nếu API trả về URL ảnh bị lỗi 404 -> Ứng dụng tự động hiển thị ảnh Placeholder dự phòng, không bị hiện ô vuông đen vỡ nét.
3. **Kiểm thử Tìm Kiếm Không Có Kết Quả**:
   - Nhập từ khóa ngẫu nhiên (vd: `qwerty12345`) -> Màn hình hiển thị thông báo "Không tìm thấy phim phù hợp".

---

## 6. Kiểm Tra Bộ Nhớ & Hiệu Năng

Đảm bảo ứng dụng hoạt động ổn định lâu dài trên TV có dung lượng RAM hạn chế (1GB - 2GB RAM):

```bash
# Kiểm tra hiệu năng và phát hiện Memory Leak
flutter run --profile
```

- [ ] **Giải phóng Video Player**: Khi người dùng xem xong phim và bấm Back -> Trình phát video gọi `dispose()`, giải phóng ngay dung lượng RAM đã lưu cache buffer video.
- [ ] **Cache Hình Ảnh**: `cached_network_image` tự động giải phóng các poster phim cũ ngoài màn hình, giữ RAM sử dụng dưới mức **150MB**.

---

> 💡 **Tài liệu kiểm thử đã sẵn sàng để nghiệm thu sau khi tiến hành viết code!**
