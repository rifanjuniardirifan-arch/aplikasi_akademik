// lib/models/mahasiswa.dart
class Mahasiswa {
  final String id;
  final String nim;
  final String nama;
  final String prodi;
  final int semester;
  final String email;
  final double ipk;

  const Mahasiswa({
    required this.id,
    required this.nim,
    required this.nama,
    required this.prodi,
    required this.semester,
    required this.email,
    required this.ipk,
  });

  Mahasiswa copyWith({
    String? id,
    String? nim,
    String? nama,
    String? prodi,
    int? semester,
    String? email,
    double? ipk,
  }) {
    return Mahasiswa(
      id: id ?? this.id,
      nim: nim ?? this.nim,
      nama: nama ?? this.nama,
      prodi: prodi ?? this.prodi,
      semester: semester ?? this.semester,
      email: email ?? this.email,
      ipk: ipk ?? this.ipk,
    );
  }

  factory Mahasiswa.fromMap(Map<String, dynamic> map) {
    return Mahasiswa(
      id: map['id']?.toString() ?? '',
      nim: map['nim']?.toString() ?? '',
      nama: map['nama']?.toString() ?? '',
      prodi: map['prodi']?.toString() ?? 'Sistem Informasi',
      semester: int.tryParse(map['semester'].toString()) ?? 1,
      email: map['email']?.toString() ?? '',
      ipk: double.tryParse(map['ipk'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nim': nim,
      'nama': nama,
      'prodi': prodi,
      'semester': semester,
      'email': email,
      'ipk': ipk,
    };
  }
}
