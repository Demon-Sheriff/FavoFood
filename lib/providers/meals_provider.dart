import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:riverpod/riverpod.dart';

final mealsProvider = StateNotifierProvider<MealsNotifier, List<Meal>>((ref) {
  return MealsNotifier();
});

class MealsNotifier extends StateNotifier<List<Meal>> {

  MealsNotifier() : super(dummyMeals); // initialise the state with dummyMeals.

  void setMeals(List<Meal> finalMealsList){
    state = finalMealsList;
  }
}
