class Kampus {
  final int? id;
  final String nama;
  final String alamat;
  final String noTelpon;
  final String kategori; // Swasta / Negeri
  final double latitude;
  final double longitude;
  final String jurusan;

  Kampus({
    this.id,
    required this.nama,
    required this.alamat,
    required this.noTelpon,
    required this.kategori,
    required this.latitude,
    required this.longitude,
    required this.jurusan,
  });

  factory Kampus.fromJson(Map<String, dynamic> json) {
    return Kampus(
      id: json['id'],
      nama: json['nama_kampus'], // disesuaikan dengan backend
      alamat: json['alamat'],
      noTelpon: json['no_telpon'],
      kategori: json['kategori'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      jurusan: json['jurusan'],
    );
  }

  Map<String, dynamic> toJson() => {
        'nama_kampus': nama, // disesuaikan dengan backend
        'alamat': alamat,
        'no_telpon': noTelpon,
        'kategori': kategori,
        'latitude': latitude,
        'longitude': longitude,
        'jurusan': jurusan,
      };
}