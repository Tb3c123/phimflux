# 🎮 Hướng Dẫn Điều Hướng TV Tile-to-Tile & Web - PhimFlux

> **Tài liệu hướng dẫn kiến trúc di chuyển Tile-to-Tile chuẩn Smart TV**  
> *Phiên bản: 2.0.0 | Ngày cập nhật: 12/08/2026*  
> *Mục đích: Hướng dẫn chi tiết cơ chế di chuyển mượt giữa các Tile components (Searchbar, Banner, Card phim), tự nhảy sang Sidebar khi bấm sát lề trái, và di chuyển Lên/Xuống chọn từng mục Menu Sidebar.*

---

## 📑 Sơ Đồ Quy Trình Di Chuyển (Tile Navigation UX Flow)

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

---

## 1. Các Quy Tắc Di Chuyển Cốt Lõi

1. **Di chuyển mượt dứt khoát giữa các Tile Components**:
   - Mũi tên Lên `▲` / Xuống `▼` / Trái `◀` / Phải `▶` nhảy dứt điểm từng phần tử: Ô tìm kiếm (`SearchBar`), Banner Phim (`Hero Banner`), Card Phim (`Movie Tiles`), Tập phim (`Episode Tiles`).
2. **Kích hoạt Chi Tiết khi Bấm Chọn**:
   - Nhấn `OK` / `Enter` / `Select` trên bất kỳ `Movie Tile` nào -> Lập tức mở màn hình Chi Tiết Phim (`DetailScreen`).
3. **Nhảy sang Sidebar khi chạm sát lề trái (Left Edge Escape)**:
   - Khi đang ở phần tử đầu tiên (Index 0) của bất kỳ hàng phim nào, bấm phím Trái `◀` -> Tiêu điểm lập tức nhảy sang mục Menu tương ứng trong **TV Sidebar**.
4. **Di chuyển Lên/Xuống trong Sidebar**:
   - Khi đang ở trong TV Sidebar, bấm Lên `▲` / Xuống `▼` để lựa chọn từng mục (`Trang Chủ`, `Danh Mục`, `Tủ Phim`, `Tìm Kiếm`).
   - Bấm Phải `▶` -> Nhảy trở lại khu vực Tile chính.

---

## 2. Kiến Trúc Core `TvFocusEngine`

```text
lib/core/focus/
├── tv_focus_engine.dart          # Điều phối FocusScope cho Sidebar & Main Content Area
└── tv_focusable.dart             # Widget bọc Tile Component phản hồi Remote TV & Web
```

### ✨ Chi Tiết Xử Lý Kỹ Thuật:
- `SidebarFocusScope`: Quản lý 4 FocusNode tương ứng với 4 mục Menu Sidebar.
- `MainContentFocusScope`: Quản lý FocusNode của SearchBar, Hero Banner và các Card phim.
- `addPostFrameCallback`: Tự động cuộn màn hình đưa Tile đang chọn vào giữa tầm mắt (`alignment: 0.5`) mượt mà không gây lag hay nảy tiêu điểm.

---

## 3. Quy Trình Kiểm Thử Nghiệm Thu Trên Web & Android TV

Lệnh chạy kiểm thử trên Web Chrome:
```bash
flutter run -d chrome
```

- [ ] **Test di chuyển Tile**: Dùng phím Mũi tên di chuyển từ `SearchBar` -> `Hero Banner` -> `Card Phim`. Viền Cyan phát sáng `#00E5FF` và Tile nhảy mượt.
- [ ] **Test mở Chi Tiết Phim**: Bấm `Enter` / `OK` trên Card phim -> Mở màn hình Chi Tiết Phim.
- [ ] **Test nhảy lề trái sang Sidebar**: Tại Card phim đầu tiên (Index 0), bấm Trái `◀` -> Focus nhảy ngay sang Sidebar.
- [ ] **Test di chuyển trong Sidebar**: Bấm Lên `▲` / Xuống `▼` chọn các mục Menu Sidebar. Bấm Phải `▶` nhảy trở lại danh sách phim.
