# 📘 Hướng Dẫn Cấu Trúc Micro-Modular & Design Tokens - PhimFlux

> **Tài liệu chuẩn bị phát triển trong Antigravity IDE**  
> *Phiên bản: 2.3.0 (Tối ưu Micro-Files, UI Mockups, Lộ Trình Lập Trình Xen Kẽ & Kiểm Thử)*  
> *Mục đích: Định nghĩa chi tiết các Design Tokens (màu sắc, hiệu ứng Glow, viền Remote TV), phân tách mã nguồn thành từng file nhỏ đơn lẻ (< 100 dòng code/file) và tích hợp hệ thống tài liệu hướng dẫn từng bước xen kẽ kiểm thử.*

---

## 📑 Mục Lục
1. [Bộ Design Tokens Khớp 100% UI Design](#1-bộ-design-tokens-khớp-100-ui-design)
2. [Quy Chuẩn Micro-File (1 Tính Năng Nhỏ / 1 File)](#2-quy-chuẩn-micro-file)
3. [Sơ Đồ Chi Tiết Danh Sách Các File Mã Nguồn Nguồn Nhỏ](#3-sơ-đồ-chi-tiết-danh-sách-các-file-mã-nguồn)
4. [Bộ 4 Tài Liệu Chuẩn Bị Dự Án (Project Documentation Hub)](#4-bộ-4-tài-liệu-chuẩn-bị-dự-án)
5. [Quy Trình Kiểm Tra & Triển Khai Trong Antigravity IDE](#5-quy-trình-kiểm-tra--triển-khai)

---

## 1. Bộ Design Tokens Khớp 100% UI Design

Tất cả các thành phần UI phải sử dụng đúng bảng màu và hiệu ứng được trích xuất từ **UI Mockup đã duyệt**:

### 🎨 Bảng Màu (Color Tokens) - `lib/core/theme/app_colors.dart`
- **Primary Focus Glow**: `#00E5FF` (Neon Cyan) - Dùng cho viền phát sáng khi Remote hover.
- **Secondary Accent**: `#FF9800` (Neon Orange) - Dùng cho thẻ Hot / Rating.
- **Dark Background Core**: `#0D0F14` - Màu nền nhung tối sâu toàn bộ ứng dụng.
- **Card Background**: `#181B22` - Màu nền cho các card phim & nút bấm chưa focus.
- **Card Focus Background**: `#222733` - Màu nền card khi được chọn.
- **Text Primary**: `#FFFFFF` - Tiêu đề chính.
- **Text Secondary**: `#9E9E9E` - Đạo diễn, diễn viên, năm phát hành.

### ✨ Hiệu Ứng Remote TV Focus Tokens
- **Scale Factor**: `1.05x` (Phóng to nhẹ 5% khi Focus).
- **Glow Shadow**: `BoxShadow(color: Color(0xFF00E5FF).withOpacity(0.6), blurRadius: 16, spreadRadius: 2)`.
- **Border Focus**: `Border.all(color: Color(0xFF00E5FF), width: 2.5)`.

---

## 2. Quy Chuẩn Micro-File

Để mã nguồn cực kỳ dễ đọc, kiểm tra và nâng cấp trong Antigravity IDE, quy định về file code như sau:

1. **Giới hạn kích thước file**: Mỗi file code chỉ chứa **duy nhất 1 Widget/Class**, độ dài lý tưởng dưới **100 dòng code**.
2. **Tách nhỏ tính năng**:
   - *Không gộp*: Không đặt Nút Play, Thẻ HD và Ảnh Poster vào chung 1 file card phim lớn.
   - *Tách riêng*: 
     - Thẻ HD -> `quality_tag_badge.dart` (~25 dòng)
     - Ảnh Poster -> `movie_poster_image.dart` (~40 dòng)
     - Nút Play -> `primary_play_button.dart` (~35 dòng)
     - Card Phim -> `focusable_movie_card.dart` (~50 dòng, lắp ráp các widget trên)

---

## 3. Sơ Đồ Chi Tiết Danh Sách Các File Mã Nguồn

```text
lib/
├── main.dart                                  # Ex: ~30 dòng (Khởi chạy app)
│
├── core/                                      # [TẦNG DÙNG CHUNG DUY NHẤT]
│   ├── theme/
│   │   ├── app_colors.dart                    # Ex: ~25 dòng (Bảng màu Neon)
│   │   └── app_typography.dart                # Ex: ~30 dòng (Kiểu chữ)
│   ├── player/
│   │   └── video_player_wrapper.dart          # Ex: ~90 dòng (Core Video Player)
│   └── state/
│       ├── bookmark_provider.dart             # Ex: ~50 dòng (Phim Yêu Thích)
│       └── history_provider.dart              # Ex: ~50 dòng (Lịch Sử Xem)
│
├── data/                                      # [TẦNG DỮ LIỆU & API]
│   ├── models/
│   │   ├── movie_summary.dart                 # Ex: ~40 dòng
│   │   ├── movie_detail.dart                  # Ex: ~60 dòng
│   │   └── episode.dart                       # Ex: ~35 dòng
│   ├── services/
│   │   └── api_service.dart                   # Ex: ~80 dòng (HTTP Client)
│   └── repositories/
│       └── movie_repository.dart              # Ex: ~70 dòng (Repository)
│
└── ui/                                        # [TẦNG UI MICRO-WIDGETS]
    │
    ├── core_widgets/                          # [Nhóm 0: Micro Widgets Dùng Chung]
    │   ├── focus/
    │   │   ├── neon_glow_border.dart          # Ex: ~30 dòng (Hiệu ứng viền Neon)
    │   │   ├── focus_scale_wrapper.dart       # Ex: ~25 dòng (Hiệu ứng phóng to 1.05x)
    │   │   └── tv_focusable_wrapper.dart      # Ex: ~45 dòng (Lắp ráp Focus + Glow + Click)
    │   ├── badges/
    │   │   ├── quality_tag_badge.dart         # Ex: ~25 dòng (Thẻ 4K/HD)
    │   │   ├── language_tag_badge.dart        # Ex: ~25 dòng (Thẻ Vietsub)
    │   │   └── rating_star_item.dart          # Ex: ~30 dòng (Điểm IMDb star)
    │   ├── cards/
    │   │   ├── movie_poster_image.dart        # Ex: ~40 dòng (Image Cache + Shimmer)
    │   │   ├── focusable_movie_card.dart      # Ex: ~60 dòng (Card Phim Chuẩn)
    │   │   └── skeleton_card.dart             # Ex: ~30 dòng (Loading Placeholder)
    │   └── buttons/
    │       ├── primary_play_button.dart       # Ex: ~40 dòng (Nút "Xem Ngay" Cyan)
    │       └── secondary_action_button.dart   # Ex: ~40 dòng (Nút "Thêm Tủ Phim")
    │
    ├── components/                            # [Nhóm 1: Shared Bố Cục & Navigation]
    │   ├── sidebar/
    │   │   ├── tv_sidebar_item.dart           # Ex: ~35 dòng (1 mục menu sidebar)
    │   │   └── tv_sidebar_menu.dart           # Ex: ~65 dòng (Thanh sidebar TV)
    │   ├── app_bar/
    │   │   └── custom_app_bar.dart            # Ex: ~45 dòng (Header Logo & Search)
    │   └── pagination/
    │       └── pagination_bar.dart            # Ex: ~50 dòng (Thanh chọn trang)
    │
    └── features/                              # [Nhóm 2-5: Micro Widgets Theo Màn Hình]
        ├── home/widgets/                      # [Group 2: Trang Chủ]
        │   ├── hero_backdrop_image.dart       # Ex: ~35 dòng (Ảnh nền Hero mờ)
        │   ├── hero_title_info.dart           # Ex: ~45 dòng (Tiêu đề + Thể loại Hero)
        │   ├── hero_banner_slider.dart        # Ex: ~70 dòng (Banner chính Trang chủ)
        │   ├── horizontal_section_header.dart # Ex: ~30 dòng (Tiêu đề nhóm phim)
        │   └── horizontal_movie_list.dart     # Ex: ~60 dòng (Hàng phim cuộn ngang)
        │
        ├── detail/widgets/                    # [Group 4: Chi Tiết Phim]
        │   ├── detail_header_info.dart        # Ex: ~55 dòng (Tên + Diễn viên + Mô tả)
        │   ├── server_tab_button.dart         # Ex: ~35 dòng (Nút chọn Server)
        │   ├── episode_button.dart            # Ex: ~40 dòng (Nút số tập phim)
        │   └── episode_grid_section.dart      # Ex: ~65 dòng (Lưới chọn tập & Server)
        │
        └── player/widgets/                    # [Group 5: Trình Phát Video]
            ├── player_osd_top_bar.dart        # Ex: ~40 dòng (Header OSD: Back + Tên)
            ├── player_progress_bar.dart       # Ex: ~45 dòng (Thanh Timeline Cyan)
            └── player_control_buttons.dart    # Ex: ~60 dòng (Nút Play/Pause/Tua 10s)
```

---

## 4. Bộ 4 Tài Liệu Chuẩn Bị Dự Án (Project Documentation Hub)

Tất cả các tài liệu chuẩn bị đều nằm trực tiếp tại thư mục dự án của bạn để xem và chỉnh sửa trong Antigravity IDE:

1. **[DEVELOPMENT_STEPS.md](file:///Users/tb3c/watch_movies/DEVELOPMENT_STEPS.md)**: Quy trình 12 bước xen kẽ giữa việc **Tạo Code Micro-Module** ➡️ **Kiểm Thử Nghiệm Thu**.
2. **[ui_mockups.md](file:///Users/tb3c/watch_movies/ui_mockups.md)**: Hiển thị 4 hình ảnh mockup giao diện mẫu (Smart TV Home, TV Detail, TV Video Player và Mobile).
3. **[TESTING_GUIDE.md](file:///Users/tb3c/watch_movies/TESTING_GUIDE.md)**: Hướng dẫn chạy lệnh kiểm thử tự động, test phím Remote TV D-Pad và kiểm tra RAM.
4. **[DEVELOPMENT_GUIDE.md](file:///Users/tb3c/watch_movies/DEVELOPMENT_GUIDE.md)**: Tài liệu hướng dẫn kiến trúc, Design Tokens và sơ đồ Micro-Files.

---

## 5. Quy Trình Kiểm Tra & Triển Khai Trong Antigravity IDE

1. **Mở `DEVELOPMENT_STEPS.md`**: Làm theo từng bước 1 đến 12.
2. **Xen kẽ Tạo Code ➡️ Test**: Sau mỗi bước tạo code nhỏ, thực hiện ngay lệnh test tương ứng để đảm bảo tính chính xác trước khi sang bước tiếp theo.
