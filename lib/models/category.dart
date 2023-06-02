class Category {
  final String id;
  final String name;
  final String thumbnail;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.description,
  });
}

class Meal {
  final String id;
  final String name;
  final String thumbnail;

  Meal({
    required this.id,
    required this.name,
    required this.thumbnail,
  });
}

class MealDetail {
  final String id;
  final String name;
  final String thumbnail;
  final String area;
  final String category;
  final String instruction;
  final String link;

  MealDetail(
      {
      required this.id,
      required this.name,
      required this.thumbnail,
      required this.area,
      required this.category,
      required this.instruction,
      required this.link, 
      });
}
