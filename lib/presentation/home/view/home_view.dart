import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fullnoteapp/presentation/home/cubit/home_cubit.dart';
import 'package:fullnoteapp/presentation/home/cubit/home_state.dart';

import 'package:fullnoteapp/presentation/resources/color_manager.dart';




import 'widgets/widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  HomeCubit cubit = HomeCubit();

  @override
  void initState() {
    cubit.homeViewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.deepPurple,
          appBar: buildHomeAppBar(context),
          body: HomeBody(cubit: cubit),
          floatingActionButton: const AddFab(),
        );
      },
    );
  }

 
}

