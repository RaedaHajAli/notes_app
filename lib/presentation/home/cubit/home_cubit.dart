import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullnoteapp/presentation/home/cubit/home_state.dart';
import 'package:fullnoteapp/presentation/home/viewmodel/home_viewmodel.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/di.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  HomeViewModel homeViewModel = instance<HomeViewModel>();
  ImagePicker picker = ImagePicker();

  getNotes() {
    homeViewModel.getNotes();
  }

  deleteNote(int noteId) {
    homeViewModel.deleteNote(noteId);
  }

  addNote() {
    homeViewModel.addNote();
  }

  pickImageFromCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    homeViewModel.setNoteImage(File(image?.path ?? ''));
  }
   pickImageFromGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    homeViewModel.setNoteImage(File(image?.path ?? ''));
  }
}
