# 🎨 Bộ Mockup Giao Diện Mẫu (UI Mockups) - PhimFlux

> **Tài liệu hình ảnh thiết kế nằm trực tiếp trong dự án**  
> *Mục đích: Hiển thị bộ giao diện mẫu trực quan cho ứng dụng xem phim PhimFlux trên Smart TV (Android TV / Apple TV) và Mobile (Android / iOS).*

---

## 1. Giao Diện Trang Chủ Smart TV (TV Home View)

![Trang Chủ Smart TV](file:///Users/tb3c/watch_movies/docs/images/tv_home_mockup_1786414642552.jpg)

### Điểm nổi bật về UX/UI:
- **Thanh Menu Dọc Bên Trái (TV Sidebar)**: Gồm các icon Home, Phim Lẻ, Phim Bộ, Tìm Kiếm, Tủ Phim. Khi cuộn Remote sang lề trái, thanh sidebar sẽ tự mở rộng.
- **Banner Phim Hot (Hero Slider)**: Hiển thị tên phim lớn, điểm IMDb, thẻ chất lượng (4K HDR, Vietsub), nút "Play Now" và "Info".
- **Hiệu ứng Focus Remote TV (Cyan Glow Border)**: Thể hiện rõ phần tử được Remote chỉ vào với viền phát sáng màu xanh Cyan neon (`#00E5FF`) và hiệu ứng Zoom nhẹ (1.05x).

---

## 2. Giao Diện Chi Tiết Phim Smart TV (TV Movie Detail View)

![Chi Tiết Phim Smart TV](file:///Users/tb3c/watch_movies/docs/images/tv_detail_mockup_1786414662177.jpg)

### Điểm nổi bật về UX/UI:
- **Background Poster Mờ (Cinematic Backdrop)**: Tự động tải ảnh poster phim làm hình nền mờ toàn màn hình.
- **Thông tin Phim**: Tên gốc, Tên tiếng Việt, Đạo diễn, Diễn viên, Tóm tắt nội dung ngắn gọn.
- **Nút "Xem Tập 1" Nổi Bật**: Đặt ở vị trí nhận Focus mặc định khi mở màn hình (`autofocus: true`).
- **Lưới Tập Phim & Tab Server**: Cho phép người dùng chuyển nhanh giữa Server Vietsub và Server Thuyết Minh, bấm chuyển tập bằng D-Pad Remote.

---

## 3. Giao Diện Trình Phát Video (TV Player OSD View)

![Màn Hình Phát Video](file:///Users/tb3c/watch_movies/docs/images/tv_player_mockup_1786414676180.jpg)

### Điểm nổi bật về UX/UI:
- **Khung Điều Khiển OSD (On-Screen Display)**: Ẩn tự động sau 3 giây khi phim bắt đầu chạy.
- **Thanh Thời Gian Timeline**: Thanh kéo màu xanh Cyan hiển thị thời gian đã xem và tổng thời lượng.
- **Các Nút Thao Tác Remote**: Play/Pause, Tua lùi 10s, Tua tới 10s, Đổi Server phát nhanh và Chọn phụ đề/âm thanh.

---

## 4. Giao Diện Mobile (Android / iOS)

![Giao Diện Mobile](file:///Users/tb3c/watch_movies/docs/images/mobile_home_mockup_1786414692291.jpg)

### Điểm nổi bật về UX/UI:
- **Thiết kế Chuẩn Mobile**: Thanh điều hướng dưới cùng (Bottom Navigation) có hiệu ứng kính mờ Glassmorphism.
- **Tối Ưu Vuốt Chạm (Touch Gestures)**: Banner slider ở trên cùng cuộn bằng tay mượt mà, danh sách phim dạng hàng ngang dễ thao tác bằng 1 tay.
