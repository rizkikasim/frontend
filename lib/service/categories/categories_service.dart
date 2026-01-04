import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mqfm_apps/model/categories/categories_model.dart';
// Pastikan import model di atas sesuai dengan nama file Anda

class CategoryService {
  // GANTI URL INI DENGAN NGROK TERBARU ANDA
  static const String domainUrl =
      'https://crispate-lawlessly-kadence.ngrok-free.dev';

  // Base URL (Diakhiri slash agar mudah ditambah ID)
  static const String baseUrl = '$domainUrl/api/categories/';

  // --- GET ALL CATEGORIES ---
  Future<CategoryResponse> getCategories() async {
    try {
      log("GET Request ke: $baseUrl");

      final response = await http.get(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'ngrok-skip-browser-warning': 'true',
        },
      );

      log("Status Category: ${response.statusCode}");

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final json = jsonDecode(response.body);
        return CategoryResponse.fromJson(json);
      } else {
        throw Exception("Gagal memuat kategori: ${response.statusCode}");
      }
    } catch (e) {
      log("Error Service Category: $e");
      throw Exception(e.toString());
    }
  }

  // --- GET CATEGORY BY ID (DETAIL) ---
  Future<SingleCategoryResponse> getCategoryById(int id) async {
    try {
      // Menggabungkan Base URL dengan ID (Contoh: .../api/categories/1)
      final url = '$baseUrl$id';
      log("GET Detail Request ke: $url");

      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'ngrok-skip-browser-warning': 'true',
        },
      );

      log("Status Detail Category: ${response.statusCode}");

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final json = jsonDecode(response.body);
        // Gunakan SingleCategoryResponse karena datanya cuma satu
        return SingleCategoryResponse.fromJson(json);
      } else {
        throw Exception("Gagal memuat detail kategori: ${response.statusCode}");
      }
    } catch (e) {
      log("Error Service Detail Category: $e");
      throw Exception(e.toString());
    }
  }
}
