import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final void Function(Meal meal) addToFavorites;
  const CategoryCard({super.key, required this.category, required this.addToFavorites});

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    var nextRoute = MaterialPageRoute(
      builder: (context) {
        return Meals(
          category: category,
          mealsList: filteredMeals,
          addToFavorites: addToFavorites,
        );
      },
    );

    Navigator.push(context,
        nextRoute); // Navigator.of(context).push(route) < Also works here >
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      autofocus: true,
      // hoverColor: Theme.of(context).hoverColor,
      // hoverDuration: const Duration(seconds: 5),
      splashColor: Theme.of(context).splashColor,
      onTap: () {
        _selectCategory(context, category);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        key: ValueKey(category.id),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.56),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        // I was using the card widget before but could not style it better.
        // child: Card(
        //   key: ValueKey(category.id),
        //   color: Colors.transparent,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(
        //       10,
        //     ),
        //   ),
        //   child: Center(
        //     child: Padding(
        //       padding: const EdgeInsets.all(0),
        //       child: Text(
        //         category.title,
        //         style: const TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontStyle: FontStyle.normal,
        //           fontSize: 20,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }
}
