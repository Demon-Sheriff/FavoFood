import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

// Main FilterScreen widget
class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Filters',
        ),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          Navigator.of(context).pop(true);
        },
        child: Column(
          children: [
            filterTile(
              context: context,
              title: 'Gluten-free',
              subtitleKeyword: 'gluten-free',
              setValue: activeFilters[Filter.glutenFree]!,
              onPress: (value) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.glutenFree, value);
              },
            ),
            filterTile(
              context: context,
              title: 'Lactose-free',
              subtitleKeyword: 'lactose-free',
              setValue: activeFilters[Filter.lactoseFree]!,
              onPress: (value) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.lactoseFree, value);
              },
            ),
            filterTile(
              context: context,
              title: 'Vegetarian',
              subtitleKeyword: 'vegetarian',
              setValue: activeFilters[Filter.vegetarian]!,
              onPress: (value) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.vegetarian, value);
              },
            ),
            filterTile(
              context: context,
              title: 'Vegan',
              subtitleKeyword: 'vegan',
              setValue: activeFilters[Filter.vegan]!,
              onPress: (value) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.vegan, value);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// FilterTile widget
Widget filterTile({
  required BuildContext context,
  required String title,
  required String subtitleKeyword,
  required bool setValue,
  required void Function(bool value) onPress,
}) {
  return SwitchListTile(
    value: setValue,
    onChanged: onPress,
    title: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
    ),
    subtitle: Text(
      'Only include $subtitleKeyword meals.',
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
    ),
    activeColor: Theme.of(context).colorScheme.tertiary,
    contentPadding: const EdgeInsets.only(
      left: 34,
      right: 22,
    ),
  );
}
