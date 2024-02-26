import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullnoteapp/presentation/home/cubit/home_cubit_state.dart';
import 'package:fullnoteapp/presentation/home/viewmodel/home_viewmodel.dart';

import '../../../app/di.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  HomeViewModel homeViewModel = instance<HomeViewModel>();

  getNotes() async {
    await homeViewModel.getNotes();
  }

  deleteNote(int noteId) {
    homeViewModel.deleteNote(noteId);
    homeViewModel.getNotes();
  }
}
