import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealIngredients extends StatelessWidget {
  final Meal meal;
  const MealIngredients({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Ingredients',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        // use the spread operator to break down the list
        ...meal.ingredients.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              item,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
