
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../domain/entities/plant.dart';
import '../bloc/plant_bloc.dart';
import '../widgets/plant_grid_item.dart';
import '../widgets/plant_list_item.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _scrollController = ScrollController();
  bool _isGridMode = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantBloc, PlantState>(
      builder: (context, state) {
        switch (state.status) {
          case PlantStatus.failure:
            return const Center(child: Text('failed to Fetch plants'));
          case PlantStatus.success:
            if (state.plants.isEmpty) {
              return const Center(child: Text('no plants'));
            }
            return RefreshIndicator(
              color: Theme.of(context).colorScheme.onPrimary,
              onRefresh: () async {
                context.read<PlantBloc>().add(const FetchPlantsRequested());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Lottie.asset(
                      'assets/json/TreeMainPageHeaderIcon.json',
                      repeat: false,
                      width: 60,
                      height: 60,
                    ),
                    SizedBox(
                      child: Text("How are you Evan,",
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.secondary)),
                    ),
                    SizedBox(
                      child: Text("Help us save the earth",
                          style: GoogleFonts.merriweather(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).colorScheme.onPrimary)),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(children: [
                      Expanded(
                        child: SizedBox(
                          child: Text("RECENT ACTIVITY",
                              style: TextStyle(
                                  fontSize: 14,
                                  color:
                                  Theme
                                      .of(context)
                                      .colorScheme
                                      .onPrimary)),
                        ),
                      ),
                      _getActivityListIconButton(),
                      const SizedBox(width: 8),
                    ]
                    ),
                    _getActivityListBuilder(state.plants),
                  ],
                ),
              ),
            );
          case PlantStatus.loading:
          case PlantStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _getActivityListBuilder(
      List<Plant> plants
      ) {
    if (_isGridMode) {
      return Expanded(
        child: GridView.builder(
            itemCount: plants.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                childAspectRatio: 7 / 10,
            ),
            itemBuilder: (_, int index) {
              return InkWell(
                child: PlantGridItem(plant: plants[index]),
              );
            }),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: plants.length,
          itemBuilder: (BuildContext context, int index) {
            return PlantListItem(plant: plants[index]);
          },
        ),
      );
    }
  }

  Widget _getActivityListIconButton() {
    if (_isGridMode) {
      return
        IconButton(
          icon: const Icon(Icons.list),
          color: Theme
              .of(context)
              .colorScheme
              .onPrimary,
          onPressed: () {
            setState(() {
              _isGridMode = false;
            });
          },
        );
    } else {
      return
        IconButton(
          icon: const Icon(Icons.grid_view),
          color: Theme
              .of(context)
              .colorScheme
              .onPrimary,
          onPressed: () {
            setState(() {
              _isGridMode = true;
            });
          },
        );
    }
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<PlantBloc>().add(const FetchPlantsRequested());
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<PlantBloc>().add(const FetchPlantsRequested());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
