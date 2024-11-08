import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/widgets/meal_ingredients.dart';
import 'package:meals_app/widgets/meal_steps.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetails extends ConsumerWidget {
  final Meal meal;
  const MealDetails({super.key, required this.meal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          textAlign: TextAlign.start,
          meal.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleFavoritesButton(meal, context);
              // addToFavorites(meal);
              ref.read(favoritesButtonColorProvider.notifier).toggleColor();
            },
            icon: Icon(
              Icons.star,
              color: ref.watch(favoritesButtonColorProvider),
            ),
          )
        ],
      ),
      body: Scrollbar(
        // thumbVisibility: true,
        interactive: true,
        thickness: 5,
        radius: const Radius.circular(20),
        child: SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.start,
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInImage(
                fit: BoxFit.cover,
                placeholder: MemoryImage(
                  kTransparentImage,
                ),
                image: NetworkImage(
                  meal.imageUrl,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MealIngredients(
                meal: meal,
              ),
              const SizedBox(
                height: 10,
              ),
              MealSteps(
                meal: meal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
