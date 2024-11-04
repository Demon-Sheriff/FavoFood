import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealSteps extends StatelessWidget {
  final Meal meal;
  const MealSteps({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Steps',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 10),
        ...meal.steps.map(
          (item) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              maxLines: 2,
              // softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
