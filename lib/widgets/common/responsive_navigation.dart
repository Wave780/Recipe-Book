import 'package:flutter/material.dart';
import 'package:recipe_book_app/screens/favourite_screen.dart';
import 'package:recipe_book_app/screens/home_screen.dart';
import 'package:recipe_book_app/screens/profile_screen.dart';
import 'package:recipe_book_app/screens/recipes_list_screen.dart';
import 'package:recipe_book_app/utils/responsive_breakpoints.dart';

class ResponsiveNavigation extends StatefulWidget {
  const ResponsiveNavigation({super.key});

  @override
  _ResponsiveNavigationState createState() => _ResponsiveNavigationState();
}

class _ResponsiveNavigationState extends State<ResponsiveNavigation> {
  int selectedIndex = 0;

  final List<AppNavigationDestination> destinations = [
    AppNavigationDestination(
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      page: HomeScreen(),
    ),
    AppNavigationDestination(
      label: 'Recipes',
      icon: Icons.restaurant_outlined,
      selectedIcon: Icons.restaurant,
      page: RecipesListScreen(),
    ),
    AppNavigationDestination(
      label: 'Favourites',
      icon: Icons.favorite_outline,
      selectedIcon: Icons.favorite,
      page: FavouriteScreen(favouriteRecipes: []),
    ),
    AppNavigationDestination(
      label: 'Profile',
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      page: ProfileScreen(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    if (ResponsiveBreakpoints.isDesktop(context)) {
      return _buildDesktopLayout();
    } else if (ResponsiveBreakpoints.isTablet(context)) {
      return _buildTabletLayout();
    } else {
      return _buildMobileLayout();
    }
  }

  //Destination selector method
  void _onDestinationSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  //Navigation Rail Method
  NavigationRailDestination _buildRailDestination(
      AppNavigationDestination des) {
    return NavigationRailDestination(
      icon: Icon(des.icon),
      selectedIcon: Icon(des.selectedIcon),
      label: Text(des.label),
    );
  }

  //Bottom Navigation
  NavigationDestination _buildBottomDestination(AppNavigationDestination dest) {
    return NavigationDestination(
      label: dest.label,
      icon: Icon(dest.icon),
      selectedIcon: Icon(dest.selectedIcon),
    );
  }

  //Desktop layout
  Widget _buildDesktopLayout() {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: true,
            onDestinationSelected: _onDestinationSelected,
            destinations: destinations.map(_buildRailDestination).toList(),
            selectedIndex: selectedIndex,
          ),
          const VerticalDivider(
            thickness: 1,
            width: 1,
          ),
          Expanded(child: destinations[selectedIndex].page),
        ],
      ),
    );
  }

  //Tablet layout
  Widget _buildTabletLayout() {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            destinations: destinations.map(_buildRailDestination).toList(),
            onDestinationSelected: _onDestinationSelected,
            selectedIndex: selectedIndex,
          ),
          const VerticalDivider(
            thickness: 1,
            width: 1,
          ),
          Expanded(child: destinations[selectedIndex].page)
        ],
      ),
    );
  }

  //Mobile Layout
  Widget _buildMobileLayout() {
    return Scaffold(
      body: destinations[selectedIndex].page,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: destinations.map(_buildBottomDestination).toList(),
      ),
    );
  }
}

//Helper method for Navigation
class AppNavigationDestination {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Widget page;

  AppNavigationDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.page,
  });
}
