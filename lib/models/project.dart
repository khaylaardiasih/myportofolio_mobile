import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

// Model data proyek yang disinkronisasikan dengan Django REST Framework API
@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  const Project({
    required this.title,
    required this.description,
    required this.techStack,
    required this.projectUrl,
    this.projectImageUrl = '',
    this.id,
  });

  // Factory constructor untuk deserialisasi JSON dari API Django
  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  // Field id berupa UUID dari server (tidak disertakan saat kirim POST)
  @JsonKey(includeToJson: false)
  final String? id;

  // Judul atau nama proyek
  final String title;

  // Deskripsi lengkap proyek
  final String description;

  // Deretan teknologi yang digunakan pada proyek
  final String techStack;

  // Tautan repository atau demo proyek
  final String projectUrl;

  // Tautan URL gambar thumbnail proyek (opsional, default string kosong)
  @JsonKey(defaultValue: '')
  final String projectImageUrl;

  // Method untuk serialisasi instance model ke bentuk Map JSON
  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
