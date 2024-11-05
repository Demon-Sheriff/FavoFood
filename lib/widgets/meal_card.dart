import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:transparent_image/transparent_image.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  const MealCard({
    super.key,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        // padding: const EdgeInsets.all(16),
        padding: const EdgeInsets.only(top: 135),
        margin: const EdgeInsets.only(bottom: 10),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(
              meal.imageUrl,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Card(
          elevation: 0,
          margin: const EdgeInsets.all(0),
          color: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Colors.black54,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 4,
              ),
              child: Column(
                children: [
                  Text(
                    meal.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // const Expanded(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.alarm),
                          const SizedBox(
                            width: 4,
                          ),
                          Text('${meal.duration} min'),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.card_travel),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(meal.complexity.name),
                        ],
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.attach_money_sharp),
                          // const SizedBox(
                          //   width: 4,
                          // ),
                          Text(meal.affordability.name),
                        ],
                      ),
                    ],
                  ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// another way to make meal card
class MealCardUsingStack extends StatelessWidget {
  final Meal meal;
  final void Function(Meal meal) addToFavorites;
  const MealCardUsingStack({super.key, required this.meal, required this.addToFavorites});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          var mealRoute = MaterialPageRoute(
            builder: (context) {
              return MealDetails(
                meal: meal,
                addToFavorites: addToFavorites,
              );
            },
          );
          Navigator.of(context).push(mealRoute);
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  16,
                ),
              ),
              child: FadeInImage(
                placeholder: MemoryImage(
                  kTransparentImage,
                ),
                image: NetworkImage(
                  meal.imageUrl,
                ),
                fit: BoxFit.cover,
                height: 250,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 44,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.schedule,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text('${meal.duration} min'),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.work,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(meal.complexity.name),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.attach_money,
                              color: Colors.white,
                              size: 18,
                            ),
                            // const SizedBox(
                            //   width: 4,
                            // ),
                            Text(meal.affordability.name),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
