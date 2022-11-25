import 'package:flutter/material.dart';
import 'package:tagger_app/plants/presentation/view/plants_page.dart';
import 'package:tagger_app/utils/logging_utils.dart';

import '../../../qr/presentation/pages/qr_scanning_page.dart';
import '../navigation/model/pages.dart';
import '../navigation/model/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = Pages.homePage;

  static const List<Widget> _widgetOptions = <Widget>[
    PlantsPage(),
    QRScanningPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildAppDrawer(),
      floatingActionButton: _buildAddOptionsFab(_selectedIndex),
      body: _buildBody(_selectedIndex),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.forest),
          label: 'Plants',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code),
          label: 'QR Scan',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      onTap: _onItemTapped,
    );
  }

  Widget _buildBody(int index) {
    return Center(
      child: _widgetOptions.elementAt(index),
    );
  }

  Widget _buildAddOptionsFab(int index) {
    if (index == 0) {
      return FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addPlantRoute);
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      );
    }
    return const SizedBox();
  }

  Widget _buildAppDrawer() {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: GestureDetector(
        onTap: () {
          log("title was tapped");
        },
        child: const TextField(
          decoration: InputDecoration.collapsed(
            hintText: 'Search plants',
          ),
        ),
      ),
    );
  }
}
