import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meals_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;
  @override
  Widget build(BuildContext context) {
    Widget content=Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Uh oh..... Nothing here!',style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),),
          const SizedBox(height: 24,),
          Text('Try Different Categories',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),),
        ],
      ),
    );
    if(meals.isNotEmpty)
      {
        content=ListView.builder(
            itemCount: meals.length,
            itemBuilder: (ctx,index){
                return MealsItem(meal: meals[index],);
        });
      }

    if(title==null)
      {
        return content;
      }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
