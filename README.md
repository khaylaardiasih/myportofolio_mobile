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

### Tugas 8

1. Jelaskan perbedaan antara Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop(). Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.

Perbedaan ketiganya terletak pada bagaimana Flutter mengelola tumpukan halaman (navigation stack):
 `Navigator.push()`: Menambahkan halaman baru ke tumpukan paling atas tanpa menghapus halaman sebelumnya. Halaman lama tetap tersimpan di bawahnya, sehingga pengguna bisa kembali ke halaman lama menggunakan tombol back sistem atau panah di AppBar.
 `Navigator.pushReplacement()`: Mengganti halaman aktif saat ini dengan halaman baru. Halaman sebelumnya langsung ditutup dan dihapus dari memori, sehingga pengguna tidak bisa kembali ke halaman lama tersebut dengan tombol back.
 `Navigator.pop()`: Mengeluarkan atau membuang halaman paling atas dari tumpukan, sehingga layar kembali menampilkan halaman yang berada tepat di bawahnya (biasanya dipakai untuk menutup dialog atau kembali dari layar saat ini).

Metode yang digunakan untuk membuka formulir dari kartu aksi di beranda adalah `Navigator.push()`. Alasan pemilihannya adalah agar riwayat halaman utama (`MyHomePage`) tetap ada di dalam stack. Dengan begitu, saat pengguna selesai atau batal mengisi form, mereka cukup menekan tombol panah kembali pada AppBar untuk langsung kembali ke beranda.

Sementara itu, opsi Home pada drawer membawa pengguna kembali ke halaman utama menggunakan `Navigator.pushReplacement()`. Hal ini sengaja diterapkan agar halaman formulir yang sedang terbuka digantikan langsung oleh halaman beranda. Jika menggunakan `push` biasa, tumpukan navigasi akan menumpuk halaman beranda berkali-kali setiap kali pengguna membuka menu Home dari drawer, yang berisiko memboroskan memori dan membuat pengguna harus menekan tombol back berkali-kali hanya untuk keluar dari aplikasi.


2. Bagaimana susunan Scaffold, AppBar, dan Drawer membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.

Susunan ketiganya menjaga konsistensi tampilan melalui pembagian peran tata letak standar Material Design:
 `Scaffold` menjadi fondasi seragam di setiap halaman yang menyiapkan slot baku untuk header, kanvas isi (body), dan panel samping (drawer).
 `AppBar` memastikan bagian atas setiap layar memiliki ketinggian, penempatan judul, dan tombol akses drawer yang posisinya selalu seragam di mata pengguna.
 `Drawer` (`LeftDrawer`) dibuat sebagai widget modular tersendiri yang dipasang pada setiap `Scaffold` (baik di `MyHomePage`, `ProjectFormPage`, `ExperienceFormPage`, maupun `ExperienceListPage`). Karena menggunakan satu komponen yang sama, menu navigasi samping yang dilihat pengguna selalu identik di halaman mana pun mereka berada.

Contoh penerapan warna tema portofolio (Pink Espresso) di lebih dari satu halaman:
Warna primer espresso gelap `const Color(0xFF392529)` digunakan secara konsisten sebagai warna dasar `AppBar` dan header drawer di `menu.dart`, `project_form.dart`, `experience_form.dart`, dan `experience_list.dart`. Warna ini juga konsisten digunakan sebagai warna latar belakang tombol simpan (`ElevatedButton`) di kedua halaman formulir, serta warna teks judul utama. Dipadukan dengan warna krem lembut `const Color(0xFFF1DFD3)` sebagai warna dasar latar aplikasi dan teks header, identitas visual portofolio tetap harmonis di seluruh layar.


3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.

Tata letak formulir dirancang menggunakan `Column` di dalam `Form` dan dibungkus oleh `SingleChildScrollView`. Struktur vertikal dari atas ke bawah ini dipilih karena proses pengisian form memang bersifat sekuensial (dimulai dari posisi, kategori, tanggal mulai, status aktif, tautan URL, hingga deskripsi dan tombol simpan). Alur vertikal ini alami bagi alur membaca pengguna dan membantu memusatkan fokus pada satu field input sebelum berpindah ke field berikutnya.

 Peran widget pengatur jarak (`Padding` dan `SizedBox`): Memberikan ruang kosong (whitespace) yang proporsional antar-elemen input. Tanpa pengaturan jarak ini, kolom-kolom input akan menempel terlalu rapat sehingga antarmuka terlihat sempit, sulit dibaca, dan memperbesar risiko salah sentuh (misclick) pada layar sentuh.
 Peran widget penggulir (`SingleChildScrollView`): Menjadi penyelamat saat ruang layar terbatas, terutama ketika papan ketik virtual (soft keyboard) muncul dan memotong lebih dari setengah tinggi layar. Tanpa widget ini, sistem Flutter akan memicu overflow error (`RenderFlex overflowed by ... pixels`) dan tombol simpan akan tertutup oleh keyboard sehingga tidak bisa ditekan.


4. Apa peran GlobalKey<FormState>, validator, dan validate() saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.

 `GlobalKey<FormState>`: Berperan sebagai pengenal unik yang memberi akses langsung ke state internal dari widget `Form` dari luar widget tree form itu sendiri.
 `validator`: Fungsi pemeriksaan logika pada masing-masing field (`TextFormField`) yang bertugas mengecek apakah isi teks memenuhi aturan yang ditentukan (misalnya tidak boleh kosong atau panjang karakter minimum). Fungsi ini mengembalikan string pesan galat jika salah, atau `null` jika lolos.
 `validate()`: Metode yang dipanggil melalui `_formKey.currentState!.validate()`. Saat tombol Simpan ditekan, metode ini secara serentak menjalankan fungsi `validator` pada seluruh field form. Jika ada satu saja field yang tidak valid, proses simpan dibatalkan dan teks pesan galat otomatis muncul di bawah kolom yang bermasalah.

Contoh nilai yang ditolak oleh validasi pada form pengalaman adalah ketika pengguna hanya menekan spasi berulang kali (misalnya `"   "`). Berkat fungsi `value.trim().isEmpty`, input tersebut tetap terdeteksi kosong dan ditolak dengan pesan: "Posisi/peran pengalaman tidak boleh kosong!".

Memilih jenis input atau papan ketik saja (seperti `keyboardType: TextInputType.url` atau `TextInputType.number`) belum cukup karena keyboard type hanya sekadar saran tampilan papan ketik (layout hint) bagi kenyamanan pengguna. Fitur tersebut tidak mengunci atau menyaring input secara mutlak: pengguna masih bisa melakukan operasi paste (salin-tempel) karakter sembarang dari clipboard, membiarkan kolom kosong, atau menghapus teks hingga menyisakan spasi saja. Oleh karena itu, validasi logika programatis melalui `validator` di sisi kode tetap wajib ada demi menjaga kebersihan data.

## AI Disclosure & Analisis Kritis Keterbatasan AI

Dalam pengerjaan Tugas 8 ini, saya berdiskusi dengan AI sebagai asisten teknis untuk merancang struktur formulir, mengintegrasikan fitur kalender, serta menyusun kerangka penjelasan konsep navigasi Flutter.

Tools yang Digunakan: ChatGPT

Bagian yang Dibantu AI:
1. Memberikan referensi contoh penulisan fungsi `showDatePicker` dan integrasi widget `SwitchListTile`.
2. Membantu memberikan poin-poin komparasi teknis antara metode navigasi `Navigator.push`, `pushReplacement`, dan `pop`.

Analisis Kritis Keterbatasan AI & Perbaikan Manual:
1. Celah Validasi Whitespace:
   AI awalnya hanya menyarankan pemeriksaan dasar `value.isEmpty`. Celah ini membuat pengguna masih bisa mengelabui form hanya dengan menekan tombol spasi. Saya memperbaikinya secara manual dengan menerapkan `value.trim().isEmpty` dan batasan panjang karakter `value.trim().length < 3` agar form tidak menerima input kosong bertopeng spasi.
2. Kekeliruan Pemilihan Metode Navigasi Drawer:
   AI sempat menyarankan pemakaian `Navigator.pushReplacement` pada seluruh menu drawer. Praktik ini salah karena menghilangkan tombol back pada halaman formulir sehingga pengguna tidak bisa kembali ke halaman sebelumnya. Saya memperbaikinya dengan hanya menerapkan `pushReplacement` untuk tombol Home, sedangkan menu formulir dan daftar list menggunakan `Navigator.push`.
3. Peringatan Deprecated Member pada Flutter Versi Baru:
   AI menyarankan parameter `value` pada `DropdownButtonFormField` dan `activeColor` pada `SwitchListTile`. Saat dicek dengan `flutter analyze`, kedua properti tersebut memunculkan peringatan deprecation. Saya memperbaikinya secara manual menjadi `initialValue` dan `activeThumbColor` sesuai standar API Flutter terbaru sehingga hasil analisis kode benar-benar bersih (0 issues).
4. Penyelarasan Warna DatePicker:
   Secara default, dialog `showDatePicker` yang disarankan AI menggunakan warna biru bawaan Material yang bertabrakan dengan tema visual portofolio. Saya menambahkan konfigurasi `Theme` lokal di dalam builder kalender agar warnanya selaras dengan palet Pink Espresso (`#392529` dan `#F1DFD3`).