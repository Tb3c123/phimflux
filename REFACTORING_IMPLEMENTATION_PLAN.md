# 🛠️ Kế Hoạch Triển Khai Code Mới (Refactoring & Implementation Plan) - PhimFlux

> **Tài liệu chi tiết kế hoạch làm sạch mã nguồn cũ và triển khai hệ thống TV/Web Focus Engine mới**  
> *Phiên bản: 1.0.0 | Ngày khởi tạo: 12/08/2026*  
> *Mục đích: Định hình lộ trình từng giai đoạn dọn dẹp mã nguồn bị lỗi di chuyển và tái cấu trúc 100% hệ thống điều hướng trên Smart TV và Web.*

---

## 📑 Mục Lục
1. [Mục Tiêu & Phạm Vi Tái Cấu Trúc (Scope & Objectives)](#1-mục-tiêu--phạm-vi-tái-cấu-trúc)
2. [Các Giai Đoạn Triển Khai Code Mới (Implementation Phases)](#2-các-giai-đoạn-triển-khai-code-mới)
3. [Chi Tiết Các File Sẽ Được Tạo Mới & Thay Thế](#3-chi-tiết-các-file-sẽ-được-tạo-mới--thay-thế)
4. [Tiêu Chuẩn Nghiệm Thu Theo Từng Giai Đoạn](#4-tiêu-chuẩn-nghiệm-thu-theo-từng-giai-đoạn)

---

## 1. Mục Tiêu & Phạm Vi Tái Cấu Trúc

### 🎯 Mục tiêu:
1. **Xóa sạch mã nguồn Focus cũ**: Hủy bỏ hoàn toàn các file `tv_focusable_wrapper.dart`, `focus_scale_wrapper.dart`, `neon_glow_border.dart` cũ gây kẹt phím.
2. **Xây dựng `TvFocusEngine` Core**: Quản lý `FocusScopeNode` riêng biệt giữa Sidebar và Main Area.
3. **Hỗ trợ Đa Nền Tảng (Hybrid Focus)**:
   - Phím Remote TV D-Pad (`Up/Down/Left/Right/OK/Back`).
   - Phím Mũi tên bàn phím Web (`ArrowUp/Down/Left/Right/Enter/Space`).
   - **Rê chuột (Mouse Hover)** trên Web tự động phát sáng Cyan Neon `#00E5FF` và phóng to `1.05x`.

---

## 2. Các Giai Đoạn Triển Khai Code Mới

```text
 ┌─────────────────────────────────────────────────────────┐
 │ GIAI ĐOẠN 1: Tạo Core TvFocusEngine & TvFocusable mới   │
 └────────────────────────────┬────────────────────────────┘
                              │
                              ▼
 ┌─────────────────────────────────────────────────────────┐
 │ GIAI ĐOẠN 2: Tái cấu trúc Menu Sidebar & Header Layout  │
 └────────────────────────────┬────────────────────────────┘
                              │
                              ▼
 ┌─────────────────────────────────────────────────────────┐
 │ GIAI ĐOẠN 3: Cập nhật Card Phim & Nút Bấm Nguyên Tử     │
 └────────────────────────────┬────────────────────────────┘
                              │
                              ▼
 ┌─────────────────────────────────────────────────────────┐
 │ GIAI ĐOẠN 4: Tái cấu trúc Màn Hình Trang Chủ & Hàng Phim│
 └────────────────────────────┬────────────────────────────┘
                              │
                              ▼
 ┌─────────────────────────────────────────────────────────┐
 │ GIAI ĐOẠN 5: Cập nhật Màn Hình Danh Mục, Chi Tiết & Player│
 └────────────────────────────┬────────────────────────────┘
                              │
                              ▼
 ┌─────────────────────────────────────────────────────────┐
 │ GIAI ĐOẠN 6: Kết nối main.dart & Kiểm thử Web / TV APK  │
 └─────────────────────────────────────────────────────────┘
```

---

## 3. Chi Tiết Các File Sẽ Được Tạo Mới & Thay Thế

### 🔹 Giai Đoạn 1: Tầng Core Focus Mới (`lib/core/focus/`)
- `[NEW] lib/core/focus/tv_focus_engine.dart` (~60 dòng):  
  Quản lý chuyển Focus giữa `SidebarFocusScope` và `MainAreaFocusScope`.
- `[NEW] lib/core/focus/tv_focusable.dart` (~80 dòng):  
  Widget bọc tích hợp cả D-Pad Remote TV, Bàn phím Mũi tên Web và Rê chuột Hover.

---

### 🔹 Giai Đoạn 2: Tầng Bố Cục Điều Hướng (`lib/ui/components/`)
- `[MODIFY] lib/ui/components/sidebar/tv_sidebar_item.dart` (~35 dòng):  
  Cập nhật nhận Focus mượt từ Bàn phím, Remote TV & Mouse Hover.
- `[MODIFY] lib/ui/components/sidebar/tv_sidebar_menu.dart` (~70 dòng):  
  Tối ưu tự mở rộng khi Hover/Focus lề trái, tự động chuyển focus về lại nội dung phim khi bấm Phải `▶`.

---

### 🔹 Giai Đoạn 3: Tầng Micro-Widgets Nguyên Tử (`lib/ui/core_widgets/`)
- `[MODIFY] lib/ui/core_widgets/cards/focusable_movie_card.dart` (~60 dòng):  
  Bọc bằng `TvFocusable` mới, hiển thị viền phát sáng Cyan Neon `#00E5FF` & Zoom `1.05x`.
- `[MODIFY] lib/ui/core_widgets/buttons/primary_play_button.dart` (~40 dòng):  
  Nút "Xem Ngay" nhận Focus mặc định ở màn hình Chi Tiết Phim.
- `[MODIFY] lib/ui/core_widgets/buttons/secondary_action_button.dart` (~40 dòng).

---

### 🔹 Giai Đoạn 4: Tầng Màn Hình Trang Chủ (`lib/ui/features/home/`)
- `[MODIFY] lib/ui/features/home/widgets/horizontal_movie_list.dart` (~60 dòng):  
  Cấu hình `ReadingOrderTraversalPolicy` 2D Spatial. Phim đầu tiên của hàng khi bấm Trái `◀` sẽ nhảy sang Sidebar.
- `[MODIFY] lib/ui/features/home/home_screen.dart` (~85 dòng):  
  Bố cục cuộn dọc mượt mà, chuyển Focus từ Banner xuống các hàng phim không bị nghẽn.

---

### 🔹 Giai Đoạn 5: Tầng Màn Hình Danh Mục, Chi Tiết & Xem Phim
- `[MODIFY] lib/ui/features/catalog/catalog_screen.dart` & `movie_grid_view.dart` (~65 dòng):  
  Điều hướng D-Pad lưới 4 cột.
- `[MODIFY] lib/ui/features/detail/detail_screen.dart` & `episode_button.dart` (~45 dòng):  
  Nút số tập phim nhảy tiêu điểm 2 chiều.
- `[MODIFY] lib/ui/features/player/widgets/player_control_buttons.dart` (~60 dòng):  
  Điều khiển OSD phát phim.

---

### 🔹 Giai Đoạn 6: Tầng Khởi chạy Main App (`lib/main.dart`)
- `[MODIFY] lib/main.dart` (~75 dòng):  
  Kết nối `SidebarFocusScope` và `MainAreaFocusScope` thông qua `TvFocusEngine`.

---

## 4. Tiêu Chuẩn Nghiệm Thu Theo Từng Giai Đoạn

| Giai Đoạn | Thao Tác Kiểm Thử | Tiêu Chuẩn Đạt |
| :--- | :--- | :--- |
| **Giai đoạn 1** | Widget Test `tv_focusable_test.dart` | Trả về đúng viền Cyan `#00E5FF` và Zoom `1.05x` khi focus. |
| **Giai đoạn 2** | Test Sidebar trên Web | Rê chuột hoặc bấm Trái `◀` -> Sidebar phát sáng & tự mở rộng. |
| **Giai đoạn 3** | Test Card phim trên Web | Hover chuột qua bất kỳ card nào -> Tự động phát sáng viền Cyan. |
| **Giai đoạn 4** | Test Trang chủ (`flutter run -d chrome`) | Dùng phím Mũi tên di chuyển mượt Lên/Xuống/Trái/Phải giữa các hàng phim. |
| **Giai đoạn 5** | Test Màn hình Chi tiết & Chọn tập | Focus mặc định vào "XEM TẬP 1", di chuyển D-Pad qua từng tập phim mượt. |
| **Giai đoạn 6** | Build APK & Test Android TV real device | Cài APK lên TV, dùng Remote TV điều khiển hoàn toàn mượt mà 100%. |

---

> 💡 **Kế hoạch triển khai code mới đã sẵn sàng để bạn review và duyệt trong Antigravity IDE!**
