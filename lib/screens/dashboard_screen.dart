// lib/screens/dashboard_screen.dart
import 'package:material_ui/material_ui.dart';
import '../models/mahasiswa.dart';
import '../models/mata_kuliah.dart';
import '../services/akademik_service.dart';
import '../widgets/kartu_mahasiswa.dart';
import '../widgets/kartu_mata_kuliah.dart';
import 'detail_mahasiswa_screen.dart';
import 'form_mahasiswa_screen.dart';
import 'form_mata_kuliah_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Mahasiswa> _daftarMahasiswa =
      AkademikService.ambilDataAwalMahasiswa();
  final List<MataKuliah> _daftarMataKuliah =
      AkademikService.ambilDataAwalMataKuliah();

  int _tabAktif = 0; // 0 = Mahasiswa, 1 = Mata Kuliah

  // ===================== SNACKBAR =====================
  void _tampilSnack(String pesan, {SnackBarAction? aksi}) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(SnackBar(content: Text(pesan), action: aksi));
  }

  // ===================== DIALOG KONFIRMASI =====================
  Future<bool> _dialogHapus(String judul, String isi) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(judul),
        content: Text(isi),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    // Ketuk area gelap di luar dialog -> yakin == null -> dianggap BATAL
    return yakin == true;
  }

  // ===================== MAHASISWA (CRUD) =====================
  Future<void> _bukaFormMahasiswa({Mahasiswa? mhsEdit}) async {
    final hasil = await Navigator.push<Mahasiswa>(
      context,
      MaterialPageRoute(
        builder: (_) => FormMahasiswaScreen(mahasiswaEdit: mhsEdit),
      ),
    );
    if (hasil == null || !mounted) return;

    setState(() {
      if (mhsEdit == null) {
        _daftarMahasiswa.add(hasil); // CREATE
      } else {
        final idx = _daftarMahasiswa.indexWhere((m) => m.id == hasil.id);
        if (idx != -1) _daftarMahasiswa[idx] = hasil; // UPDATE (timpa)
      }
    });
    _tampilSnack(
      mhsEdit == null
          ? 'Mahasiswa "${hasil.nama}" berhasil ditambahkan'
          : 'Data "${hasil.nama}" berhasil diperbarui',
    );
  }

  Future<void> _bukaDetailMahasiswa(Mahasiswa mhs) async {
    final aksi = await Navigator.push<AksiDetail>(
      context,
      MaterialPageRoute(builder: (_) => DetailMahasiswaScreen(mahasiswa: mhs)),
    );
    if (aksi == null || !mounted) return;

    if (aksi == AksiDetail.edit) {
      await _bukaFormMahasiswa(mhsEdit: mhs);
    } else {
      await _hapusMahasiswa(mhs);
    }
  }

  Future<void> _hapusMahasiswa(Mahasiswa mhs) async {
    final yakin = await _dialogHapus(
      'Hapus Mahasiswa?',
      'Yakin ingin menghapus "${mhs.nama}" (NIM: ${mhs.nim})?',
    );
    if (!yakin || !mounted) return;

    final idx = _daftarMahasiswa.indexWhere((m) => m.id == mhs.id);
    if (idx == -1) return;

    setState(() => _daftarMahasiswa.removeAt(idx)); // DELETE
    _tampilSnack(
      'Mahasiswa "${mhs.nama}" dihapus',
      aksi: SnackBarAction(
        label: 'URUNGKAN', // FITUR KUSTOMISASI: UNDO
        onPressed: () {
          setState(() {
            final posisi =
                idx > _daftarMahasiswa.length ? _daftarMahasiswa.length : idx;
            _daftarMahasiswa.insert(posisi, mhs);
          });
        },
      ),
    );
  }

  // ===================== MATA KULIAH (CRUD) =====================
  Future<void> _bukaFormMataKuliah({MataKuliah? mkEdit}) async {
    final hasil = await Navigator.push<MataKuliah>(
      context,
      MaterialPageRoute(builder: (_) => FormMataKuliahScreen(mkEdit: mkEdit)),
    );
    if (hasil == null || !mounted) return;

    setState(() {
      if (mkEdit == null) {
        _daftarMataKuliah.add(hasil); // CREATE
      } else {
        final idx = _daftarMataKuliah.indexWhere((m) => m.id == hasil.id);
        if (idx != -1) _daftarMataKuliah[idx] = hasil; // UPDATE
      }
    });
    _tampilSnack(
      mkEdit == null
          ? 'Mata kuliah "${hasil.namaMk}" berhasil ditambahkan'
          : 'Mata kuliah "${hasil.namaMk}" berhasil diperbarui',
    );
  }

  Future<void> _hapusMataKuliah(MataKuliah mk) async {
    final yakin = await _dialogHapus(
      'Hapus Mata Kuliah?',
      'Yakin ingin menghapus "${mk.namaMk}" (${mk.kode})?',
    );
    if (!yakin || !mounted) return;

    final idx = _daftarMataKuliah.indexWhere((m) => m.id == mk.id);
    if (idx == -1) return;

    setState(() => _daftarMataKuliah.removeAt(idx)); // DELETE
    _tampilSnack(
      'Mata kuliah "${mk.namaMk}" dihapus',
      aksi: SnackBarAction(
        label: 'URUNGKAN',
        onPressed: () {
          setState(() {
            final posisi =
                idx > _daftarMataKuliah.length ? _daftarMataKuliah.length : idx;
            _daftarMataKuliah.insert(posisi, mk);
          });
        },
      ),
    );
  }

  // ===================== TAMPILAN =====================
  Widget _emptyState(String pesan) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inbox_outlined, size: 72, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              pesan,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabMahasiswa() {
    if (_daftarMahasiswa.isEmpty) {
      return _emptyState(
        'Belum ada data mahasiswa.\nTekan "+ Tambah" untuk menambahkan.',
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _daftarMahasiswa.length,
      itemBuilder: (context, i) {
        final mhs = _daftarMahasiswa[i];
        return KartuMahasiswa(
          mahasiswa: mhs,
          onTap: () => _bukaDetailMahasiswa(mhs),
          onEdit: () => _bukaFormMahasiswa(mhsEdit: mhs),
          onDelete: () => _hapusMahasiswa(mhs),
        );
      },
    );
  }

  Widget _tabMataKuliah() {
    if (_daftarMataKuliah.isEmpty) {
      return _emptyState(
        'Belum ada data mata kuliah.\nTekan "+ Tambah" untuk menambahkan.',
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _daftarMataKuliah.length,
      itemBuilder: (context, i) {
        final mk = _daftarMataKuliah[i];
        return KartuMataKuliah(
          mataKuliah: mk,
          onEdit: () => _bukaFormMataKuliah(mkEdit: mk),
          onDelete: () => _hapusMataKuliah(mk),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMahasiswa = _tabAktif == 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Akademik'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: isMahasiswa ? _tabMahasiswa() : _tabMataKuliah(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            isMahasiswa ? _bukaFormMahasiswa() : _bukaFormMataKuliah(),
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabAktif,
        onDestinationSelected: (i) => setState(() => _tabAktif = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.people), label: 'Mahasiswa'),
          NavigationDestination(
            icon: Icon(Icons.menu_book),
            label: 'Mata Kuliah',
          ),
        ],
      ),
    );
  }
}
