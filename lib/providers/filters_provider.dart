import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:riverpod/riverpod.dart';

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>((ref) {
  return FiltersNotifier(ref);
});

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  Ref ref;
  FiltersNotifier(this.ref)
      : super(
          {
            Filter.glutenFree: false,
            Filter.lactoseFree: false,
            Filter.vegetarian: false,
            Filter.vegan: false,
          },
        );

  void setFilterMap(Map<Filter, bool> currMap) {
    state = currMap;
  }
  void setFilter(Filter filter, bool isActive) {
    // take the old map and override the changed key.
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setMealsBasedOnFilters(List<Meal> mealsList) {
    List<Meal> filteredMeals = [];
    for (Meal meal in mealsList) {
      if (state[Filter.glutenFree]! && meal.isGlutenFree ||
          state[Filter.lactoseFree]! && meal.isLactoseFree ||
          state[Filter.vegetarian]! && meal.isVegetarian ||
          state[Filter.vegan]! && meal.isVegan) {
        continue;
      } else {
        // valid meal to add based on filters.
        filteredMeals.add(meal);
      }
    }

    ref.read(mealsProvider.notifier).setMeals(filteredMeals);
  }
}
