import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/screens/project_detail_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

// Layar untuk menampilkan daftar seluruh proyek dari API backend Django
class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  late Future<List<Project>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    // Inisialisasi pengambilan data sekali di initState agar tidak berulang saat rebuild
    _projectsFuture = context.read<ApiClient>().getProjects();
  }

  // Fungsi reload data untuk RefreshIndicator dan tombol retry
  Future<void> _reload() async {
    final future = context.read<ApiClient>().getProjects();
    setState(() {
      _projectsFuture = future;
    });
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Achievements: Projects',
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
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Project>>(
        future: _projectsFuture,
        builder: (context, snapshot) {
          // Kondisi saat data masih dalam proses loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF392529)),
            );
          }

          // Kondisi jika terjadi error saat memanggil API
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Color(0xFF855B60),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Failed to load projects: ${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.jost(
                        fontSize: 14,
                        color: const Color(0xFF392529),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF392529),
                        foregroundColor: const Color(0xFFF1DFD3),
                      ),
                      onPressed: _reload,
                      icon: const Icon(Icons.refresh),
                      label: Text(
                        'Retry',
                        style: GoogleFonts.jost(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final projects = snapshot.data ?? const <Project>[];

          // Jika data proyek kosong dari server
          if (projects.isEmpty) {
            return RefreshIndicator(
              color: const Color(0xFF392529),
              onRefresh: _reload,
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.folder_open_outlined,
                            size: 56,
                            color: Color(0xFF855B60),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No projects found.',
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF392529),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Tarik ke bawah untuk memperbarui daftar.',
                            style: GoogleFonts.jost(
                              fontSize: 12,
                              color: const Color(0xFF855B60),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          // Menampilkan daftar proyek yang berhasil diambil
          return RefreshIndicator(
            color: const Color(0xFF392529),
            onRefresh: _reload,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProjectDetailScreen(project: project),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  project.title,
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF392529),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD9A6A8)
                                      .withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  project.techStack,
                                  style: GoogleFonts.jost(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF392529),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            project.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.jost(
                              fontSize: 13,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Lihat Detail',
                                style: GoogleFonts.jost(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF855B60),
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: Color(0xFF855B60),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
