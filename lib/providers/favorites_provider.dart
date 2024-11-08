import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:riverpod/riverpod.dart';

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  void toggleFavoritesButton(Meal meal, BuildContext context) {
    bool doesExist = state.contains(meal);
    String message = "${meal.title} added to favorites";
    if (doesExist) {
      removeFromFavorites(meal);
      message = "${meal.title} removed from favorites";
    } else {
      addToFavorites(meal);
    }

    // finally show the info bar
    _showInfoBar(meal, context, message);
  }

  void _showInfoBar(Meal meal, BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            toggleFavoritesButton(meal, context);
          },
        ),
      ),
    );
  }

  void addToFavorites(Meal meal) {
    state = [...state, meal];
  }

  void removeFromFavorites(Meal meal) {
    state = state.where((currMeal) {
      return (currMeal != meal);
    }).toList();
  }
}
