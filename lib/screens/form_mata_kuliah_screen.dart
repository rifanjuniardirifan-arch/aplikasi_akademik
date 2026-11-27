// lib/screens/form_mata_kuliah_screen.dart
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import '../models/mata_kuliah.dart';
import '../services/akademik_service.dart';

class FormMataKuliahScreen extends StatefulWidget {
  /// null = mode Tambah, terisi = mode Edit
  final MataKuliah? mkEdit;

  const FormMataKuliahScreen({super.key, this.mkEdit});

  @override
  State<FormMataKuliahScreen> createState() => _FormMataKuliahScreenState();
}

class _FormMataKuliahScreenState extends State<FormMataKuliahScreen> {
  final _formKey = GlobalKey<FormState>();
  final _kodeCtrl = TextEditingController();
  final _namaCtrl = TextEditingController();
  final _sksCtrl = TextEditingController();
  final _semCtrl = TextEditingController();
  final _dosenCtrl = TextEditingController();

  bool get _isEdit => widget.mkEdit != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      final m = widget.mkEdit!;
      _kodeCtrl.text = m.kode;
      _namaCtrl.text = m.namaMk;
      _sksCtrl.text = m.sks.toString();
      _semCtrl.text = m.semester.toString();
      _dosenCtrl.text = m.dosenPengampu;
    }
  }

  @override
  void dispose() {
    _kodeCtrl.dispose();
    _namaCtrl.dispose();
    _sksCtrl.dispose();
    _semCtrl.dispose();
    _dosenCtrl.dispose();
    super.dispose();
  }

  void _simpan() {
    if (_formKey.currentState!.validate()) {
      final hasil = MataKuliah(
        id: _isEdit
            ? widget.mkEdit!.id
            : 'MK${DateTime.now().millisecondsSinceEpoch}',
        kode: _kodeCtrl.text.trim(),
        namaMk: _namaCtrl.text.trim(),
        sks: int.parse(_sksCtrl.text.trim()),
        semester: int.parse(_semCtrl.text.trim()),
        dosenPengampu: _dosenCtrl.text.trim(),
      );
      Navigator.pop(context, hasil);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Mata Kuliah' : 'Tambah Mata Kuliah'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _kodeCtrl,
                decoration: const InputDecoration(
                  labelText: 'Kode MK',
                  border: OutlineInputBorder(),
                ),
                validator: AkademikService.validasiKode,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _namaCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nama Mata Kuliah',
                  border: OutlineInputBorder(),
                ),
                validator: AkademikService.validasiNamaMk,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _sksCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'SKS (1-6)',
                  border: OutlineInputBorder(),
                ),
                validator: AkademikService.validasiSks,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _semCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Semester (1-14)',
                  border: OutlineInputBorder(),
                ),
                validator: AkademikService.validasiSemester,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _dosenCtrl,
                decoration: const InputDecoration(
                  labelText: 'Dosen Pengampu',
                  border: OutlineInputBorder(),
                ),
                validator: AkademikService.validasiDosen,
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _simpan,
                icon: const Icon(Icons.save),
                label: Text(_isEdit ? 'Simpan Perubahan' : 'Simpan Baru'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
