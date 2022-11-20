import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/bloc/plant_bloc.dart';
import '../widgets/bottom_loader.dart';
import '../widgets/plant_list_item.dart';

class PlantsList extends StatefulWidget {
  const PlantsList({Key? key}): super(key: key);

  @override
  State<PlantsList> createState() => _PlantsListState();
}

class _PlantsListState extends State<PlantsList> {
  final _scrollController = ScrollController();

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
            return const Center(child: Text('failed to fetch plants'));
          case PlantStatus.success:
            if (state.plants.isEmpty) {
              return const Center(child: Text('no plants'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.plants.length
                    ? const BottomLoader()
                    : PlantListItem(plant: state.plants[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.plants.length
                  : state.plants.length + 1,
              controller: _scrollController,
            );
          case PlantStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
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
    if (_isBottom) context.read<PlantBloc>().add(PlantFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}