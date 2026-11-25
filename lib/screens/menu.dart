import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

// model buat tombol menu di home
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

// kartu info identitas (npm, nama, kelas)
class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      color: const Color(0xFFD9A6A8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: GoogleFonts.jost(
                fontWeight: FontWeight.w700,
                fontSize: 11,
                letterSpacing: 1.2,
                color: const Color(0xFF392529),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              content,
              textAlign: TextAlign.center,
              style: GoogleFonts.jost(
                fontSize: 11,
                color: const Color(0xFF392529),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// halaman utama portofolio
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = '2506656910';
  final String nama = 'Khayla Syafira Ardiasih';
  final String kelas = 'PBP A';

  // List tombol menu aksi di halaman beranda dengan ikon dan warna tema
  final List<ItemHomepage> items = [
    ItemHomepage("Lihat Proyek", Icons.folder_open, const Color(0xFF855B60)),
    ItemHomepage(
      "Tambah Proyek",
      Icons.add_circle_outline,
      const Color(0xFFD9A6A8),
    ),
    ItemHomepage(
      "Tambah Pengalaman",
      Icons.work_outline,
      const Color(0xFF855B60),
    ), // Menu Tugas 8
    ItemHomepage(
      "Lihat Pengalaman",
      Icons.list_alt_outlined,
      const Color(0xFFD9A6A8),
    ), // kreativitas tugas 8
    ItemHomepage("Logout", Icons.logout, const Color(0xFF392529)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyPortfolio',
          style: GoogleFonts.cormorantGaramond(
            color: const Color(0xFFF1DFD3),
            fontWeight: FontWeight.w700,
            fontSize: 26,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: const Color(0xFF392529),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFFF1DFD3)),
      ),
      // pasang left drawer di scaffold
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // baris info npm, nama, kelas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(title: 'NPM', content: npm),
                  InfoCard(title: 'Name', content: nama),
                  InfoCard(title: 'Class', content: kelas),
                ],
              ),
              const SizedBox(height: 24.0),
              // teks sambutan
              Center(
                child: Text(
                  'Selamat datang di MyPortfolio',
                  style: GoogleFonts.cormorantGaramond(
                    fontWeight: FontWeight.w600,
                    fontSize: 22.0,
                    color: const Color(0xFF392529),
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // grid buat nampilin 3 tombol menu
              GridView.count(
                primary: true,
                padding: const EdgeInsets.all(8),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: items.map((ItemHomepage item) {
                  return PulseItemCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
