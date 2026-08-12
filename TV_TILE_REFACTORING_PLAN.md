# Kế Hoạch Tái Cấu Trúc: Hệ Thống Di Chuyển Tile-to-Tile Chuẩn Smart TV

Dựa trên phản hồi chạy thực tế, ứng dụng hiện tại đang gặp hiện tượng cuộn trang thay vì di chuyển dứt khoát mượt mà giữa các phần tử (Tile Components).

Kế hoạch này xây dựng lại **Hệ thống di chuyển Tile-to-Tile deterministic (xác định chuẩn xác)** cho Smart TV Remote (D-Pad) và Web/Desktop Keyboard.

---

## 1. Yêu Cầu Chức Năng Di Chuyển Chuẩn Smart TV (UX Flow)

```text
 ┌─────────────────────────┐               ┌────────────────────────────────────────────────────────┐
 │   SIDEBAR NAVIGATION    │               │                 MAIN CONTENT TILE AREA                 │
 │                         │   Right (▶)   │                                                        │
 │ 0. [Trang Chủ]          ├──────────────►│ [Search Bar (Ô Tìm Kiếm)]                              │
 │ 1. [Danh Mục]           │               │   ▲ Up / Down ▼                                        │
 │ 2. [Tủ Phim]            │◄──────────────┤ [Hero Banner Movie Tile] (Nút Play / Info)             │
 │ 3. [Tìm Kiếm]           │   Left (◀)    │   ▲ Up / Down ▼                                        │
 │                         │ (từ tile #0)  │ [Row 1: Phim Mới] [Tile 0] [Tile 1] [Tile 2] ...       │
 │ Up (▲) / Down (▼)       │               │   ▲ Up / Down ▼                                        │
 │ Lựa chọn từng mục Menu  │               │ [Row 2: Phim Lẻ]  [Tile 0] [Tile 1] [Tile 2] ...       │
 └─────────────────────────┘               └────────────────────────────────────────────────────────┘
```

1. **Di chuyển mượt giữa các Tile Components**:
   - Mũi tên Lên `▲` / Xuống `▼` / Trái `◀` / Phải `▶` nhảy dứt điểm từng phần tử: Ô tìm kiếm (`SearchBar`), Banner Phim (`Hero Tile`), Card Phim (`Movie Tiles`), Tập phim (`Episode Tiles`).
2. **Kích hoạt Chi Tiết khi Bấm Chọn**:
   - Khi đang ở bất kỳ `Movie Tile` nào, bấm `OK` / `Enter` / `Select` -> Lập tức mở màn hình Chi Tiết Phim.
3. **Nhảy sang Sidebar khi chạm sát lề trái (Left Edge Escape)**:
   - Khi đang ở phần tử đầu tiên (Index 0) của bất kỳ hàng phim hoặc header nào, bấm phím Trái `◀` -> Tiêu điểm lập tức nhảy sang mục Menu tương ứng trong **TV Sidebar**.
4. **Di chuyển Lên/Xuống trong Sidebar**:
   - Khi đang ở trong TV Sidebar, bấm Lên `▲` / Xuống `▼` để lựa chọn từng mục (`Trang Chủ`, `Danh Mục`, `Tủ Phim`, `Tìm Kiếm`). Bấm Phải `▶` -> Nhảy trở lại khu vực Tile chính.

---

## 2. Giải Pháp Kỹ Thuật (Architecture & Components)

### A. Core Focus Engine (`lib/core/focus/tv_focus_engine.dart`)
- **Tách riêng 2 FocusScopeNode**:
  - `sidebarFocusScope`: Quản lý 4 FocusNode tương ứng với 4 mục Menu Sidebar.
  - `mainContentFocusScope`: Quản lý FocusNode của SearchBar, Hero Banner và các Card phim.
- **Bắt phím Trái `◀` ở lề trái (Left Edge Intercept)**:
  - Khi phím `LogicalKeyboardKey.arrowLeft` được bấm ở tile index 0, `TvFocusEngine` chặn sự kiện và gọi `sidebarFocusScope.requestFocus()`.
- **Bắt phím Phải `▶` từ Sidebar**:
  - Khi đang ở Sidebar và bấm `LogicalKeyboardKey.arrowRight`, gọi `mainContentFocusScope.requestFocus()`.

### B. Cuộn Màn Hình Tự Động An Toàn (`lib/core/focus/tv_focusable.dart`)
- Xóa bỏ việc cuộn đồng bộ trong `onFocusChange`.
- Sử dụng `WidgetsBinding.instance.addPostFrameCallback` để gọi `Scrollable.ensureVisible(context, alignment: 0.5)` sau khi layout đã ổn định, đảm bảo màn hình tự động đưa Tile đang chọn vào giữa tầm mắt mà không gây lag hay nảy tiêu điểm.

---

## 3. Các Mô-Đun Sẽ Được Thay Thế & Cập Nhật

---

### [Component 1] Focus Core & Traversal Engine

#### [NEW] [tv_focus_engine.dart](file:///Users/tb3c/watch_movies/lib/core/focus/tv_focus_engine.dart)
Hệ thống điều phối FocusScope cho Sidebar và Main Content, xử lý sự kiện nảy Focus qua lại giữa lề trái và Sidebar.

#### [MODIFY] [tv_focusable.dart](file:///Users/tb3c/watch_movies/lib/core/focus/tv_focusable.dart)
Tối ưu Widget bọc Focus để phản hồi tức thì phím bấm D-Pad Remote TV, Bàn phím & Rê chuột Hover Web, tự động cuộn giữa màn hình (Center Alignment).

---

### [Component 2] TV Sidebar Menu & Items

#### [MODIFY] [tv_sidebar_menu.dart](file:///Users/tb3c/watch_movies/lib/ui/components/sidebar/tv_sidebar_menu.dart)
Gán `FocusScope` riêng cho 4 mục Sidebar (`Trang Chủ`, `Danh Mục`, `Tủ Phim`, `Tìm Kiếm`). Phím Lên `▲` / Xuống `▼` chuyển đổi qua lại giữa 4 mục này. Phím Phải `▶` nhảy ra vùng Tile chính.

#### [MODIFY] [tv_sidebar_item.dart](file:///Users/tb3c/watch_movies/lib/ui/components/sidebar/tv_sidebar_item.dart)
Hiển thị viền Cyan phát sáng `#00E5FF` và phóng to nhẹ khi mục Menu Sidebar nhận Focus.

---

### [Component 3] Main Screen Layout & Navigation Frame

#### [MODIFY] [main.dart](file:///Users/tb3c/watch_movies/lib/main.dart)
Kết nối `tv_focus_engine.dart` vào khung điều hướng chính, xử lý chuyển đổi giữa Sidebar và Main Area.

#### [MODIFY] [home_screen.dart](file:///Users/tb3c/watch_movies/lib/ui/features/home/home_screen.dart)
Xếp chồng hợp lý các Tile section (`SearchBar` -> `HeroBanner` -> `Phim Mới` -> `Phim Lẻ` -> `Phim Bộ`) hỗ trợ di chuyển Lên `▲` / Xuống `▼` dứt khoát.

#### [MODIFY] [horizontal_movie_list.dart](file:///Users/tb3c/watch_movies/lib/ui/features/home/widgets/horizontal_movie_list.dart)
Cấu hình bắt phím Trái `◀` ở Card phim index 0 để nhảy sang Sidebar.

#### [MODIFY] [focusable_movie_card.dart](file:///Users/tb3c/watch_movies/lib/ui/core_widgets/cards/focusable_movie_card.dart)
Đảm bảo khi bấm `OK` / `Enter` trên Card phim thì kích hoạt callback `onTap()` mở ngay màn hình Chi Tiết Phim.

---

## 4. Kế Hoạch Kiểm Thử Nghiệm Thu (Verification Plan)

### Kiểm Thử Thủ Công Trên Web (`flutter run -d chrome`) & Android TV:
1. **Test di chuyển giữa các Tile**: Dùng phím Mũi tên bàn phím (`Up/Down/Left/Right`) di chuyển từ `SearchBar` -> `Hero Banner` -> `Card Phim`. Đảm bảo viền Cyan phát sáng `#00E5FF` và Tile được nhảy mượt mà.
2. **Test bấm chọn xem Chi Tiết**: Bấm `Enter` / `OK` trên Card phim -> Mởi màn hình Chi Tiết Phim (`DetailScreen`).
3. **Test nhảy sát lề trái sang Sidebar**: Đang ở Card phim đầu tiên (Tile index 0), bấm phím Trái `◀` -> Tiêu điểm nhảy ngay sang Sidebar.
4. **Test di chuyển trong Sidebar**: Đang ở trong Sidebar, bấm Lên `▲` / Xuống `▼` -> Chọn qua lại giữa `Trang Chủ`, `Danh Mục`, `Tủ Phim`, `Tìm Kiếm`. Bấm Phải `▶` -> Nhảy về lại danh sách phim.
