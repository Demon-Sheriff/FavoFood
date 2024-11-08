import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/category_card.dart';

class Categories extends StatelessWidget {

  final List<Meal> preferredMeals;
  const Categories({super.key, required this.preferredMeals});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      children: availableCategories.map(
        (element) {
          return CategoryCard(
            category: element,
            preferredMeals: preferredMeals,
          );
        },
      ).toList(),
    );
  }
}
