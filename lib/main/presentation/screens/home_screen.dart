import 'package:flutter/material.dart';
import 'package:tagger_app/plants/presentation/view/dashboard_page.dart';
import 'package:tagger_app/plants/presentation/view/plants_page.dart';

import '../../../qr/presentation/pages/qr_scanning_page.dart';
import '../navigation/model/pages.dart';
import '../navigation/model/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = Pages.homePage;

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    PlantsPage(),
    QRScanningPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildAddOptionsFab(_selectedIndex),
      body: _buildBody(_selectedIndex),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      selectedIndex: _selectedIndex,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.dashboard_customize_rounded),
          label: 'Dashboard',
        ),
        NavigationDestination(
          icon: Icon(Icons.forest),
          label: 'My plants',
        ),
        NavigationDestination(
          icon: Icon(Icons.qr_code),
          label: 'Scan',
        ),
      ],
    );
  }

  Widget _buildBody(int index) {
    return Center(
      child: _widgetOptions.elementAt(index),
    );
  }

  Widget _buildAddOptionsFab(int index) {
    if (index == 1) {
      return FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          Navigator.pushNamed(context, Routes.addPlantRoute);
        },
        label: Text(
          'Add plant',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      );
    }
    return const SizedBox();
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Icon(
            Icons.settings,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        )
      ],
    );
  }
}
