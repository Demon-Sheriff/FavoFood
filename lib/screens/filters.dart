import 'package:flutter/material.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currFilters});
  final Map<Filter, bool> currFilters;
  @override
  State<FilterScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();

    _glutenFreeFilterSet = widget.currFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currFilters[Filter.lactoseFree]!;
    _veganFilterSet = widget.currFilters[Filter.vegetarian]!;
    _veganFilterSet = widget.currFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Filters',
        ),
      ),
      // drawer: SafeArea(
      //   child: MainDrawer(
      //     onSelectScreen: (type) {
      //       Navigator.of(context).pop();
      //       Navigator.of(context).push(
      //         MaterialPageRoute(
      //           builder: (context) {
      //             return type == 'Meals'
      //                 ? const TabsScreen()
      //                 : FilterScreen(
      //                     currFilters: {
      //                       Filter.glutenFree: _glutenFreeFilterSet,
      //                       Filter.lactoseFree: _lactoseFreeFilterSet,
      //                       Filter.vegetarian: _vegetarianFilterSet,
      //                       Filter.vegan: _veganFilterSet,
      //                     },
      //                   );
      //           },
      //         ),
      //       );
      //     },
      //   ),
      // ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          // print(result);
          // print(didPop);
          if (didPop) return;

          // print(_vegetarianFilterSet);
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });
        },
        child: Column(
          children: [
            filterTile(
              context: context,
              title: 'Gluten-free',
              subtitleKeyword: 'gluten-free',
              setValue: _glutenFreeFilterSet,
              onPress: (value) {
                setState(() {
                  _glutenFreeFilterSet = value;
                });
              },
            ),
            filterTile(
              context: context,
              title: 'Lactose-free',
              subtitleKeyword: 'lactose-free',
              setValue: _lactoseFreeFilterSet,
              onPress: (value) {
                setState(() {
                  _lactoseFreeFilterSet = value;
                });
              },
            ),
            filterTile(
              context: context,
              title: 'Vegetarian',
              subtitleKeyword: 'vegetarian',
              setValue: _vegetarianFilterSet,
              onPress: (value) {
                setState(() {
                  print(value);
                  print(_vegetarianFilterSet);
                  _vegetarianFilterSet = value;
                  print(_vegetarianFilterSet);
                });
              },
            ),
            filterTile(
              context: context,
              title: 'Vegan',
              subtitleKeyword: 'vegan',
              setValue: _veganFilterSet,
              onPress: (value) {
                setState(() {
                  _veganFilterSet = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
