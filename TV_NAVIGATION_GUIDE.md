# 🎮 Hướng Dẫn Điều Hướng TV & Web (TV/Web Focus Navigation Guide) - PhimFlux

> **Tài liệu hướng dẫn kiến trúc và vận hành hệ thống điều hướng Hybrid Focus Engine**  
> *Phiên bản: 1.0.0 | Ngày khởi tạo: 12/08/2026*  
> *Mục đích: Hướng dẫn chi tiết cơ chế hoạt động của hệ thống D-Pad Remote TV (Android TV / Apple TV) và Bàn phím & Mouse Hover trên Web.*

---

## 📑 Mục Lục
1. [Tổng Quan Kiến Trúc TV & Web Focus Engine](#1-tổng-quan-kiến-trúc-tv--web-focus-engine)
2. [Chi Tiết Hai Chế Độ Hoạt Động (Hybrid Navigation Modes)](#2-chi-tiết-hai-chế-độ-hoạt-động)
3. [Quy Tắc Quản Lý Focus Scope (Sidebar ↔ Nội Dung Phim)](#3-quy-tắc-quản-lý-focus-scope)
4. [Tối Ưu 2D Spatial Focus (Tránh Kẹt Tiêu Điểm)](#4-tối-ưu-2d-spatial-focus)
5. [Quy Trình Triển Khai & Kiểm Thử Trong Antigravity IDE](#5-quy-trình-triển-khai--kiểm-thử)

---

## 1. Tổng Quan Kiến Trúc TV & Web Focus Engine

Hệ thống điều hướng mới thay thế toàn bộ mã nguồn Focus cũ bằng 2 thành phần cốt lõi:

```text
lib/core/focus/
├── tv_focus_engine.dart          # Quản lý Trục FocusScopeNode riêng cho Sidebar & Main Area
└── tv_focusable.dart             # Widget bọc nhận Remote TV, Bàn phím & Mouse Hover Web
```

### ✨ Tính năng nổi bật:
- **Tự động mở rộng Sidebar**: Khi bấm phím Trái `◀` từ card phim đầu tiên (hoặc rê chuột sang lề trái), tiêu điểm nhảy sang Sidebar và Sidebar tự mở rộng.
- **Di chuyển 2 chiều (2D Spatial)**: Bấm phím Xuống `▼` nhảy mượt giữa các hàng phim cuộn ngang.
- **Phản hồi trực quan (Visual Glow Feedback)**: Bật viền Neon Cyan `#00E5FF` + Phóng to `1.05x` mượt mà khi nhận Focus.
- **Không mất Focus Node**: Giữ vững tiêu điểm khi danh sách phim cuộn lên/xuống.

---

## 2. Chi Tiết Hai Chế Độ Hoạt Động

### A. Chế Độ Smart TV (Android TV / Apple TV / Google TV)
- **Mũi tên D-Pad (`Up / Down / Left / Right`)**: Nhảy tiêu điểm giữa các phần tử UI gần nhất theo hình học không gian 2D.
- **Phím Chọn / OK (`Select / Enter / Space / KeyCode 0x00070058`)**: Kích hoạt hành động bấm chọn mở phim/chuyển tập.
- **Phím Back (`Back / Escape / Return`)**: Thoát màn hình phát phim hoặc quay lại màn hình trước.

### B. Chế Độ Web & Desktop (Chrome / Safari / Firefox)
- **Phím Mũi tên bàn phím**: Dùng phím `ArrowUp`, `ArrowDown`, `ArrowLeft`, `ArrowRight`, `Tab`, `Shift+Tab`, `Enter`, `Space` để di chuyển và chọn phim.
- **Rê chuột (Mouse Hover)**: Rê chuột qua bất kỳ Card phim hay Nút bấm nào -> Tự động nhận Focus, **bật viền phát sáng Cyan Neon `#00E5FF`** và **phóng to 1.05x**.
- **Click chuột**: Mở phim hoặc chuyển tập mượt mà.

---

## 3. Quy Tắc Quản Lý Focus Scope

Để tránh hiện tượng kẹt Focus (Focus Trap), ứng dụng được phân chia thành 2 vùng Scope chính:

```text
┌─────────────────────────┬────────────────────────────────────────────────────────┐
│   Sidebar Focus Scope   │                  Main Area Focus Scope                 │
│                         │                                                        │
│  - Trang Chủ            │  - Banner Phim Hot (Hero Slider)                       │
│  - Danh Mục             │  - Hàng Phim 1: Phim Mới Cập Nhật                      │
│  - Tủ Phim               │  - Hàng Phim 2: Phim Lẻ Đặc Sắc                        │
│  - Tìm Kiếm             │  - Hàng Phim 3: Phim Bộ Nổi Bật                        │
└─────────────────────────┴────────────────────────────────────────────────────────┘
```

- **Từ Main Area sang Sidebar**: Khi tiêu điểm đang ở cột đầu tiên của hàng phim và bấm Trái `◀`, `TvFocusEngine` tự động chuyển Focus sang mục Menu đang chọn ở Sidebar.
- **Từ Sidebar sang Main Area**: Khi đang ở Sidebar và bấm Phải `▶` (hoặc rê chuột vào danh sách phim), Focus nhảy trở lại Card phim đầu tiên của nội dung chính.

---

## 4. Tối Ưu 2D Spatial Focus

1. **Sử dụng `ReadingOrderTraversalPolicy`**:
   - Thay thế hoàn toàn `WidgetOrderTraversalPolicy` cũ bằng `ReadingOrderTraversalPolicy` mở.
2. **Không chặn Focus Traversal Group**:
   - Loại bỏ các `FocusTraversalGroup` khép kín khiến phím bấm bị giữ lại trong danh sách cuộn ngang.
3. **Gọi cuộn màn hình an toàn (`PostFrameCallback`)**:
   - Việc tự động cuộn màn hình (`ensureVisible`) chỉ thực hiện sau khi khung hình render xong, không làm ngắt lệnh D-Pad Remote.

---

## 5. Quy Trình Triển Khai & Kiểm Thử Trong Antigravity IDE

Khi tiến hành viết lại mã nguồn, thực hiện kiểm thử theo các bước:

- [ ] **Bước 1**: Tạo `lib/core/focus/tv_focus_engine.dart` & `tv_focusable.dart`.
- [ ] **Bước 2**: Cập nhật `tv_sidebar_menu.dart` và `tv_sidebar_item.dart`.
- [ ] **Bước 3**: Cập nhật `focusable_movie_card.dart` & các nút bấm.
- [ ] **Bước 4**: Cập nhật `home_screen.dart` & `horizontal_movie_list.dart`.
- [ ] **Bước 5**: Chạy `flutter run -d chrome` để test bằng Bàn phím & Chuột trên Web.
- [ ] **Bước 6**: Build APK và test phím D-Pad Remote trên Android TV.

---

> 💡 **Tài liệu hướng dẫn điều hướng TV & Web đã sẵn sàng trong thư mục dự án của bạn!**
