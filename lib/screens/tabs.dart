import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

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
  Map<Filter, bool> filterStates = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };

  void showInfoMessage(String message, Meal meal) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            _toggleMealFunctionStatus(meal);
          },
        ),
      ),
    );
  }

  void _toggleMealFunctionStatus(Meal meal) {
    bool exists = favoriteMeals.contains(meal);

    if (exists) {
      setState(() {
        favoriteMeals.remove(meal);
      });
      showInfoMessage("${meal.title} removed from Favorites", meal);
    } else {
      setState(() {
        favoriteMeals.add(meal);
        showInfoMessage("${meal.title} added to Favorites", meal);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var activePageTitle = 'Categories';
    // final availableMeals = dummyMeals.where((element) {
    //   if(filterStates[GlutenFree])
    // },);
    Widget bodyContent = Categories(
      addToFavorites: _toggleMealFunctionStatus,
    );
    if (_currentBottomNavigationBarIndex == 1) {
      bodyContent = Meals(
        category: Category(
          id: '1',
          title: 'Favorites',
        ),
        mealsList: favoriteMeals,
        addToFavorites: (meal) {
          _toggleMealFunctionStatus(meal);
        },
      );

      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          activePageTitle,
        ),
      ),
      drawer: SafeArea(
        // minimum: const EdgeInsets.only(top: 40),
        child: MainDrawer(
          onSelectScreen: (type) async {
            Navigator.of(context).pop(true);
            var res = await Navigator.of(context).push<Map<Filter, bool>>(
              MaterialPageRoute(
                builder: (context) {
                  return type == 'Meals'
                      ? const TabsScreen()
                      : const FilterScreen();
                },
              ),
            );

            setState(() {
              filterStates = res ??
                  {
                    Filter.glutenFree: false,
                    Filter.lactoseFree: false,
                    Filter.vegetarian: false,
                    Filter.vegan: false,
                  };
            });
          },
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
