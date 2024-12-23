import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:riverpod/riverpod.dart';

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier(ref: ref);
});

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  final Ref ref;
  FavoriteMealsNotifier({required this.ref}) : super([]);

  Future<void> toggleFavoritesButton(Meal meal, BuildContext context) async {
    bool doesExist = state.contains(meal);
    String message = "${meal.title} added to favorites";
    if (doesExist) {
      removeFromFavorites(meal);
      message = "${meal.title} removed from favorites";
    } else {
      addToFavorites(meal);
    }

    // run the two functions simultaneously.
    await Future.wait([
      // toggle the color of the button.
      ref.read(favoritesButtonColorProvider.notifier).toggleColor(),
      // finally show the info bar
      _showInfoBar(meal, context, message),
    ]);
  }

  Future<void> _showInfoBar(
      Meal meal, BuildContext context, String message) async {
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

final favoritesButtonColorProvider =
    StateNotifierProvider<FavoritesButtonColorNotifier, Color>((ref) {
  return FavoritesButtonColorNotifier();
});

class FavoritesButtonColorNotifier extends StateNotifier<Color> {
  FavoritesButtonColorNotifier() : super(Colors.white);

  Future<void> toggleColor() async {
    if (state == Colors.white) {
      state = Colors.redAccent;
    } else {
      state = Colors.white;
    }
  }
}
