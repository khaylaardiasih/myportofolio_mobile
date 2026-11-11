import 'package:flutter/material.dart';

// Model tombol menu dengan properti warna unik
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

// Widget kartu informasi (NPM, Name, Class)
class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      color: const Color(0xFFD9A6A8), // Dusty Pink untuk kartu identitas
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF392529), // Espresso gelap agar kontras
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF392529), // Espresso gelap
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget kartu tombol menu interaktif
class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(16),
      elevation: 2.5,
      child: InkWell(
        onTap: () {
          // Menampilkan SnackBar bernuansa Warm Tan saat tombol ditekan
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!"),
                backgroundColor: const Color(0xFFB69A7D), // Warm Tan
              ),
            );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: const Color(0xFFF1DFD3), // Blush Cream untuk ikon
                  size: 32.0,
                ),
                const SizedBox(height: 8.0),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFF1DFD3), // Blush Cream untuk teks tombol
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Halaman utama portofolio
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = '2506656910';
  final String nama = 'Khayla Syafira Ardiasih';
  final String kelas = 'PBP A';

  // Tombol: Muted Mauve, Dusty Pink, Espresso
  final List<ItemHomepage> items = [
    ItemHomepage("Lihat Proyek", Icons.folder_open, const Color(0xFF855B60)),    // Muted Mauve
    ItemHomepage("Tambah Proyek", Icons.add_circle_outline, const Color(0xFFD9A6A8)), // Dusty Pink
    ItemHomepage("Logout", Icons.logout, const Color(0xFF392529)),               // Espresso
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Header dengan warna Espresso paling gelap
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(
            color: Color(0xFFF1DFD3), // Blush Cream
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF392529), // Espresso
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Tiga InfoCard sejajar horizontal
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(title: 'NPM', content: npm),
                  InfoCard(title: 'Name', content: nama),
                  InfoCard(title: 'Class', content: kelas),
                ],
              ),
              const SizedBox(height: 24.0),
              // Teks sambutan dengan Espresso gelap
              const Center(
                child: Text(
                  'Selamat datang di MyPortfolio',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Color(0xFF392529), // Espresso
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Grid 3 kolom tombol menu
              GridView.count(
                primary: true,
                padding: const EdgeInsets.all(8),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: items.map((ItemHomepage item) {
                  return ItemCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}