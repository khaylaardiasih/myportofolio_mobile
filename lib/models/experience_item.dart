// kreativitas tugas 8: Model data lokal untuk merepresentasikan entitas pengalaman
class ExperienceItem {
  final String title;
  final String category;
  final String description;
  final String thumbnailUrl;
  final DateTime startedAt;
  final bool isOngoing;

  ExperienceItem({
    required this.title,
    required this.category,
    required this.description,
    required this.thumbnailUrl,
    required this.startedAt,
    required this.isOngoing,
  });
}

// kreativitas tugas 8: List penampung in-memory agar data yang diinput dari form tidak hilang dan bisa ditampilkan di halaman daftar pengalaman
List<ExperienceItem> globalExperienceList = [];