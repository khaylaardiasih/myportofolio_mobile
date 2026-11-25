import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

// Form pembuatan data proyek baru yang terhubung ke REST API Django
class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

// Alias kompatibilitas
typedef ProjectEntryFormPage = ProjectFormPage;

class _ProjectFormPageState extends State<ProjectFormPage> {
  // Key global untuk validasi form input
  final _formKey = GlobalKey<FormState>();

  // Variabel penampung state field form sesuai model Project
  String _title = "";
  String _description = "";
  String _techStack = "";
  String _projectUrl = "";
  String _projectImageUrl = "";
  bool _isSubmitting = false;

  // Fungsi pengiriman data proyek baru ke API backend
  Future<void> _submit() async {
    // 1. Validasi input form
    if (!_formKey.currentState!.validate()) return;

    // 2. Pastikan user telah terautentikasi (route guard)
    final authenticated = await ensureLoggedIn(context);
    if (!mounted || !authenticated) return;

    final authState = context.read<AuthState>();
    final token = authState.token;
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Sesi login tidak ditemukan. Silakan login kembali.',
            style: GoogleFonts.jost(),
          ),
          backgroundColor: Colors.red[700],
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // 3. Buat instance Project
    final newProject = Project(
      title: _title.trim(),
      description: _description.trim(),
      techStack: _techStack.trim(),
      projectUrl: _projectUrl.trim(),
      projectImageUrl: _projectImageUrl.trim(),
    );

    try {
      // 4. Kirim request POST ke /api/v1/projects/
      final createdProject = await context.read<ApiClient>().createProject(
        newProject,
        token: token,
      );

      if (!mounted) return;

      // 5. Tampilkan dialog konfirmasi 201 Created
      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Proyek Berhasil Ditambahkan!',
              style: GoogleFonts.cormorantGaramond(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF392529),
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Judul: ${createdProject.title}',
                    style: GoogleFonts.jost(),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Deskripsi: ${createdProject.description}',
                    style: GoogleFonts.jost(),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tech Stack: ${createdProject.techStack}',
                    style: GoogleFonts.jost(),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'URL: ${createdProject.projectUrl}',
                    style: GoogleFonts.jost(),
                  ),
                  if (createdProject.projectImageUrl.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Image URL: ${createdProject.projectImageUrl}',
                      style: GoogleFonts.jost(),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: GoogleFonts.jost(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF392529),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );

      // Reset form setelah berhasil menyimpan
      if (!mounted) return;
      _formKey.currentState!.reset();
      setState(() {
        _title = "";
        _description = "";
        _techStack = "";
        _projectUrl = "";
        _projectImageUrl = "";
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      // Jika error 401 Unauthorized, sesi token habis sehingga perlu logout
      if (e.statusCode == 401) {
        await context.read<AuthState>().logout();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Sesi autentikasi telah berakhir. Silakan login kembali.',
              style: GoogleFonts.jost(),
            ),
            backgroundColor: Colors.red[700],
          ),
        );
        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal menambahkan proyek (${e.statusCode}): ${e.message}',
              style: GoogleFonts.jost(),
            ),
            backgroundColor: Colors.red[700],
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e', style: GoogleFonts.jost()),
          backgroundColor: Colors.red[700],
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Add Project Form',
            style: GoogleFonts.cormorantGaramond(
              color: const Color(0xFFF1DFD3),
              fontWeight: FontWeight.w700,
              fontSize: 24,
              letterSpacing: 0.8,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF392529),
        foregroundColor: const Color(0xFFF1DFD3),
        iconTheme: const IconThemeData(color: Color(0xFFF1DFD3)),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Input Judul Proyek (Title)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Judul Proyek",
                    labelText: "Title",
                    labelStyle: GoogleFonts.jost(
                      color: const Color(0xFF392529),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xFF855B60),
                        width: 1.5,
                      ),
                    ),
                  ),
                  style: GoogleFonts.jost(),
                  onChanged: (String value) {
                    setState(() {
                      _title = value;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Title tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // 2. Input Deskripsi Proyek (Description)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Deskripsi Proyek",
                    labelText: "Description",
                    alignLabelWithHint: true,
                    labelStyle: GoogleFonts.jost(
                      color: const Color(0xFF392529),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xFF855B60),
                        width: 1.5,
                      ),
                    ),
                  ),
                  style: GoogleFonts.jost(),
                  onChanged: (String value) {
                    setState(() {
                      _description = value;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Description tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // 3. Input Teknologi yang Digunakan (Tech Stack)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Flutter, Django, PostgreSQL",
                    labelText: "Tech Stack",
                    labelStyle: GoogleFonts.jost(
                      color: const Color(0xFF392529),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xFF855B60),
                        width: 1.5,
                      ),
                    ),
                  ),
                  style: GoogleFonts.jost(),
                  onChanged: (String value) {
                    setState(() {
                      _techStack = value;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Tech stack tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // 4. Input Tautan Proyek (Project URL dengan validasi format)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "https://github.com/username/project",
                    labelText: "Project URL",
                    labelStyle: GoogleFonts.jost(
                      color: const Color(0xFF392529),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xFF855B60),
                        width: 1.5,
                      ),
                    ),
                  ),
                  style: GoogleFonts.jost(),
                  onChanged: (String value) {
                    setState(() {
                      _projectUrl = value;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Project URL tidak boleh kosong!";
                    }
                    final uri = Uri.tryParse(value.trim());
                    if (uri == null ||
                        !uri.hasScheme ||
                        !(uri.scheme == 'http' || uri.scheme == 'https')) {
                      return "Format URL harus valid (diawali http:// atau https://)!";
                    }
                    return null;
                  },
                ),
              ),

              // 5. Input Gambar Proyek (Project Image URL, opsional)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "https://example.com/image.png (Opsional)",
                    labelText: "Project Image URL (Optional)",
                    labelStyle: GoogleFonts.jost(
                      color: const Color(0xFF392529),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xFF855B60),
                        width: 1.5,
                      ),
                    ),
                  ),
                  style: GoogleFonts.jost(),
                  onChanged: (String value) {
                    setState(() {
                      _projectImageUrl = value;
                    });
                  },
                  validator: (String? value) {
                    if (value != null && value.trim().isNotEmpty) {
                      final uri = Uri.tryParse(value.trim());
                      if (uri == null ||
                          !uri.hasScheme ||
                          !(uri.scheme == 'http' || uri.scheme == 'https')) {
                        return "Format Image URL harus valid!";
                      }
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Tombol Simpan Proyek
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF392529),
                    foregroundColor: const Color(0xFFF1DFD3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48.0,
                      vertical: 14.0,
                    ),
                    elevation: 2.0,
                  ),
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFFF1DFD3),
                          ),
                        )
                      : Text(
                          "Save Project",
                          style: GoogleFonts.jost(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0,
                            letterSpacing: 0.5,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
