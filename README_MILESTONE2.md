# LAPORAN PRAKTIK MILESTONE 2 – CRUD APLIKASI AKADEMIK

**Nama / NIM :** (isi sendiri)
**Tautan GitHub :** (isi sendiri)
**AI Tools Dipakai :** Claude (isi sesuai yang benar-benar kamu pakai)
**Fitur Kustomisasi :** [ ] Opsi 1 (Live Search)  [ ] Opsi 2 (Ringkasan)  [x] Opsi 3 (Undo)

## 1. Jejak Prompt AI (Minimal 3 Prompt)
(Isi dengan prompt ASLI yang kamu kirim ke AI, bukan karangan.)

1. Prompt 1 (Model/Struktur): "..." → Penyesuaian yang dilakukan sendiri: ...
2. Prompt 2 (Form Dual-Mode / CRUD): "..." → Penyesuaian yang dilakukan sendiri: ...
3. Prompt 3 (Debugging / Fitur Tambahan): "..." → Error yang sempat muncul & solusinya: ...

## 2. Pertanyaan Verifikasi Pemahaman
(Tulis ulang dengan kata-katamu sendiri setelah paham. Poin-poin di bawah hanya acuan.)

1. **Mengapa nilai awal controller diisi di `initState()`, bukan di `build()`?**
   - `initState()` hanya dipanggil sekali saat halaman dibuat. `build()` dipanggil
     berulang setiap ada `setState()` atau perubahan layar. Kalau `controller.text`
     diisi di `build()`, teks yang sedang diketik pengguna akan tertimpa data lama
     setiap kali layar digambar ulang.

2. **Bagaimana Dashboard membedakan Create dan Update?**
   - Lewat parameter `mhsEdit` / `mkEdit` pada `_bukaFormMahasiswa` / `_bukaFormMataKuliah`.
     Jika `null` berarti Tambah, maka objek hasil form dimasukkan dengan `.add()`.
     Jika terisi berarti Edit, maka dicari posisinya dengan `indexWhere` berdasarkan
     `id`, lalu ditimpa: `_daftar[idx] = hasil`. `id` tidak berubah, sehingga tidak ada kartu ganda.

3. **Apa yang terjadi bila pengguna mengetuk area gelap di luar AlertDialog?**
   - Dialog tertutup dan `showDialog<bool>` mengembalikan `null` (bukan `true`/`false`).
     Kode memakai `return yakin == true`, jadi `null` dianggap `false`: data TIDAK terhapus,
     sama seperti menekan Batal.

## 3. Hasil Code Review Sejawat
Nama Reviewer: (isi)
Catatan/Saran: (isi)
