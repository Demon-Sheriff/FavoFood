import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/favorites_list.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  List<Meal> favoriteMeals = [];
  var _currentBottomNavigationBarIndex = 0;

  void _toggleMealFunctionStatus() {

  }
  
  @override
  Widget build(BuildContext context) {
    var activePageTitle = 'Categories';

    Widget bodyContent = const Categories();
    if (_currentBottomNavigationBarIndex == 1) {
      bodyContent = Meals(
        category: Category(
          id: '1',
          title: 'Favorites',
        ),
        mealsList: favoriteMeals,
      );

      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          activePageTitle,
        ),
      ),
      body: bodyContent,
      // bottom tab for navigation.
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentBottomNavigationBarIndex = index;
          });
        },
        currentIndex: _currentBottomNavigationBarIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
