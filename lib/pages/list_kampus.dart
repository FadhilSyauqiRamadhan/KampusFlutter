import 'package:flutter/material.dart';
import 'package:kampus_flutter/pages/tambah_kampus.dart';
import '../models/kampus.dart';
import '../services/kampus_services.dart';
import 'detail_kampus_page.dart';

class ListKampusPage extends StatefulWidget {
  @override
  State<ListKampusPage> createState() => _ListKampusPageState();
}

class _ListKampusPageState extends State<ListKampusPage> {
  List<Kampus> _kampusList = [];
  List<Kampus> _filteredKampusList = [];
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getKampus();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String keyword = _searchController.text.toLowerCase();
    setState(() {
      _filteredKampusList = _kampusList
          .where((k) => k.nama.toLowerCase().contains(keyword))
          .toList();
    });
  }

  Future<void> _getKampus() async {
    setState(() => _isLoading = true);
    final kampusList = await KampusService.fetchAll();
    setState(() {
      _kampusList = kampusList;
      _filteredKampusList = kampusList;
      _isLoading = false;
    });
  }

  Future<void> _hapusKampus(int id) async {
    await KampusService.delete(id);
    _getKampus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            "Kampus\nIndonesia",
            style: TextStyle(
              color: Colors.blue[900],
              fontWeight: FontWeight.bold,
              fontSize: 28,
              letterSpacing: 1.2,
              height: 1.1,
            ),
          ),
        ),
        toolbarHeight: 90,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Cari kampus...",
                      prefixIcon: Icon(Icons.search, color: Colors.blue[900]),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : _filteredKampusList.isEmpty
                          ? Center(child: Text("Data tidak ditemukan"))
                          : ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              itemCount: _filteredKampusList.length,
                              separatorBuilder: (_, __) => SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                final k = _filteredKampusList[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 8,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(16),
                                        width: 56,
                                        height: 56,
                                        decoration: BoxDecoration(
                                          color: Colors.blue[900],
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Icon(Icons.school, color: Colors.white, size: 32),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 16, right: 16, bottom: 16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                k.nama,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.blue[900],
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(Icons.location_on, color: Colors.blue[300], size: 16),
                                                  SizedBox(width: 4),
                                                  Expanded(
                                                    child: Text(
                                                      k.alamat,
                                                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(Icons.phone, color: Colors.blue[300], size: 16),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    k.noTelpon,
                                                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(Icons.category, color: Colors.blue[300], size: 16),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    k.kategori,
                                                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(Icons.book, color: Colors.blue[300], size: 16),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    k.jurusan,
                                                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  OutlinedButton.icon(
                                                    style: OutlinedButton.styleFrom(
                                                      foregroundColor: Colors.blue[900],
                                                      side: BorderSide(color: Colors.blue[900]!),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                    ),
                                                    icon: Icon(Icons.info_outline),
                                                    label: Text("Detail"),
                                                    onPressed: () async {
                                                      await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (_) => DetailKampusPage(id: k.id!),
                                                        ),
                                                      );
                                                      _getKampus();
                                                    },
                                                  ),
                                                  SizedBox(width: 8),
                                                  OutlinedButton.icon(
                                                    style: OutlinedButton.styleFrom(
                                                      foregroundColor: Colors.red[700],
                                                      side: BorderSide(color: Colors.red[700]!),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                    ),
                                                    icon: Icon(Icons.delete_outline),
                                                    label: Text("Hapus"),
                                                    onPressed: () => _hapusKampus(k.id!),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                ),
                SizedBox(height: 70),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                icon: Icon(Icons.add, size: 24),
                label: Text(
                  "Tambah Kampus",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 6,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => TambahKampusPage()),
                  ).then((_) => _getKampus());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}