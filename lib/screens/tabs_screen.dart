import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals.dart';
import '../widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex=0;

  void _selectedPage(int index)
  {
    setState(() {
      _selectedPageIndex=index;
    });
  }

  void _setScreen(String identifier)
  async {
    Navigator.of(context).pop();
    if(identifier=='filter')
      {
        await Navigator.of(context).push<Map<Filter,bool>>(
            MaterialPageRoute(
                builder: (ctx)=> const FiltersScreen()
            )
        );
      }
  }
  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMeals);

    Widget activePage= CategoriesScreen(
      availableMeals: availableMeals,);
    var activePageTitle='Categories';
    if(_selectedPageIndex==1)
      {
        final favoriteMeals = ref.watch(favoriteMealsProvider);
        activePage=MealsScreen(
          meals: favoriteMeals,);
        activePageTitle='Your Favorites';
      }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectDrawer: _setScreen,),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal),label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star),label: 'Favorites')
        ],
      ),
    );
  }
}
