# 🔄 Quy Trình Phát Triển Xen Kẽ Kiểm Thử (Development & Testing Steps) - PhimFlux

> **Tài liệu hướng dẫn triển khai từng bước kết hợp kiểm thử nghiệm thu trong Antigravity IDE**  
> *Phiên bản: 1.0.0 | Ngày khởi tạo: 11/08/2026*  
> *Mục đích: Định nghĩa lộ trình xen kẽ **[Tạo Code Micro-Module] ➡️ [Kiểm Thử Nghiệm Thu]** cho đến khi ứng dụng xem phim PhimFlux hoàn thành 100%.*

---

## 📑 Sơ Đồ Vòng Lặp Phát Triển (Iterative Loop)

```text
 ┌────────────────────────────────────────────────────────┐
 │  TẠO MICRO-MODULE CODE (< 100 dòng code / 1 widget)    │
 └───────────────────────────┬────────────────────────────┘
                             │
                             ▼
 ┌────────────────────────────────────────────────────────┐
 │  KIỂM THỬ VÀ NGHIỆM THU (Unit Test / Widget Test / QA)│
 └───────────────────────────┬────────────────────────────┘
                             │
            ┌────────────────┴────────────────┐
            │  Đạt tiêu chuẩn?                │
            ├─────────────────┬───────────────┤
            │ KHÔNG           │ CÓ            │
            ▼                 ▼               │
    [Sửa lỗi bọc nhỏ]   [Chuyển Bước Tiếp Theo]
```

---

## 🏁 Bảng Các Bước Triển Khai Xen Kẽ (Development Roadmap)

---

### 🔹 BƯỚC 1: Khởi Tạo Nền Tảng Theme & Design Tokens

* **🔨 [Tạo Code]**:
  1. Tạo `pubspec.yaml` với các thư viện: `http`, `provider`, `video_player`, `cached_network_image`.
  2. Tạo `lib/core/theme/app_colors.dart` (~25 dòng): Mã màu Cyan Neon `#00E5FF`, Dark BG `#0D0F14`.
  3. Tạo `lib/core/theme/app_typography.dart` (~30 dòng): Định nghĩa phông chữ và kiểu chữ.
* **🧪 [Kiểm Thử & Nghiệm Thu]**:
  - Lệnh kiểm tra: `flutter pub get`
  - Đảm bảo các gói thư viện cài đặt thành công không có xung đột phiên bản.

---

### 🔹 BƯỚC 2: Hệ Thống Remote TV Focus & Neon Glow

* **🔨 [Tạo Code]**:
  1. Tạo `lib/ui/core_widgets/focus/neon_glow_border.dart` (~30 dòng): Container phát sáng Cyan khi `isFocused = true`.
  2. Tạo `lib/ui/core_widgets/focus/focus_scale_wrapper.dart` (~25 dòng): Hiệu ứng phóng to `1.05x`.
  3. Tạo `lib/ui/core_widgets/focus/tv_focusable_wrapper.dart` (~45 dòng): Bọc nhận sự kiện phím Remote TV.
* **🧪 [Kiểm Thử & Nghiệm Thu]**:
  - Chạy lệnh Widget Test: `flutter test test/ui/core_widgets/focus_test.dart`
  - **Tiêu chuẩn đạt**: Khi `isFocused = true`, Widget hiển thị đúng viền Neon Cyan `#00E5FF` và phóng to 5%.

---

### 🔹 BƯỚC 3: Micro-Badges & Nút Bấm Nguyên Tử (Atomic Widgets)

* **🔨 [Tạo Code]**:
  1. Tạo `lib/ui/core_widgets/badges/quality_tag_badge.dart` (~25 dòng): Thẻ `4K`, `HDR`, `HD`.
  2. Tạo `lib/ui/core_widgets/badges/language_tag_badge.dart` (~25 dòng): Thẻ `Vietsub`, `Thuyết Minh`.
  3. Tạo `lib/ui/core_widgets/badges/rating_star_item.dart` (~30 dòng): Icon sao vàng kèm điểm IMDb.
  4. Tạo `lib/ui/core_widgets/buttons/primary_play_button.dart` (~40 dòng): Nút "Xem Ngay" màu Cyan.
* **🧪 [Kiểm Thử & Nghiệm Thu]**:
  - Chạy lệnh: `flutter test test/ui/core_widgets/badges_test.dart`
  - **Tiêu chuẩn đạt**: Nút bấm nhận sự kiện tap/click, hiển thị chuẩn phông chữ và thẻ chất lượng.

---

### 🔹 BƯỚC 4: Card Phim & Skeleton Loading

* **🔨 [Tạo Code]**:
  1. Tạo `lib/ui/core_widgets/cards/movie_poster_image.dart` (~40 dòng): Image cache + Shimmer.
  2. Tạo `lib/ui/core_widgets/cards/focusable_movie_card.dart` (~60 dòng): Lắp ráp Poster + Focus Glow + Tiêu đề.
  3. Tạo `lib/ui/core_widgets/cards/skeleton_card.dart` (~30 dòng): Khung mờ khi đang nạp API.
* **🧪 [Kiểm Thử & Nghiệm Thu]**:
  - Test hiển thị với URL ảnh giả định & URL ảnh lỗi.
  - **Tiêu chuẩn đạt**: Nếu ảnh bị lỗi 404, tự động hiện ảnh Placeholder dự phòng, không bị crash app.

---

### 🔹 BƯỚC 5: Tầng Data & Tích Hợp API NguonC

* **🔨 [Tạo Code]**:
  1. Tạo `lib/data/models/movie_summary.dart`, `movie_detail.dart`, `episode.dart`.
  2. Tạo `lib/data/services/api_service.dart` (~80 dòng): HTTP Client gọi `phim.nguonc.com`.
  3. Tạo `lib/data/repositories/movie_repository.dart` (~70 dòng): Cung cấp dữ liệu phim cho UI.
* **🧪 [Kiểm Thử & Nghiệm Thu]**:
  - Lệnh Unit Test: `flutter test test/data/api_service_test.dart`
  - **Tiêu chuẩn đạt**: Gọi thành công API real-time `phim-moi-cap-nhat`, parse đúng cấu trúc JSON không bị null.

---

### 🔹 BƯỚC 6: Bố Cục Điều Hướng (TV Sidebar & Navigation)

* **🔨 [Tạo Code]**:
  1. Tạo `lib/ui/components/sidebar/tv_sidebar_item.dart` (~35 dòng).
  2. Tạo `lib/ui/components/sidebar/tv_sidebar_menu.dart` (~65 dòng): Thanh Menu bên trái cho TV.
  3. Tạo `lib/ui/components/app_bar/custom_app_bar.dart` (~45 dòng): Header Logo & Search.
  4. Tạo `lib/ui/components/pagination/pagination_bar.dart` (~50 dòng): Thanh chuyển trang.
* **🧪 [Kiểm Thử & Nghiệm Thu]**:
  - Chạy `flutter run -d chrome`
  - **Tiêu chuẩn đạt**: Khi di chuyển Focus lề trái -> TV Sidebar tự mở rộng hiển thị nhãn các mục Menu.

---

### 🔹 BƯỚC 7: Màn Hình Trang Chủ (Home Screen)

* **🔨 [Tạo Code]**:
  1. Tạo `lib/ui/features/home/widgets/hero_backdrop_image.dart` (~35 dòng).
  2. Tạo `lib/ui/features/home/widgets/hero_title_info.dart` (~45 dòng).
  3. Tạo `lib/ui/features/home/widgets/hero_banner_slider.dart` (~70 dòng): Banner phim chính.
  4. Tạo `lib/ui/features/home/widgets/horizontal_movie_list.dart` (~60 dòng): Hàng phim cuộn ngang.
  5. Tạo `lib/ui/features/home/home_screen.dart` (~80 dòng): Lắp ráp trang chủ.
* **🧪 [Kiểm Thử & Nghiệm Thu]**:
  - Chạy thử trên Android TV Emulator hoặc Browser: `flutter run`
  - **Tiêu chuẩn đạt**: Trang chủ load dữ liệu từ API NguonC, cuộn ngang/dọc bằng D-Pad Remote mượt mà.

---

### 🔹 BƯỚC 8: Màn Hình Danh Mục & Tìm Kiếm (Catalog & Search)

* **🔨 [Tạo Code]**:
  1. Tạo `lib/ui/features/catalog/widgets/filter_chip_group.dart` (~45 dòng): Chọn Thể loại/Quốc gia.
  2. Tạo `lib/ui/features/catalog/widgets/movie_grid_view.dart` (~55 dòng): Lưới phim 4 cột.
  3. Tạo `lib/ui/features/catalog/catalog_screen.dart` (~75 dòng).
  4. Tạo `lib/ui/features/search/widgets/search_input_bar.dart` (~40 dòng) & `search_screen.dart`.
* **🧪 [Kiểm Thử & Nghiệm Thu]**:
  - Test chuyển trang (Pagination) & chọn bộ lọc thể loại `hanh-dong`.
  - **Tiêu chuẩn đạt**: Kết quả lọc và tìm kiếm trả về danh sách phim chính xác theo keyword.

---

### 🔹 BƯỚC 9: Màn Hình Chi Tiết Phim & Chọn Tập (Movie Detail)

* **🔨 [Tạo Code]**:
  1. Tạo `lib/ui/features/detail/widgets/detail_header_info.dart` (~55 dòng).
  2. Tạo `lib/ui/features/detail/widgets/server_tab_button.dart` (~35 dòng).
  3. Tạo `lib/ui/features/detail/widgets/episode_button.dart` (~40 dòng).
  4. Tạo `lib/ui/features/detail/widgets/episode_grid_section.dart` (~65 dòng).
  5. Tạo `lib/ui/features/detail/detail_screen.dart` (~85 dòng).
* **🧪 [Kiểm Thử & Nghiệm Thu]**:
  - Test chọn giữa Server Vietsub và Server Thuyết minh.
  - **Tiêu chuẩn đạt**: Nút "XEM TẬP 1" tự động nhận Focus mặc định, danh sách tập hiển thị đầy đủ.

---

### 🔹 BƯỚC 10: Core Video Player & Điều Khiển OSD (Player Screen)

* **🔨 [Tạo Code]**:
  1. Tạo `lib/core/player/video_player_wrapper.dart` (~90 dòng): Xử lý HLS M3U8 + Embed Webview.
  2. Tạo `lib/ui/features/player/widgets/player_osd_top_bar.dart` (~40 dòng).
  3. Tạo `lib/ui/features/player/widgets/player_progress_bar.dart` (~45 dòng).
  4. Tạo `lib/ui/features/player/widgets/player_control_buttons.dart` (~60 dòng).
  5. Tạo `lib/ui/features/player/player_screen.dart` (~80 dòng).
* **🧪 [Kiểm Thử & Nghiệm Thu]**:
  - Bấm phát tập phim -> Video chạy ổn định.
  - **Tiêu chuẩn đạt**: Khung điều khiển OSD tự ẩn sau 3 giây, các phím Remote Play/Pause/Tua 10s hoạt động tốt, RAM được giải phóng khi Back.

---

### 🔹 BƯỚC 11: State Management Dùng Chung (Yêu Thích & Lịch Sử Xem)

* **🔨 [Tạo Code]**:
  1. Tạo `lib/core/state/bookmark_provider.dart` (~50 dòng).
  2. Tạo `lib/core/state/history_provider.dart` (~50 dòng).
* **🧪 [Kiểm Thử & Nghiệm Thu]**:
  - Bấm nút "Thêm vào tủ phim" -> Lưu phim vào màn hình Tủ Phim.
  - Xem dở tập phim ở phút `34:20` -> Mở lại phim tự hiển thị thời gian đã xem dở.

---

### 🔹 BƯỚC 12: Tổng Kiểm Thử & Nghiệm Thu Cuối Cùng (End-to-End QA)

* **🔨 [Tạo Code]**: Lắp ráp `main.dart` hoàn chỉnh kết nối toàn bộ luồng ứng dụng.
* **🧪 [Kiểm Thử & Nghiệm Thu]**:
  - Chạy toàn bộ suite test: `flutter test`
  - Đối chiếu toàn bộ ứng dụng thực tế với tài liệu [TESTING_GUIDE.md](file:///Users/tb3c/watch_movies/TESTING_GUIDE.md) và [ui_mockups.md](file:///Users/tb3c/watch_movies/ui_mockups.md).
  - **Tiêu chuẩn hoàn thành**: Ứng dụng hoạt động mượt mà 100%, không có lỗi crash, giao diện hoàn toàn khớp với bản thiết kế.

---

> 💡 **Quy trình các bước phát triển xen kẽ kiểm thử đã sẵn sàng để tiến hành trong Antigravity IDE!**
