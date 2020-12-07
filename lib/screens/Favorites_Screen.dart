import '../widgets/meal_item.dart';

import '../models/meal.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  FavoritesScreen(this.favoriteMeals);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.favoriteMeals.isEmpty) {
      return Center(
        child: Text('Favorites are Empty - start adding some'),
      );
    } else return Center(
        child: ListView.builder(
          itemBuilder: (ctx, index) { //builds a list of meal Items
            return MealItem(
              id: widget.favoriteMeals[index].id,
              title: widget.favoriteMeals[index].title,
              imageUrl: widget.favoriteMeals[index].imageUrl,
              duration: widget.favoriteMeals[index].duration,
              complexity: widget.favoriteMeals[index].complexity,
              affordability: widget.favoriteMeals[index].affordability,
            );
          },
          itemCount: widget.favoriteMeals.length, //determines the number of items built
        ),
      );
  }
 
}
