import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportofolio_mobile/models/experience_item.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

// kreativitas tugas 8: Halaman untuk menampilkan daftar seluruh pengalaman yang sudah ditambahkan lewat form
class ExperienceListPage extends StatelessWidget {
  const ExperienceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Pengalaman',
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
      // Integrasikan drawer navigasi
      drawer: const LeftDrawer(),
      body: globalExperienceList.isEmpty
          // Tampilan kosong jika pengguna belum memasukkan data pengalaman
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.work_off_outlined,
                      size: 64,
                      color: const Color(0xFF855B60).withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Belum ada pengalaman yang ditambahkan',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF392529),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Silakan isi form tambah pengalaman terlebih dahulu.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.jost(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: Text(
                        'Tambah Pengalaman Sekarang',
                        style: GoogleFonts.jost(),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF392529),
                        foregroundColor: const Color(0xFFF1DFD3),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ExperienceFormPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          // Tampilan daftar kartu pengalaman jika data sudah ada
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: globalExperienceList.length,
              itemBuilder: (context, index) {
                final item = globalExperienceList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 14.0),
                  elevation: 2.0,
                  color: const Color(0xFFF1DFD3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                    side: const BorderSide(
                      color: Color(0xFFD9A6A8),
                      width: 1.2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Baris judul dan badge status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.title,
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF392529),
                                ),
                              ),
                            ),
                            // Badge status: aktif / selesai
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: item.isOngoing
                                    ? const Color(0xFF855B60)
                                    : Colors.grey[600],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                item.isOngoing ? "Ongoing" : "Completed",
                                style: GoogleFonts.jost(
                                  color: const Color(0xFFF1DFD3),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // Badge kategori & tanggal mulai
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD9A6A8)
                                    .withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                item.category,
                                style: GoogleFonts.jost(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF392529),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Mulai: ${item.startedAt.day}/${item.startedAt.month}/${item.startedAt.year}",
                              style: GoogleFonts.jost(
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Deskripsi pekerjaan
                        Text(
                          item.description,
                          style: GoogleFonts.jost(
                            fontSize: 13,
                            color: const Color(0xFF392529),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
