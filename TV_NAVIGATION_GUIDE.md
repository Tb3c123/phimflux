# 🎮 Hướng Dẫn Điều Hướng TV Theo Hành Trình Người Dùng (User Journey 6 Giai Đoạn) - PhimFlux

> **Tài liệu hướng dẫn kiến trúc và vận hành hệ thống điều hướng Smart TV Remote**  
> *Phiên bản: 3.0.0 | Ngày cập nhật: 12/08/2026*  
> *Mục đích: Hướng dẫn chi tiết cơ chế di chuyển theo Hành trình người dùng 6 giai đoạn: Mở app & Focus mặc định ➡️ Duyệt danh mục Lên/Xuống/Trái/Phải ➡️ Tìm kiếm Remote ➡️ Trang chi tiết ➡️ Điều khiển OSD ➡️ Thoát & Lưu vết lịch sử.*

---

## 🗺️ Bản Đồ Hành Trình Người Dùng (6 Giai Đoạn UX Flow)

```text
 ┌────────────────────────────────────────────────────────────────────────────────────────┐
 │ 1. MỞ APP & ĐỊNH VỊ FOCUS ĐẦU TIÊN                                                     │
 │    - Tự động nhảy Focus vào Item #1 của Hero Banner (hoặc Phim #1 Hàng #1).             │
 │    - Viền Neon Cyan phát sáng, phóng to 108%, làm mờ nhẹ các item xung quanh.           │
 └───────────────────────────────────┬────────────────────────────────────────────────────┘
                                     │
                                     ▼
 ┌────────────────────────────────────────────────────────────────────────────────────────┐
 │ 2. DUYỆT DANH MỤC (LÊN / XUỐNG / TRÁI / PHẢI)                                         │
 │    - Trái/Phải: Viền sáng nhảy mượt. Cuộn ngang khi chạm lề phải.                       │
 │    - Dừng Focus > 1s: Hero Banner tự động cập nhật thông tin & phát trailer ngắn.      │
 │    - Xuống: Nhảy hàng dưới, tự động cuộn dọc giữ hàng phim ở chính giữa (Alignment 0.5).│
 │    - Lên (hàng trên cùng): Nhảy Focus lên Thanh Menu / Searchbar / Sidebar.            │
 │    - Di chuyển thông minh: Tự chọn ô có tọa độ X gần nhất khi chuyển hàng khác size.  │
 └───────────────────────────────────┬────────────────────────────────────────────────────┘
                                     │
                                     ▼
 ┌────────────────────────────────────────────────────────────────────────────────────────┐
 │ 3. TÌM KIẾM BẰNG REMOTE                                                               │
 │    - Mũi tên Lên -> Trái -> Kính lặp (Search) -> Bấm OK.                              │
 │    - Bàn phím ảo dạng lưới Grid: D-Pad di chuyển qua chữ cái.                         │
 │    - Hàng gợi ý nằm ngay trên bàn phím: Bấm Lên (▲) từ phím để nhảy vào gợi ý.         │
 └───────────────────────────────────┬────────────────────────────────────────────────────┘
                                     │
                                     ▼
 ┌────────────────────────────────────────────────────────────────────────────────────────┐
 │ 4. CHỌN PHIM & TRANG CHI TIẾT (DETAIL SCREEN)                                         │
 │    - Bấm OK ở bất kỳ phim nào -> Mở màn hình Chi Tiết.                                 │
 │    - Focus mặc định nhảy ngay vào nút "Phát / Xem tiếp" (Play Button).                 │
 │    - Bấm Phải (▶): Nhảy sang các nút phụ ("Chọn tập", "Yêu thích", "Trailer").          │
 │    - Bấm Xuống (▼): Nhảy xuống hàng "Phim đề xuất / Liên quan".                        │
 └───────────────────────────────────┬────────────────────────────────────────────────────┘
                                     │
                                     ▼
 ┌────────────────────────────────────────────────────────────────────────────────────────┐
 │ 5. ĐIỀU KHIỂN TRONG LÚC PHÁT PHIM (PLAYBACK OSD CONTROL)                              │
 │    - Phim chạy: UI tự ẩn. Bấm phím bất kỳ: Khung OSD hiện ra (Focus tại Play/Seekbar).   │
 │    - Trái/Phải: Tua 10s (nhấn giữ để tua nhanh với thumbnail preview).                 │
 │    - Xuống (▼): Nhảy xuống các icon tính năng đáy (Tập, Subtitle/Audio, Chất lượng).   │
 │    - Lên (▲): Nhảy lên danh sách chọn nhanh các tập tiếp theo ở góc màn hình.          │
 └───────────────────────────────────┬────────────────────────────────────────────────────┘
                                     │
                                     ▼
 ┌────────────────────────────────────────────────────────────────────────────────────────┐
 │ 6. THOÁT & TẠM DƯNG (BACK & WATCH HISTORY)                                             │
 │    - Bấm Back: Đang xem -> Quay lại Trang chi tiết (Focus giữ nguyên ở nút Phát).      │
 │    - Tiến trình xem (vd: 34:20) tự động lưu vào mục "Tiếp tục xem" trên Trang chủ.      │
 └────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## 1. Chi Tiết Kỹ Thuật Từng Giai Đoạn

### 1.1 Giai Đoạn 1: Focus Đầu Tiên & Phóng To Viền Neon
- Widget `TvFocusable` tích hợp `autofocus: true` cho phần tử Hero Banner #1.
- Hiệu ứng Scale `1.08x` (Phóng to 108%) kèm `BoxShadow(color: Color(0xFF00E5FF), blurRadius: 18)`.
- Các phần tử xung quanh tự động giảm `Opacity` xuống `0.65` khi một phần tử được Focus.

### 1.2 Giai Đoạn 2: Duyệt Danh Mục & Debounce 1 Giây
- Bắt sự kiện phím Trái/Phải cuộn ngang danh sách khi tới lề phải.
- **Tự động xem trước (Focus Dwell Debounce)**: Tích hợp `Timer(Duration(seconds: 1))` khi dừng Focus quá 1 giây -> Phát sự kiện `onMovieHover(movie)` để cập nhật Hero Banner & Trailer ngắn.
- **Cuộn dọc chính giữa (Alignment 0.5)**: Khi di chuyển Lên/Xuống giữa các hàng phim, gọi `Scrollable.ensureVisible` đưa hàng phim vào vùng nhìn chính giữa màn hình.

### 1.3 Giai Đoạn 3: Tìm Kiếm & Bàn Phím Ảo
- Bàn phím ảo sắp xếp dạng lưới `Grid`.
- Hàng Chip gợi ý từ khóa nằm ngay đỉnh bàn phím: Bấm Lên `▲` từ hàng phím đầu tiên sẽ tự nhảy Focus vào các từ khóa gợi ý.

### 1.4 Giai Đoạn 4: Trang Chi Tiết & Nút Phát Mặc Định
- Focus mặc định đặt tại nút **"Phát / Xem tiếp"** màu Cyan nổi bật nhất.
- Bấm Phải `▶`: Di chuyển Focus qua nút "Chọn tập", "Thêm Yêu thích".
- Bấm Xuống `▼`: Di chuyển Focus xuống danh sách Phim Liên Quan.

### 1.5 Giai Đoạn 5: Trình Phát Video OSD & Tua Phim
- UI OSD tự ẩn khi phim chạy. Bấm phím bất kỳ -> OSD hiện lại với Focus ở nút Play/Pause hoặc Seekbar.
- Trái/Phải: Tua 10 giây/lần.
- Xuống `▼`: Di chuyển Focus xuống các icon Tập phim, Phụ đề, Âm thanh, Chất lượng.
- Lên `▲`: Hiển thị khung overlay chọn nhanh tập tiếp theo ở góc màn hình.

### 1.6 Giai Đoạn 6: Thoát & Lưu Lịch Sử Xem
- Bấm `Back`: Lưu chính xác thời gian xem dở (vd: `34:20`) vào LocalStorage qua `HistoryProvider`.
- Trở về `DetailScreen` với Focus giữ nguyên tại nút "Phát / Xem tiếp".

---

## 2. Quy Trình Kiểm Thử Nghiệm Thu Trong Antigravity IDE

Chạy ứng dụng trên Web Chrome để kiểm thử đầy đủ 6 giai đoạn:
```bash
flutter run -d chrome
```

- [ ] **Test Giai Đoạn 1**: Mở app -> Focus tự ở Hero #1, viền Cyan phát sáng, các item khác mờ nhẹ.
- [ ] **Test Giai Đoạn 2**: Di chuyển D-Pad -> Cuộn ngang/dọc alignment 0.5. Dừng 1s -> Hero Banner cập nhật phim.
- [ ] **Test Giai Đoạn 3**: Vào Tìm kiếm -> Bấm Lên từ bàn phím nhảy vào từ khóa gợi ý.
- [ ] **Test Giai Đoạn 4**: Mở Chi tiết -> Focus tự ở nút Phát. Bấm Phải chọn nút phụ, bấm Xuống chọn Phim liên quan.
- [ ] **Test Giai Đoạn 5**: Xem phim -> Bấm phím hiện OSD. Tua 10s. Bấm Xuống chọn Subtitle/Audio. Bấm Lên hiện overlay tập tiếp theo.
- [ ] **Test Giai Đoạn 6**: Bấm Back -> Trở về DetailScreen (Focus nằm ở nút Phát), tiến trình xem lưu vào "Tiếp tục xem".
