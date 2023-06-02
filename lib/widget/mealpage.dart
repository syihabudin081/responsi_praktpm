import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsi_praktpm/models/category.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsi_praktpm/widget/mealdetail.dart';
import '../services/api_service.dart';

class MealPage extends StatefulWidget {
  String mealcategory;

  MealPage({Key? key, required this.mealcategory}) : super(key: key);

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {

  final ApiService _apiService = ApiService();
  List<Meal> _meals = [];
  bool _isLoading = false;
  

 Future<void> _getFoodByCategories(String categories) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final mealitem = await _apiService.getFoodByCategory(categories);
      if (mounted) {
        setState(() {
          _meals = mealitem;
        });
      }
    } catch (e) {
      // Handle error here
      debugPrint('Error: $e');
    } finally {
      if (mounted) {
        print(_meals);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getFoodByCategories(widget.mealcategory);
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
                itemCount: _meals.length,
                itemBuilder: (context, index) {
                  final meal = _meals[index];

                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: SizedBox(
                        width: 80.0, // Provide a specific width here
                        child: meal.thumbnail.isNotEmpty
                            ? Image.network(meal.thumbnail)
                            : Container(),
                      ),
                      title: Text(
                        meal.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  MealDetailPage(mealId: meal.id,)  ));
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

