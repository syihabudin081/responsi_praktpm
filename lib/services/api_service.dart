import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:responsi_praktpm/models/category.dart';

class ApiService {
  static const String _baseUrlCategory =
      'https://www.themealdb.com/api/json/v1/1/categories.php';

  static const String _foodByCategory =
      'https://www.themealdb.com/api/json/v1/1/filter.php?';

  static const String _foodDetail = 'http://www.themealdb.com/api/json/v1/1/lookup.php?';

  Future<List<Category>> getFoodCategory() async {
    final url = Uri.parse('$_baseUrlCategory');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      final List<Category> categoryitem = [];
      final List<dynamic> categories = json['categories'];

      for (final item in categories) {
        print(item);
        final category = Category(
            name: item['strCategory'],
            id: item['idCategory'],
            thumbnail: item['strCategoryThumb'],
            description: item['strCategoryDescription']);

        categoryitem.add(category);
      }

      return categoryitem;
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<Meal>> getFoodByCategory(String category) async {
    final url = Uri.parse('$_foodByCategory' + 'c=$category');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      final List<Meal> Mealitem = [];
      final List<dynamic> meals = json['meals'];

      for (final item in meals) {
        final meal = Meal(
          name: item['strMeal'],
          id: item['idMeal'],
          thumbnail: item['strMealThumb'],
        );

        Mealitem.add(meal);
      }

      return Mealitem;
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<MealDetail>> getFoodDetail(String id) async {
    final url = Uri.parse('$_foodDetail' + 'i=$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      final List<MealDetail> Meal = [];
      final List<dynamic> meal = json['meals'];

      for (final item in meal) {
        final meal = MealDetail(
          name: item['strMeal'],
          id: item['idMeal'],
          thumbnail: item['strMealThumb'],
          area: item['strArea'],
          category: item['strCategory'],
          instruction: item['strInstructions'],
          link: item['strYoutube']
        );

        Meal.add(meal);
      }

      return Meal;
    } else {
      throw Exception('Failed to load books');
    }
  }
}
