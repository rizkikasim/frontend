import 'package:mqfm_apps/model/categories/categories_model.dart';
import 'package:mqfm_apps/service/categories/categories_service.dart';

class CategoryController {
  final CategoryService _categoryService = CategoryService();

  // Get Semua
  Future<CategoryResponse> getAllCategories() async {
    return await _categoryService.getCategories();
  }

  // Get Satu (Detail)
  Future<SingleCategoryResponse> getDetailCategory(int id) async {
    return await _categoryService.getCategoryById(id);
  }
}
