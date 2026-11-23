import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportofolio_mobile/models/experience_item.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

// Halaman form untuk menambahkan pengalaman baru (Tugas 8)
class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  // Key global untuk validasi form
  final _formKey = GlobalKey<FormState>();

  // Variabel penampung nilai input pengguna
  String _title = "";
  String _category = "Internship";
  String _description = "";
  String _thumbnailUrl = "";
  DateTime? _startedAt;
  bool _isOngoing = true; // Default nilai pengalaman masih aktif

  // Opsi kategori yang diselaraskan dengan pilihan kategori model Django
  final List<String> _categories = [
    'Internship',
    'Research',
    'Volunteer',
    'Part-Time',
    'Full-Time',
    'Freelance',
  ];

  // kreativitas tugas 8: Fungsi pemilih tanggal interaktif dengan kustomisasi warna tema Pink Espresso
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startedAt ?? DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
      builder: (context, child) {
        // Sesuaikan warna date picker bawaan dengan palet tema portofolio
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF392529), // Warna header & tanggal terpilih
              onPrimary: Color(0xFFF1DFD3), // Warna teks di atas header
              onSurface: Color(0xFF392529), // Warna teks kalender
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _startedAt) {
      setState(() {
        _startedAt = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Pengalaman',
          style: GoogleFonts.cormorantGaramond(
            color: const Color(0xFFF1DFD3),
            fontWeight: FontWeight.w700,
            fontSize: 24,
            letterSpacing: 0.8,
          ),
        ),
        backgroundColor: const Color(0xFF392529),
        foregroundColor: const Color(0xFFF1DFD3),
        iconTheme: const IconThemeData(color: Color(0xFFF1DFD3)),
        centerTitle: true,
      ),
      // Integrasikan drawer navigasi samping
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey, // Hubungkan key form
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Input: Posisi / Judul Pengalaman
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Posisi / Peran Pengalaman",
                    hintText: "Contoh: Frontend Developer Intern",
                    prefixIcon: const Icon(Icons.work_outline, color: Color(0xFF392529)),
                    labelStyle: GoogleFonts.jost(color: const Color(0xFF392529)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFF855B60), width: 1.8),
                    ),
                  ),
                  style: GoogleFonts.jost(),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value ?? "";
                    });
                  },
                  // Validasi: tidak boleh kosong dan minimal 3 karakter
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Posisi/peran pengalaman tidak boleh kosong!";
                    }
                    if (value.trim().length < 3) {
                      return "Posisi minimal harus terdiri dari 3 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // 2. Input: Pilihan Kategori (Dropdown)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  initialValue: _category,
                  decoration: InputDecoration(
                    labelText: "Kategori Pengalaman",
                    prefixIcon: const Icon(Icons.category_outlined, color: Color(0xFF392529)),
                    labelStyle: GoogleFonts.jost(color: const Color(0xFF392529)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFF855B60), width: 1.8),
                    ),
                  ),
                  items: _categories.map((String cat) {
                    return DropdownMenuItem<String>(
                      value: cat,
                      child: Text(cat, style: GoogleFonts.jost()),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                ),
              ),

              // 3. Input: Tanggal Mulai Bekerja (DatePicker)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: InkWell(
                  onTap: () => _selectStartDate(context),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Tanggal Mulai",
                      prefixIcon: const Icon(Icons.calendar_today_outlined, color: Color(0xFF392529)),
                      labelStyle: GoogleFonts.jost(color: const Color(0xFF392529)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: Text(
                      _startedAt == null
                          ? "Pilih tanggal mulai..."
                          : "${_startedAt!.day.toString().padLeft(2, '0')}/${_startedAt!.month.toString().padLeft(2, '0')}/${_startedAt!.year}",
                      style: GoogleFonts.jost(
                        color: _startedAt == null ? Colors.grey[600] : const Color(0xFF392529),
                        fontWeight: _startedAt == null ? FontWeight.normal : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              // kreativitas tugas 8: Toggle status pekerjaan aktif/selesai sesuai properti model Django (is_ongoing)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "Masih aktif / berlangsung sampai sekarang",
                    style: GoogleFonts.jost(fontWeight: FontWeight.w500, color: const Color(0xFF392529)),
                  ),
                  value: _isOngoing,
                  activeThumbColor: const Color(0xFF855B60),
                  onChanged: (bool val) {
                    setState(() {
                      _isOngoing = val;
                    });
                  },
                ),
              ),

              // 4. Input: URL Logo Perusahaan / Thumbnail (Opsional)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "URL Logo / Gambar Instansi (Opsional)",
                    hintText: "https://example.com/logo.png",
                    prefixIcon: const Icon(Icons.image_outlined, color: Color(0xFF392529)),
                    labelStyle: GoogleFonts.jost(color: const Color(0xFF392529)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFF855B60), width: 1.8),
                    ),
                  ),
                  style: GoogleFonts.jost(),
                  onChanged: (String? value) {
                    setState(() {
                      _thumbnailUrl = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value != null && value.trim().isNotEmpty) {
                      final uri = Uri.tryParse(value.trim());
                      if (uri == null || !uri.isAbsolute) {
                        return "Format URL tidak valid (harus diawali http:// atau https://)";
                      }
                    }
                    return null;
                  },
                ),
              ),

              // 5. Input: Deskripsi Pengalaman
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Deskripsi Pengalaman",
                    hintText: "Jelaskan peran, tanggung jawab, dan pencapaian Anda...",
                    alignLabelWithHint: true,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 55.0),
                      child: Icon(Icons.description_outlined, color: Color(0xFF392529)),
                    ),
                    labelStyle: GoogleFonts.jost(color: const Color(0xFF392529)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFF855B60), width: 1.8),
                    ),
                  ),
                  style: GoogleFonts.jost(),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi pengalaman wajib diisi!";
                    }
                    if (value.trim().length < 10) {
                      return "Deskripsi terlalu pendek (minimal 10 karakter)";
                    }
                    return null;
                  },
                ),
              ),

              // kreativitas tugas 8: Live Preview Card dinamis yang langsung menampilkan pratinjau data saat diketik pengguna
              if (_title.isNotEmpty)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9A6A8).withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: const Color(0xFF855B60), width: 1.2),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.preview_outlined, color: Color(0xFF392529)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pratinjau: $_title",
                              style: GoogleFonts.jost(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: const Color(0xFF392529),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Kategori: $_category • Status: ${_isOngoing ? "Sedang Berlangsung" : "Selesai"}",
                              style: GoogleFonts.jost(fontSize: 12, color: const Color(0xFF392529)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 16.0),

              // Tombol Simpan Pengalaman
              Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save_outlined),
                  label: Text(
                    "Simpan Pengalaman",
                    style: GoogleFonts.jost(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0,
                      letterSpacing: 0.5,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF392529),
                    foregroundColor: const Color(0xFFF1DFD3),
                    padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 14.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 3.0,
                  ),
                  onPressed: () {
                    // Validasi tanggal mulai tidak boleh kosong
                    if (_startedAt == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Harap pilih tanggal mulai terlebih dahulu!",
                            style: GoogleFonts.jost(),
                          ),
                          backgroundColor: Colors.red[700],
                        ),
                      );
                      return;
                    }

                    // Jalankan validasi semua field form
                    if (_formKey.currentState!.validate()) {
                      // kreativitas tugas 8: Simpan data baru ke list in-memory global
                      final newExperience = ExperienceItem(
                        title: _title,
                        category: _category,
                        description: _description,
                        thumbnailUrl: _thumbnailUrl,
                        startedAt: _startedAt!,
                        isOngoing: _isOngoing,
                      );
                      globalExperienceList.add(newExperience);

                      // Tampilkan pop-up dialog ringkasan data yang diisi
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: const Color(0xFFF1DFD3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            title: Text(
                              'Pengalaman Berhasil Disimpan!',
                              style: GoogleFonts.cormorantGaramond(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: const Color(0xFF392529),
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Posisi: $_title', style: GoogleFonts.jost(fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 6),
                                  Text('Kategori: $_category', style: GoogleFonts.jost()),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Mulai: ${_startedAt!.day}/${_startedAt!.month}/${_startedAt!.year}',
                                    style: GoogleFonts.jost(),
                                  ),
                                  const SizedBox(height: 6),
                                  Text('Status: ${_isOngoing ? "Sedang Berlangsung" : "Selesai"}', style: GoogleFonts.jost()),
                                  const SizedBox(height: 6),
                                  Text('Deskripsi: $_description', style: GoogleFonts.jost()),
                                  if (_thumbnailUrl.isNotEmpty) ...[
                                    const SizedBox(height: 6),
                                    Text('URL Logo: $_thumbnailUrl', style: GoogleFonts.jost(fontSize: 12)),
                                  ],
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Tutup dialog
                                  _formKey.currentState!.reset(); // Reset form
                                  setState(() {
                                    _title = "";
                                    _category = "Internship";
                                    _description = "";
                                    _thumbnailUrl = "";
                                    _startedAt = null;
                                    _isOngoing = true;
                                  });
                                },
                                child: Text(
                                  'OK',
                                  style: GoogleFonts.jost(
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF392529),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}