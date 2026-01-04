class CategoryResponse {
  final int status;
  final String message;
  final List<Category>? data;

  CategoryResponse({required this.status, required this.message, this.data});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Category.fromJson(i)).toList()
          : null,
    );
  }
}

class Category {
  final int id;
  final String name;
  final String description;
  // [BARU] Tambahkan ini agar error 'createdAt undefined' hilang
  final String? createdAt;
  final String? updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: json['created_at'], // Mapping dari JSON
      updatedAt: json['updated_at'], // Mapping dari JSON
    );
  }
}

class SingleCategoryResponse {
  final int status;
  final String message;
  final Category? data;

  SingleCategoryResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory SingleCategoryResponse.fromJson(Map<String, dynamic> json) {
    return SingleCategoryResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? Category.fromJson(json['data']) : null,
    );
  }
}
