import 'package:flutter/material.dart';
import 'package:mqfm_apps/controller/categories/categories_controller.dart';
import 'package:mqfm_apps/model/categories/categories_model.dart';
import 'package:mqfm_apps/utils/helpers/log_helper.dart';

class DashboardLogic extends ChangeNotifier {
  final CategoryController _categoryController = CategoryController();

  List<Category> categories = [
    Category(
      id: 0,
      name: "Semua",
      description: "All",
      createdAt: "",
      updatedAt: "",
    ),
  ];

  int selectedIndex = 0;
  bool isLoading = true;

  DashboardLogic() {
    _fetchCategories();
  }

  void selectCategory(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  int get currentCategoryId => categories[selectedIndex].id;

  Future<void> _fetchCategories() async {
    try {
      LogHelper.info("DashboardLogic", "Fetching categories...");
      final response = await _categoryController.getAllCategories();

      if (response.status == 200 && response.data != null) {
        categories.addAll(response.data!);
        isLoading = false;
        LogHelper.success(
          "DashboardLogic",
          "Fetched ${response.data!.length} categories",
        );
        notifyListeners();
      } else {
        // Silently fail or log, strictly following original which only logged "Gagal..." in debugPrint
        // But logic sets isLoading false on failure in original.
        isLoading = false;
        LogHelper.error(
          "DashboardLogic",
          "Failed to fetch categories: ${response.message}",
        );
        notifyListeners();
      }
    } catch (e, stackTrace) {
      LogHelper.error(
        "DashboardLogic",
        "Exception fetching categories",
        stackTrace,
      );
      isLoading = false;
      notifyListeners();
    }
  }
}
