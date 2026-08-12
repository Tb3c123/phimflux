# 📘 Hướng Dẫn Cấu Trúc Micro-Modular & Hybrid TV/Web Focus Engine - PhimFlux

> **Tài liệu chuẩn bị phát triển trong Antigravity IDE**  
> *Phiên bản: 3.3.0 (Tối ưu Micro-Files, UI Mockups, Icon Logo, TV/Web Focus Guide & Kế Hoạch Triển Khai Code Mới)*  
> *Mục đích: Định nghĩa chi tiết các Design Tokens (màu sắc, hiệu ứng Glow, viền Remote TV), phân tách mã nguồn thành từng file nhỏ đơn lẻ (< 100 dòng code/file) và tích hợp hệ thống bộ nhận diện thương hiệu Logo Icon, tài liệu hướng dẫn điều hướng TV/Web và kế hoạch refactor code.*

---

## 📑 Mục Lục
1. [Bộ Design Tokens Khớp 100% UI Design](#1-bộ-design-tokens-khớp-100-ui-design)
2. [Quy Chuẩn Micro-File (1 Tính Năng Nhỏ / 1 File)](#2-quy-chuẩn-micro-file)
3. [Sơ Đồ Chi Tiết Danh Sách Các File Mã Nguồn Nguồn Nhỏ](#3-sơ-đồ-chi-tiết-danh-sách-các-file-mã-nguồn)
4. [Bộ 7 Tài Liệu Chuẩn Bị Dự Án (Project Documentation Hub)](#4-bộ-7-tài-liệu-chuẩn-bị-dự-án)
5. [Quy Trình Kiểm Tra & Triển Khai Trong Antigravity IDE](#5-quy-trình-kiểm-tra--triển-khai)

---

## 1. Bộ Design Tokens Khớp 100% UI Design

Tất cả các thành phần UI phải sử dụng đúng bảng màu và hiệu ứng được trích xuất từ **UI Mockup & Logo đã duyệt**:

### 🎨 Bảng Màu (Color Tokens) - `lib/core/theme/app_colors.dart`
- **Primary Focus Glow**: `#00E5FF` (Neon Cyan) - Dùng cho viền phát sáng khi Remote hover & Chữ "Flux".
- **Secondary Accent**: `#FF9800` (Neon Amber) - Dùng cho thẻ Hot / Rating.
- **Dark Background Core**: `#0D0F14` - Màu nền nhung tối sâu toàn bộ ứng dụng.
- **Card Background**: `#181B22` - Màu nền cho các card phim & nút bấm chưa focus.
- **Card Focus Background**: `#222733` - Màu nền card khi được chọn.
- **Text Primary**: `#FFFFFF` - Tiêu đề chính & Chữ "Phim".
- **Text Secondary**: `#9E9E9E` - Đạo diễn, diễn viên, năm phát hành.

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
│   ├── focus/
│   │   ├── tv_focus_engine.dart               # Core quản lý Scope Focus Sidebar ↔ Main
│   │   └── tv_focusable.dart                  # Widget bọc Focus TV Remote + Web Hover
│   ├── theme/
│   │   ├── app_colors.dart                    # Ex: ~25 dòng (Bảng màu Neon)
│   │   └── app_typography.dart                # Ex: ~30 dòng (Kiểu chữ)
│   └── player/
│       └── video_player_wrapper.dart          # Ex: ~90 dòng (Core Video Player)
│
├── data/                                      # [TẦNG DỮ LIỆU & API]
│   ├── models/
│   └── repositories/
│
└── ui/                                        # [TẦNG UI MICRO-WIDGETS]
    ├── core_widgets/
    │   ├── cards/focusable_movie_card.dart    # Card phim mượt D-Pad Remote & Web Hover
    │   └── buttons/primary_play_button.dart   # Nút Play tự động nhận Focus
    ├── components/
    │   └── sidebar/tv_sidebar_menu.dart       # Menu Sidebar nhận Focus lề trái
    └── features/
        ├── home/home_screen.dart              # Trang chủ di chuyển 2D 4 hướng
        ├── detail/detail_screen.dart          # Màn hình chi tiết & tập phim
        └── player/player_screen.dart          # Trình phát video điều khiển OSD
```

---

## 4. Bộ 7 Tài Liệu Chuẩn Bị Dự Án (Project Documentation Hub)

Tất cả các tài liệu chuẩn bị đều nằm trực tiếp tại thư mục dự án của bạn để xem và chỉnh sửa trong Antigravity IDE:

1. 🛠️ **[REFACTORING_IMPLEMENTATION_PLAN.md](file:///Users/tb3c/watch_movies/REFACTORING_IMPLEMENTATION_PLAN.md)**: Kế hoạch 6 giai đoạn triển khai mã nguồn mới dọn dẹp code Focus cũ.
2. 🎮 **[TV_NAVIGATION_GUIDE.md](file:///Users/tb3c/watch_movies/TV_NAVIGATION_GUIDE.md)**: Hướng dẫn chi tiết hệ thống điều hướng TV D-Pad Remote, Bàn phím & Mouse Hover Web.
3. 🎨 **[app_logo_design.md](file:///Users/tb3c/watch_movies/app_logo_design.md)**: Bộ nhận diện Icon App 3D (1:1) và Logo thương hiệu PhimFlux hàng ngang (16:9).
4. 🖼️ **[ui_mockups.md](file:///Users/tb3c/watch_movies/ui_mockups.md)**: Hiển thị 4 hình ảnh mockup giao diện mẫu (Smart TV Home, TV Detail, TV Video Player và Mobile).
5. 🔄 **[DEVELOPMENT_STEPS.md](file:///Users/tb3c/watch_movies/DEVELOPMENT_STEPS.md)**: Quy trình 12 bước xen kẽ giữa việc **Tạo Code Micro-Module** ➡️ **Kiểm Thử Nghiệm Thu**.
6. 🧪 **[TESTING_GUIDE.md](file:///Users/tb3c/watch_movies/TESTING_GUIDE.md)**: Hướng dẫn chạy lệnh kiểm thử tự động, test phím Remote TV D-Pad và kiểm tra RAM.
7. 📘 **[DEVELOPMENT_GUIDE.md](file:///Users/tb3c/watch_movies/DEVELOPMENT_GUIDE.md)**: Tài liệu hướng dẫn kiến trúc, Design Tokens và sơ đồ Micro-Files.
