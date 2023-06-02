import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsi_praktpm/models/category.dart';
import 'package:responsi_praktpm/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:responsi_praktpm/widget/mealpage.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final ApiService _apiService = ApiService();
  List<Category> _categories = [];
  bool _isLoading = false;

  Future<void> _getFoodCategories() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final categoryitem = await _apiService.getFoodCategory();
      if (mounted) {
        setState(() {
          _categories = categoryitem;
        });
      }
    } catch (e) {
      // Handle error here
      debugPrint('Error: $e');
    } finally {
      if (mounted) {
        print(_categories);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getFoodCategories();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Food categories'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];

                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: SizedBox(
                        width: 80.0, // Provide a specific width here
                        child: category.thumbnail.isNotEmpty
                            ? Image.network(category.thumbnail)
                            : Container(),
                      ),
                      title: Text(
                        category.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                        
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MealPage( mealcategory: category.name)));
                      },
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
