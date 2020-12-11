

import 'package:provider/provider.dart';

import './dummy_data.dart';
import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import 'package:flutter/material.dart';



import 'models/meal.dart';
import 'provider/favorite_provider.dart';
import 'screens/Categories_Screen.dart';
import 'screens/catergory_meals_screen.dart';
import 'screens/meal_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'vegetarian': false,
    'vegan': false,
    'lactose': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData; //stores changes from filter_screen

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorites(String mealId) { 
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId); //gets index in of meal in favorit list

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);//if greater than 0 the meal is found in list and is removed
      });
    }
    else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));//is added to fovorites
      });
    }
  }

  bool _isMealFavorite(String mealId){
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
          create: (ctx) => Favorites(),
          child: MaterialApp(
        title: 'DeliMeals',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline6: TextStyle(
                  fontSize: 24,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        home: TabsSrceen(_favoriteMeals),
        routes: {
          CategoryMealsScreen.routeName: (ctx) =>
              CategoryMealsScreen(_availableMeals),
          MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorites, _isMealFavorite),
          FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
        },
        onGenerateRoute: (settings) {
          print(settings.arguments);
          return MaterialPageRoute(
            builder: (ctx) => CategoriesScreen(),
          );
        },
      ),
    );
  }
}
