
import '../widgets/meal_item.dart';
import '../models/meal.dart';
import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle; 
  List<Meal> displayedMeals;
  var _loadedInintData = false;

  
  @override
  void didChangeDependencies() { ///
    if (_loadedInintData == false)
      {final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>; //recieved from category title & id as arguments        
    categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];

    displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId); 
    }).toList();//goes through all available meals and returns those with matching Category Id's to the current category displayed
    
    super.didChangeDependencies();
    _loadedInintData = true;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle + ' Recipes'),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              imageUrl: displayedMeals[index].imageUrl,
              duration: displayedMeals[index].duration,
              complexity: displayedMeals[index].complexity,
              affordability: displayedMeals[index].affordability,
            );
          },
          itemCount: displayedMeals.length, 
        ),
      ),
    );
  }
}
