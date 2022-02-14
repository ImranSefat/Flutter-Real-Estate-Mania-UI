class CategoryModel {
  String title;
  String assetPath;
  CategoryModel({
    required this.title,
    required this.assetPath,
  });
}

List<CategoryModel> categories = [
  CategoryModel(title: 'Resort', assetPath: 'resort.jpeg'),
  CategoryModel(title: 'Cottage', assetPath: 'cottage.jpeg'),
  CategoryModel(title: 'Office', assetPath: 'office.jpeg'),
  CategoryModel(title: 'Urban', assetPath: 'urban.jpeg'),
];
