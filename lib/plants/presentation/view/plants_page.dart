import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../bloc/plant_bloc.dart';
import '../widgets/plant_list_item.dart';

class PlantsPage extends StatefulWidget {
  const PlantsPage({Key? key}) : super(key: key);

  @override
  State<PlantsPage> createState() => _PlantsPageState();
}

class _PlantsPageState extends State<PlantsPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    log("init state");
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
                onRefresh: () async {
                  context.read<PlantBloc>().add(const FetchPlantsRequested());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child:                 Column(
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
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.plants.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PlantListItem(plant: state.plants[index]);
                          },
                          controller: _scrollController,
                        ),
                      )
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
