import 'package:flutter/material.dart';
import '../models/kampus.dart';
import '../services/kampus_services.dart';

class UpdateKampusPage extends StatefulWidget {
  final Kampus kampus;
  UpdateKampusPage({required this.kampus});

  @override
  State<UpdateKampusPage> createState() => _UpdateKampusPageState();
}

class _UpdateKampusPageState extends State<UpdateKampusPage> {
  final _formKey = GlobalKey<FormState>();
  late String nama;
  late String alamat;
  late String noTelpon;
  late String kategori;
  late double latitude;
  late double longitude;
  late String jurusan;

  @override
  void initState() {
    super.initState();
    nama = widget.kampus.nama;
    alamat = widget.kampus.alamat;
    noTelpon = widget.kampus.noTelpon;
    kategori = widget.kampus.kategori;
    latitude = widget.kampus.latitude;
    longitude = widget.kampus.longitude;
    jurusan = widget.kampus.jurusan;
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Kampus kampus = Kampus(
        id: widget.kampus.id,
        nama: nama,
        alamat: alamat,
        noTelpon: noTelpon,
        kategori: kategori,
        latitude: latitude,
        longitude: longitude,
        jurusan: jurusan,
      );
      await KampusService.update(kampus.id!, kampus);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6F0FA),
      appBar: AppBar(
        title: Text('Edit Kampus'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue[900]),
        titleTextStyle: TextStyle(
          color: Colors.blue[900],
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 38,
                        backgroundColor: Colors.blue[900],
                        child: Icon(Icons.school, color: Colors.white, size: 38),
                      ),
                      SizedBox(height: 18),
                      Text(
                        "Perbarui Data Kampus",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),
                      _buildTextField(
                        label: 'Nama Kampus',
                        initialValue: nama,
                        onSaved: (v) => nama = v!,
                      ),
                      _buildTextField(
                        label: 'Alamat Lengkap',
                        initialValue: alamat,
                        onSaved: (v) => alamat = v!,
                      ),
                      _buildTextField(
                        label: 'No Telpon',
                        initialValue: noTelpon,
                        onSaved: (v) => noTelpon = v!,
                        keyboardType: TextInputType.phone,
                      ),
                      _buildDropdownKategori(),
                      _buildTextField(
                        label: 'Latitude',
                        initialValue: latitude.toString(),
                        onSaved: (v) => latitude = double.parse(v!),
                        keyboardType: TextInputType.number,
                      ),
                      _buildTextField(
                        label: 'Longitude',
                        initialValue: longitude.toString(),
                        onSaved: (v) => longitude = double.parse(v!),
                        keyboardType: TextInputType.number,
                      ),
                      _buildTextField(
                        label: 'Jurusan',
                        initialValue: jurusan,
                        onSaved: (v) => jurusan = v!,
                      ),
                      SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton.icon(
                          onPressed: submit,
                          icon: Icon(Icons.save),
                          label: Text('Update', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    String? initialValue,
    required FormFieldSetter<String> onSaved,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
        validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null,
        onSaved: onSaved,
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildDropdownKategori() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: kategori,
        items: ['Swasta', 'Negeri']
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (v) => setState(() => kategori = v!),
        onSaved: (v) => kategori = v!,
        decoration: InputDecoration(
          labelText: 'Kategori',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}