# MyPortfolio Mobile 📱

Aplikasi mobile berbasis Flutter untuk portofolio pribadi Khayla Syafira Ardiasih (NPM: 2506656910 / PBP A).

## 🛠️ Setup & Cara Menjalankan

1. Pasang dependensi: flutter pub get
2. Jalankan aplikasi: flutter run

### Tugas 7

1. Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!

Widget tree adalah struktur hierarki pohon yang merepresentasikan seluruh elemen antarmuka (UI) di Flutter. Hubungan induk-anak (parent-child) bekerja dengan prinsip delegasi:
- Parent (induk) menentukan batasan ruang (constraints), posisi, dan tata letak bagi anaknya.
- Child (anak) menentukan ukuran konkret berdasarkan batasan dari parent dan merender tampilannya.
- Data atau konfigurasi mengalir ke bawah dari parent ke child, sedangkan aksi/event diteruskan ke atas melalui callback.

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!

- MaterialApp: Root widget yang mengatur konfigurasi tema global dan navigasi dasar aplikasi.
- Scaffold: Kerangka dasar halaman Material Design (menyediakan AppBar dan body).
- AppBar: Header navigasi di bagian atas halaman untuk menampilkan judul.
- SingleChildScrollView: Memungkinkan seluruh konten halaman dapat digulir jika melebihi ukuran layar.
- Padding: Memberikan jarak ruang kosong di sekeliling widget anaknya.
- Column: Menyusun widget anak secara vertikal dari atas ke bawah.
- Row: Menyusun widget anak secara horizontal sejajar.
- Card: Wadah dengan sudut melengkung dan elevasi ringan untuk kartu identitas (InfoCard).
- Container: Mengatur dimensi lebar, padding, dan tata letak konten kartu.
- Text: Menampilkan teks dengan gaya tipografi tertentu.
- GridView.count: Menyusun tombol-tombol menu dalam format kisi 3 kolom.
- Material: Memberikan warna latar dan sudut melengkung pada kartu tombol.
- Icon: Menampilkan simbol visual dari pustaka Material Icons.
- SizedBox: Memberikan jarak kosong vertikal atau horizontal antar-elemen.
- Center: Menempatkan widget anak tepat di tengah area yang tersedia.
- SnackBar: Menampilkan notifikasi pop-up singkat di bagian bawah layar saat tombol ditekan.
- GestureDetector: Mendeteksi interaksi sentuhan layar (tekan, lepas, batal).
- AnimatedScale: Memberikan animasi perubahan ukuran (pulse) saat tombol disentuh.

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!

`MaterialApp` berfungsi menginisialisasi tema Material Design, sistem navigasi (routing), serta context global seperti `Theme`, `MediaQuery`, dan `ScaffoldMessenger`. Widget ini wajib menjadi root widget karena seluruh komponen Material di bawahnya (seperti `Scaffold`, `Card`, dan `SnackBar`) memerlukan konfigurasi dan data context yang hanya disediakan oleh `MaterialApp`.

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?

- StatelessWidget: Bersifat statis dan tidak memiliki state internal yang dapat bermutasi setelah dibangun. Hanya me-rebuild jika parameter dari parent-nya berubah. Digunakan untuk UI yang hanya menampilkan data tetap (contoh: `MyHomePage`, `InfoCard`).
- StatefulWidget: Memiliki objek `State` yang dapat berubah selama aplikasi berjalan dan memicu render ulang mandiri via `setState()`. Digunakan ketika ada interaksi dinamis atau animasi lokal (contoh: `PulseItemCard` untuk melacak status sentuhan).

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?

`BuildContext` adalah objek penanda referensi posisi spesifik suatu widget di dalam hierarki widget tree. Pada metode `build(BuildContext context)`, context digunakan untuk berinteraksi dan mengambil data dari widget leluhur, seperti mengakses skema warna (`Theme.of(context)`), membaca dimensi layar (`MediaQuery.of(context)`), atau menampilkan notifikasi (`ScaffoldMessenger.of(context)`).

6. Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?

- Hot Reload: Menginjeksi perubahan kode langsung ke Dart VM yang sedang berjalan dan me-rebuild UI dengan tetap mempertahankan state aplikasi (< 1 detik).
- Hot Restart: Memuat ulang aplikasi dari fungsi `main()` dan mereset seluruh state kembali ke kondisi awal.
- Kondisi wajib Hot Restart atau Full Restart:
  - Mengubah struktur fungsi `main()` atau konfigurasi awal aplikasi.
  - Mengubah tipe widget dari Stateless ke Stateful (atau sebaliknya).
  - Mengubah metode `initState()`.
  - Menambahkan dependensi baru pada `pubspec.yaml` atau aset baru (memerlukan Full Restart).

## AI Disclosure & Analisis Kritis Keterbatasan AI

Dalam pengerjaan Tugas 7 ini, saya menggunakan AI sebagai mitra diskusi teknis untuk memahami hierarki widget tree Flutter, menyusun pemisahan komponen modular (`InfoCard` dan `ItemCard`), serta merancang animasi interaksi tombol.

Tools yang Digunakan: ChatGPT

Bagian yang Dibantu AI:

1. Memberikan referensi struktur layout kombinasi `SingleChildScrollView`, `Column`, `Row`, dan `GridView.count`.
2. Memberikan kerangka dasar widget animasi `AnimatedScale` untuk efek sentuhan tombol.

Analisis Kritis Keterbatasan AI & Perbaikan Manual:

1. Kesalahan Pemilihan Tipe Widget Halaman Utama (Stateless vs Stateful):
   AI awalnya membuat `MyHomePage` sebagai `StatefulWidget`. Saya mengoreksinya menjadi `StatelessWidget` sesuai instruksi tugas, lalu mengisolasi state animasi khusus di dalam komponen kartu (`PulseItemCard`) agar efisien dan tidak me-rebuild seluruh halaman.
2. Hardcoding Logika Pewarnaan Tombol (Code Smell):
   AI sempat menyarankan percabangan `if-else` di dalam widget untuk membedakan warna tombol. Saya memperbaikinya dengan menambahkan atribut `final Color color` langsung pada model `ItemHomepage` agar pewarnaan bersifat deklaratif dan modular.
3. Inkonsistensi Palet Warna Tema (Design Alignment):
   AI menyarankan warna standar (`Colors.blue`, `Colors.red`) yang tidak sesuai dengan tema web portofolio. Saya memperbaikinya dengan menerapkan kode heksadesimal palet Pink Espresso (`#392529`, `#855B60`, `#D9A6A8`) agar visual konsisten.
4. Penumpukan Antrean Notifikasi SnackBar (UX Issue):
   AI hanya memanggil `showSnackBar()` tanpa membersihkan antrean sebelumnya sehingga pesan menumpuk saat tombol ditekan cepat. Saya menambahkan `..hideCurrentSnackBar()` agar umpan balik langsung berganti seketika.
5. Risiko Overflow Layout pada Layar Kecil (Responsive Constraint):
   AI awalnya menggunakan ukuran pixel statis pada `InfoCard`. Saya menggantinya dengan kalkulasi dinamis `MediaQuery.of(context).size.width / 3.5` agar layout kartu proporsional dan bebas dari render overflow.