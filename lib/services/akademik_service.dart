// lib/services/akademik_service.dart
import '../models/mahasiswa.dart';
import '../models/mata_kuliah.dart';

class AkademikService {
  // ---------- SEED DATA ----------
  static List<Mahasiswa> ambilDataAwalMahasiswa() {
    return [
      const Mahasiswa(
        id: 'M001',
        nim: '2023001',
        nama: 'Rina Amelia',
        prodi: 'Sistem Informasi',
        semester: 5,
        email: 'rina@uinjambi.ac.id',
        ipk: 3.75,
      ),
      const Mahasiswa(
        id: 'M002',
        nim: '2023002',
        nama: 'Budi Santoso',
        prodi: 'Sistem Informasi',
        semester: 5,
        email: 'budi@uinjambi.ac.id',
        ipk: 3.40,
      ),
      const Mahasiswa(
        id: 'M003',
        nim: '2023003',
        nama: 'Siti Nurhaliza',
        prodi: 'Sistem Informasi',
        semester: 3,
        email: 'siti@uinjambi.ac.id',
        ipk: 3.90,
      ),
    ];
  }

  static List<MataKuliah> ambilDataAwalMataKuliah() {
    return [
      const MataKuliah(
        id: 'MK01',
        kode: 'SIF65005',
        namaMk: 'Pemrograman Mobile',
        sks: 4,
        semester: 5,
        dosenPengampu: 'Dr. Ahmad Fauzi, M.Kom.',
      ),
      const MataKuliah(
        id: 'MK02',
        kode: 'SIF65002',
        namaMk: 'Rekayasa Perangkat Lunak',
        sks: 3,
        semester: 5,
        dosenPengampu: 'Dewi Lestari, M.T.',
      ),
      const MataKuliah(
        id: 'MK03',
        kode: 'SIF65003',
        namaMk: 'Basis Data',
        sks: 3,
        semester: 3,
        dosenPengampu: 'Rudi Hartono, M.Cs.',
      ),
    ];
  }

  // ---------- VALIDATOR MAHASISWA ----------
  static String? validasiNama(String? nilai) {
    final teks = nilai?.trim() ?? '';
    if (teks.isEmpty) return 'Nama wajib diisi';
    if (teks.length < 3) return 'Minimal 3 karakter';
    return null;
  }

  static String? validasiNim(String? nilai) {
    final teks = nilai?.trim() ?? '';
    if (teks.isEmpty) return 'NIM wajib diisi';
    if (!RegExp(r'^[0-9]+$').hasMatch(teks)) return 'NIM hanya boleh angka';
    if (teks.length < 7) return 'NIM minimal 7 digit';
    return null;
  }

  static String? validasiEmail(String? nilai) {
    final teks = nilai?.trim() ?? '';
    if (teks.isEmpty) return 'Email wajib diisi';
    final pola = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');
    if (!pola.hasMatch(teks)) return 'Format email tidak valid';
    return null;
  }

  static String? validasiSemester(String? nilai) {
    final angka = int.tryParse(nilai?.trim() ?? '');
    if (angka == null || angka < 1 || angka > 14) {
      return 'Semester harus angka 1 sampai 14';
    }
    return null;
  }

  static String? validasiIpk(String? nilai) {
    final teks = (nilai ?? '').trim().replaceAll(',', '.');
    if (teks.isEmpty) return 'IPK wajib diisi';
    final angka = double.tryParse(teks);
    if (angka == null) return 'IPK harus berupa angka';
    if (angka < 0.0 || angka > 4.0) return 'IPK harus antara 0.0 sampai 4.0';
    return null;
  }

  // ---------- VALIDATOR MATA KULIAH ----------
  static String? validasiKode(String? nilai) {
    final teks = nilai?.trim() ?? '';
    if (teks.isEmpty) return 'Kode MK wajib diisi';
    if (teks.length < 5) return 'Kode MK minimal 5 karakter';
    return null;
  }

  static String? validasiNamaMk(String? nilai) {
    final teks = nilai?.trim() ?? '';
    if (teks.isEmpty) return 'Nama mata kuliah wajib diisi';
    if (teks.length < 3) return 'Minimal 3 karakter';
    return null;
  }

  static String? validasiSks(String? nilai) {
    final angka = int.tryParse(nilai?.trim() ?? '');
    if (angka == null || angka < 1 || angka > 6) {
      return 'SKS harus angka 1 sampai 6';
    }
    return null;
  }

  static String? validasiDosen(String? nilai) {
    final teks = nilai?.trim() ?? '';
    if (teks.isEmpty) return 'Dosen pengampu wajib diisi';
    if (teks.length < 3) return 'Minimal 3 karakter';
    return null;
  }
}
