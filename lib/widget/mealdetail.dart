import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsi_praktpm/models/category.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';

class MealDetailPage extends StatefulWidget {
  String mealId;
  
  MealDetailPage({Key? key, required this.mealId}) : super(key: key);

  @override
  State<MealDetailPage> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {

    final ApiService _apiService = ApiService();
  List<MealDetail> _meal = [];
  bool _isLoading = false;


 Future<void> _getFoodDetail(String id) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final mealitem = await _apiService.getFoodDetail(id);
      if (mounted) {
        setState(() {
          _meal = mealitem;
        });
      }
    } catch (e) {
      // Handle error here
      debugPrint('Error: $e');
    } finally {
      if (mounted) {
        print(_meal);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

 @override
  void initState() {
    super.initState();
    _getFoodDetail(widget.mealId);
  }


 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Meal Detail'),
    ),
    body: _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: _meal.length,
            itemBuilder: (context, index) {
              final meal = _meal[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  Image.network(meal.thumbnail),
                  Text('Name: ${meal.name}',
                  textAlign: TextAlign.center,
                  style:TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    
                  ) ,), // Display the thumbnail image
                  Text('Area: ${meal.area}',style:TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ) ,),
                  Text('Category: ${meal.category}',style:TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ) ,),
                  SizedBox(height: 14,),
                  Text('Instruction: ${meal.instruction}',style:TextStyle(
                    fontSize: 10,
                   
                  ) ,),
                    IconButton(
                  onPressed: () {
                    launchURL(meal.link);
                  },
                  icon: const Icon(
                    Icons.video_file,
                  ),
                  iconSize: 35,
                
                ),
                ],
              );
            },
          ),
  );
}

}

Future<void> launchURL(String url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}