import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/kampus.dart';

class KampusService {
  static const String baseUrl = 'http://10.126.12.117:8000/api/kampus'; // Ganti sesuai API kamu

  static Future<List<Kampus>> fetchAll() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Kampus.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  static Future<Kampus> fetchById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Kampus.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memuat detail');
    }
  }

  static Future<void> create(Kampus kampus) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(kampus.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Gagal menambah data');
    }
  }

  static Future<void> update(int id, Kampus kampus) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(kampus.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal mengupdate data');
    }
  }

  static Future<void> delete(int id) async {
  final response = await http.delete(Uri.parse('$baseUrl/$id'));
  // Terima status 200 (OK) atau 204 (No Content) sebagai sukses
  if (response.statusCode != 200 && response.statusCode != 204) {
    print('Delete failed: ${response.statusCode} - ${response.body}');
    throw Exception('Gagal menghapus data');
  }
}
}