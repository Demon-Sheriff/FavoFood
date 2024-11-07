import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class FavoritesList extends StatelessWidget {
  final List<Meal> favoriteMeals;
  const FavoritesList({super.key, required this.favoriteMeals});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Text(favoriteMeals[index].title);
      },
    );
  }
}
