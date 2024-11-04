import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_ingredients.dart';
import 'package:meals_app/widgets/meal_steps.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetails extends StatelessWidget {
  final Meal meal;
  final void Function() addToFavorites;
  const MealDetails({super.key, required this.meal, required this.addToFavorites});

  @override
  Widget build(BuildContext context) {
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
              addToFavorites();
            },
            icon: const Icon(
              Icons.star,
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
