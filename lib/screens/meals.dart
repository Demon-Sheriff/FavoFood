import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_card.dart';

class Meals extends StatelessWidget {
  final Category category;
  final List<Meal> mealsList;
  const Meals({super.key, required this.category, required this.mealsList,});

  @override
  Widget build(BuildContext context) {
    
    Widget dataEmptyContent = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh Oh... Nothing here',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                // color: Theme.of(context).colorScheme.onError,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                // color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ],
      ),
    );

    Widget bodyContent = mealsList.isEmpty
        ? dataEmptyContent
        : ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: mealsList.length,
            physics: const ScrollPhysics(),
            itemBuilder: (ctx, index) {
              return MealCardUsingStack(
                meal: mealsList[index],
              );
            },
          );

    if (category.title == 'Favorites') {
      return bodyContent;
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            category.title,
          ),
        ),
        body: bodyContent,
      );
    }
  }
}
