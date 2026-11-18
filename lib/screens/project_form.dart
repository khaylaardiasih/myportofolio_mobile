import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

// form buat nambah data proyek baru
class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

// alias buat kompatibilitas
typedef ProjectEntryFormPage = ProjectFormPage;

class _ProjectFormPageState extends State<ProjectFormPage> {
  // key buat validasi form
  final _formKey = GlobalKey<FormState>();

  // variabel penampung input user
  String _projectName = "";
  String _description = "";
  String _category = "Web Development";
  String _technologies = "";
  String _projectLink = "";

  // list kategori buat dropdown
  final List<String> _categories = [
    'Web Development',
    'Mobile Development',
    'Machine Learning',
    'Data Science',
    'Other',
  ];

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // input nama proyek
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Proyek",
                    labelText: "Nama Proyek",
                    labelStyle: GoogleFonts.jost(color: const Color(0xFF392529)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: Color(0xFF855B60), width: 1.5),
                    ),
                  ),
                  style: GoogleFonts.jost(),
                  onChanged: (String? value) {
                    setState(() {
                      _projectName = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama proyek tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // input deskripsi proyek
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Deskripsi Proyek",
                    labelText: "Deskripsi Proyek",
                    alignLabelWithHint: true,
                    labelStyle: GoogleFonts.jost(color: const Color(0xFF392529)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: Color(0xFF855B60), width: 1.5),
                    ),
                  ),
                  style: GoogleFonts.jost(),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi proyek tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // dropdown pilihan kategori
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategori Proyek",
                    labelStyle: GoogleFonts.jost(color: const Color(0xFF392529)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: Color(0xFF855B60), width: 1.5),
                    ),
                  ),
                  initialValue: _category,
                  style: GoogleFonts.jost(color: const Color(0xFF392529)),
                  items: _categories
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category, style: GoogleFonts.jost()),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                ),
              ),

              // input teknologi yang dipake
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Flutter, Django, Figma",
                    labelText: "Teknologi yang Digunakan",
                    labelStyle: GoogleFonts.jost(color: const Color(0xFF392529)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: Color(0xFF855B60), width: 1.5),
                    ),
                  ),
                  style: GoogleFonts.jost(),
                  onChanged: (String? value) {
                    setState(() {
                      _technologies = value!;
                    });
                  },
                ),
              ),

              // input tautan proyek (opsional)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "URL Proyek (opsional)",
                    labelText: "Tautan Proyek",
                    labelStyle: GoogleFonts.jost(color: const Color(0xFF392529)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: Color(0xFF855B60), width: 1.5),
                    ),
                  ),
                  style: GoogleFonts.jost(),
                  onChanged: (String? value) {
                    setState(() {
                      _projectLink = value!;
                    });
                  },
                ),
              ),

              // tombol simpan data
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF392529),
                      foregroundColor: const Color(0xFFF1DFD3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
                      elevation: 2.0,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Proyek berhasil ditambahkan!',
                                style: GoogleFonts.cormorantGaramond(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF392529),
                                ),
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama Proyek: $_projectName', style: GoogleFonts.jost()),
                                    const SizedBox(height: 4),
                                    Text('Deskripsi: $_description', style: GoogleFonts.jost()),
                                    const SizedBox(height: 4),
                                    Text('Kategori: $_category', style: GoogleFonts.jost()),
                                    const SizedBox(height: 4),
                                    Text('Teknologi: $_technologies', style: GoogleFonts.jost()),
                                    const SizedBox(height: 4),
                                    Text('Tautan: $_projectLink', style: GoogleFonts.jost()),
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
                                    _formKey.currentState!.reset();
                                    setState(() {
                                      _projectName = "";
                                      _description = "";
                                      _category = "Web Development";
                                      _technologies = "";
                                      _projectLink = "";
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text(
                      "Save",
                      style: GoogleFonts.jost(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
