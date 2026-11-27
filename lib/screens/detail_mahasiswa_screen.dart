// lib/screens/detail_mahasiswa_screen.dart
import 'package:material_ui/material_ui.dart';
import '../models/mahasiswa.dart';
import '../widgets/baris_info.dart';

/// Aksi yang dikembalikan ke Dashboard saat tombol pintas ditekan.
enum AksiDetail { edit, hapus }

class DetailMahasiswaScreen extends StatelessWidget {
  final Mahasiswa mahasiswa;

  const DetailMahasiswaScreen({super.key, required this.mahasiswa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Mahasiswa')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                mahasiswa.nama[0].toUpperCase(),
                style: const TextStyle(fontSize: 32),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              mahasiswa.nama,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 32),
            BarisInfo(ikon: Icons.badge, label: 'NIM', nilai: mahasiswa.nim),
            BarisInfo(
              ikon: Icons.school,
              label: 'Program Studi',
              nilai: mahasiswa.prodi,
            ),
            BarisInfo(
              ikon: Icons.timeline,
              label: 'Semester',
              nilai: mahasiswa.semester.toString(),
            ),
            BarisInfo(
              ikon: Icons.star,
              label: 'IPK',
              nilai: mahasiswa.ipk.toStringAsFixed(2),
            ),
            BarisInfo(
              ikon: Icons.email,
              label: 'Email',
              nilai: mahasiswa.email,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context, AksiDetail.edit),
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () => Navigator.pop(context, AksiDetail.hapus),
                    icon: const Icon(Icons.delete),
                    label: const Text('Hapus'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
