import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportofolio_mobile/models/project.dart';

// Layar untuk menampilkan rincian detail dari sebuah proyek
class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Project Details',
          style: GoogleFonts.cormorantGaramond(
            color: const Color(0xFFF1DFD3),
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color(0xFF392529),
        iconTheme: const IconThemeData(color: Color(0xFFF1DFD3)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar proyek (hanya ditampilkan jika URL gambar tidak kosong)
            if (project.projectImageUrl.trim().isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  project.projectImageUrl,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9A6A8).withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.broken_image_outlined,
                            size: 42,
                            color: Color(0xFF392529),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Gagal memuat gambar',
                            style: GoogleFonts.jost(
                              fontSize: 12,
                              color: const Color(0xFF392529),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Judul Proyek
            Text(
              project.title,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF392529),
              ),
            ),
            const SizedBox(height: 12),

            // Badge / Tag Tech Stack
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFD9A6A8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                project.techStack,
                style: GoogleFonts.jost(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF392529),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Bagian deskripsi proyek
            Text(
              'Deskripsi',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF392529),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              project.description,
              style: GoogleFonts.jost(
                fontSize: 14,
                height: 1.5,
                color: const Color(0xFF392529),
              ),
            ),
            const SizedBox(height: 24),

            // Bagian tautan URL proyek
            if (project.projectUrl.trim().isNotEmpty) ...[
              Text(
                'Project URL',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF392529),
                ),
              ),
              const SizedBox(height: 8),
              SelectableText(
                project.projectUrl,
                style: GoogleFonts.jost(
                  fontSize: 13,
                  color: Colors.blue[900],
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
