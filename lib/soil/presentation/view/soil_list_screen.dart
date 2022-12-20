import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagger_app/soil/presentation/view/soil_list_item.dart';
import 'package:tagger_app/utils/logging_utils.dart';

import '../../../main/presentation/navigation/model/routes.dart';
import '../../../plants/presentation/bloc/plant_bloc.dart';
import '../bloc/soil_bloc.dart';

class SoilListScreen extends StatefulWidget {
  const SoilListScreen({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  _SoilListScreen createState() => _SoilListScreen();
}

class _SoilListScreen extends State<SoilListScreen> {

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildAppDrawer(),
      floatingActionButton: _buildFabButton(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
        child: BlocBuilder<SoilBloc, SoilState>(
          builder: (context, state) {
            switch (state.status) {
              case SoilStatus.failure:
                return const Center(child: Text('failed to fetch soils'));
              case SoilStatus.success:
                if (state.soils.isEmpty) {
                  return const Center(child: Text('no soils'));
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<PlantBloc>().add(const FetchPlantsRequested());
                  },
                  child: ListView.builder(
                    itemCount: state.soils.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SoilListItem(soil: state.soils[index]);
                    },
                    controller: _scrollController,
                  ),
                );
              case SoilStatus.loading:
              case SoilStatus.initial:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
    );
  }

  Widget _buildFabButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.pushNamed(context, Routes.addSoilRoute);
      },
      label: const Text('Add Soil'),
      icon: const Icon(Icons.add),
    );
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
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .colorScheme
                  .primary,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(color: Theme
                  .of(context)
                  .colorScheme
                  .onPrimary),),
          ),
          ListTile(
            title: const Text('Plant Center'),
            onTap: () {
              Navigator.pushNamed(context, Routes.initialRoute);
            },
          ),
          ListTile(
            selected: true,
            title: const Text('Soil Center'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Identification Center'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Ideas Center'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
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
            hintText: 'Search soils',
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<SoilBloc>().add(
        const FetchSoilBlendsRequested());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
