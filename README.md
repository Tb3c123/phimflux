# 🎬 PhimFlux - Ứng Dụng Xem Phim Đa Nền Tảng (Android, Android TV & Web)

**PhimFlux** là ứng dụng xem phim trực tuyến hiện đại, mượt mà và tối ưu hóa trải nghiệm người dùng trên cả **Điện thoại Android**, **Smart TV / Android TV (Remote D-Pad)** và **Trình duyệt Web**. Ứng dụng được xây dựng theo kiến trúc Micro-Modular chuẩn mực với tông màu Dark Mode sang trọng, hiệu ứng Neon Cyan ấn tượng và tích hợp API NguonC kết hợp OMDb Metadata.

---

## ✨ Tính Năng Nổi Bật

* **📺 Hỗ Trợ Android TV & Smart TV**: Điều hướng thông minh bằng D-Pad Remote (lên/xuống/trái/phải/enter), tự động nhận diện thiết bị TV với dải viền phát sáng Neon Cyan rực rỡ.
* **🎞️ Banner Carousel Slider Tự Động**: Banner chính khổng lồ 520px hiển thị danh sách phim ngẫu nhiên trượt tự động mỗi 5 giây, kèm dải chấm vị trí phát sáng.
* **🚫 Thuật Toán 0% Trùng Lặp Phim**: Tự động lọc và khử trùng lặp phim giữa Banner và các danh mục trên trang chủ.
* **🏷️ Tích Hợp OMDb API Metadata**: Hiển thị điểm số **⭐ IMDb Gold** chính xác và các thẻ Chip thể loại phim quốc tế (Action, Sci-Fi, Adventure, Comedy...).
* **🎬 Đề Xuất Phim Thông Minh**: Tự động hiển thị dải cuộn **Phim Cùng Thể Loại** ở cuối trang Chi Tiết dựa trên phân tích thể loại OMDb.
* **📽️ Trình Phát Phim Đa Nền Tảng**: Tích hợp Native Video Player & Iframe Web embed phát phim mượt mà không bị chặn pointer.
* **🔍 Tìm Kiếm Tức Thì**: Khung tìm kiếm tích hợp ngay góc màn hình, tự động kết nối và hiển thị kết quả chính xác khi ấn Enter.
* **📌 Tủ Phim & Lịch Sử Xem**: Lưu trữ phim yêu thích và tự động ghi nhớ lịch sử tập phim đang xem dở.
* **⚙️ GitHub Actions CI/CD**: Tự động hóa 100% quy trình biên dịch file `.apk` phát hành cho Android & Android TV trên Cloud.

---

## 🛠️ Công Nghệ Sử Dụng

* **Framework**: Flutter 3.22+ (Dart 3.8)
* **State Management**: Provider
* **Data Sources**: NguonC REST API & OMDb API
* **Web Integration**: `dart:ui_web` & `pointer_interceptor`
* **CI/CD**: GitHub Actions (Ubuntu Runner with Java 17 & Flutter)

---

## 📁 Cấu Trúc Dự Án (Micro-Modular Architecture)

```text
watch_movies/
├── .github/workflows/      # Cấu hình GitHub Actions tự động build APK
│   └── build_apk.yml
├── docs/                   # Tài liệu chi tiết phát triển & thiết kế
│   ├── DEVELOPMENT_GUIDE.md
│   ├── DEVELOPMENT_STEPS.md
│   ├── TESTING_GUIDE.md
│   └── ui_mockups.md
├── lib/
│   ├── core/               # Theme tokens, Player wrappers, State Providers
│   ├── data/               # Models (Movie, Episode), API Services, OMDb Service
│   ├── ui/                 # UI components, Core focus widgets, Feature screens
│   └── main.dart           # App entrypoint & Main Navigation Frame
└── pubspec.yaml            # Project dependencies & assets configuration
```

---

## 🚀 Hướng Dẫn Chạy Dự Án

### 1. Chạy Bản Web (Local Web Server)
```bash
flutter pub get
flutter run -d web-server --web-port=8080 --web-hostname=localhost
```
Mở trình duyệt truy cập: **`http://localhost:8080`**

### 2. Chạy Bản Mobile / TV (Local Device)
```bash
flutter run -d android
```

### 3. Tải File APK (Build Tự Động Qua GitHub Actions)
Truy cập thẻ **Actions** của repository:  
👉 **[GitHub Actions Releases / Artifacts](https://github.com/Tb3c123/phimflux/actions)**  
Tải file **`PhimFlux-Android-TV-Release-APK`** cài đặt cho Điện thoại Android và Smart TV.

---

## 📚 Tài Liệu Chi Tiết

* 📖 [Hướng Dẫn Phát Triển (DEVELOPMENT_GUIDE.md)](file:///Users/tb3c/watch_movies/docs/DEVELOPMENT_GUIDE.md)
* 🗺️ [Lộ Trình Các Bước Thực Hiện (DEVELOPMENT_STEPS.md)](file:///Users/tb3c/watch_movies/docs/DEVELOPMENT_STEPS.md)
* 🧪 [Hướng Dẫn Kiểm Thử (TESTING_GUIDE.md)](file:///Users/tb3c/watch_movies/docs/TESTING_GUIDE.md)
* 🎨 [Mô Hình Giao Diện (ui_mockups.md)](file:///Users/tb3c/watch_movies/docs/ui_mockups.md)

---

Developed with ❤️ for PhimFlux.
