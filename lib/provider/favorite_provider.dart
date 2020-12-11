import '../dummy_data.dart';
import '../models/meal.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

class Favorites with ChangeNotifier{
List<Meal> _favoriteMeals = [];

  void _toggleFavorites(String mealId) { 
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId); //gets index in of meal in favorit list

    if (existingIndex >= 0) {

        _favoriteMeals.removeAt(existingIndex);//if greater than 0 the meal is found in list and is removed
   ;
    }
    else {

        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));//is added to fovorites

    }
  }

  bool _isMealFavorite(String mealId){
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }
}

