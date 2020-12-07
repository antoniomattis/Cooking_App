import '../models/meal.dart';

import '../widgets/main_drawer.dart';

import '../screens/Favorites_Screen.dart';

import '../screens/Categories_Screen.dart';
import 'package:flutter/material.dart';


class TabsSrceen extends StatefulWidget {

  final List<Meal> favoriteMeals;

   TabsSrceen(this.favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsSrceen> {
   List<Map<String, Object>> _pages;
  int _selectedPageindex = 0; 

  @override
  void initState() {
  _pages = [
    {
      'page': CategoriesScreen(),
      'title': 'Categories',
    },
    {
      'page': FavoritesScreen(widget.favoriteMeals),
      'title': 'Your Favorites',
    }
  ];
    super.initState();
  }
  void _selectPage(int index) {
    setState(() {
      _selectedPageindex = index; //page selection based on 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageindex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageindex]['page'],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: Theme.of(context).primaryColor),
        child: BottomNavigationBar(
          onTap: _selectPage, //uses _selectPage method to change the display body and title based on the selected page index
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedPageindex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorites',
            ),
          ],
        ),
      ),
    );
  }
}
