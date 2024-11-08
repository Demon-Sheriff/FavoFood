import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  var _currentBottomNavigationBarIndex = 0;
  Map<Filter, bool> filterStates = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };

  void showInfoMessage(String message, Meal meal) {}

  @override
  Widget build(BuildContext context) {
    var activePageTitle = 'Categories';
    final availableMeals = dummyMeals.where((meal) {
      if (filterStates[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (filterStates[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (filterStates[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (filterStates[Filter.vegan]! && !meal.isVegan) {
        return false;
      }

      return true;
    }).toList();

    Widget bodyContent = Categories(
      preferredMeals: availableMeals,
    );
    if (_currentBottomNavigationBarIndex == 1) {
      final favoriteList = ref.watch(favoriteMealsProvider);
      bodyContent = Meals(
        category: Category(
          id: '1',
          title: 'Favorites',
        ),
        mealsList: favoriteList,
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
            Navigator.of(context).pop();
            var res = await Navigator.of(context).push<Map<Filter, bool>>(
              MaterialPageRoute(
                builder: (context) {
                  return type == 'Meals'
                      ? const TabsScreen()
                      : FilterScreen(
                          currFilters: filterStates,
                        );
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
