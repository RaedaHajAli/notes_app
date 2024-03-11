import 'package:dio/dio.dart';
import 'package:fullnoteapp/app/app_prefs.dart';
import 'package:fullnoteapp/data/data_source/remote_data_source.dart';
import 'package:fullnoteapp/data/network/app_api.dart';
import 'package:fullnoteapp/data/network/dio_factory.dart';
import 'package:fullnoteapp/data/network/network_info.dart';
import 'package:fullnoteapp/data/repository/repository_impl.dart';
import 'package:fullnoteapp/domain/repository/repository.dart';
import 'package:fullnoteapp/domain/usecase/add_note_usecase.dart';
import 'package:fullnoteapp/domain/usecase/delete_note_usecase.dart';
import 'package:fullnoteapp/domain/usecase/edit_note_usecase.dart';
import 'package:fullnoteapp/domain/usecase/view_note_usecase.dart';

import 'package:fullnoteapp/presentation/auth/signup/viewmodel/signup_viewmodel.dart';

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/usecase/login_usecase.dart';
import '../domain/usecase/signup_usecase.dart';
import '../presentation/auth/login/viewmodel/login_viewmodel.dart';

final instance = GetIt.instance;
Future<void> initModule() async {
  final DioFactory dioFactory = DioFactory();
  Dio dio = await dioFactory.getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance<AppServiceClient>()));

  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
  instance.registerLazySingleton<Repository>(() =>
      RepositoryImpl(instance<RemoteDataSource>(), instance<NetworkInfo>()));

  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(sharedPrefs));
}

initSignupModule() {
  if (!GetIt.I.isRegistered<SignupUseCase>()) {
    instance.registerFactory<SignupUseCase>(
        () => SignupUseCase(instance<Repository>()));
    instance.registerFactory<SignupViewModel>(
        () => SignupViewModel(instance<SignupUseCase>()));
  }
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
        () => LoginUseCase(instance<Repository>()));
    instance.registerFactory<LoginViewModel>(
        () => LoginViewModel(instance<LoginUseCase>()));
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<ViewNoteUseCase>()) {
    instance.registerFactory<ViewNoteUseCase>(
        () => ViewNoteUseCase(instance<Repository>()));
    instance.registerFactory<AddNoteUseCase>(
        () => AddNoteUseCase(instance<Repository>()));
    instance.registerFactory<DeleteNoteUseCase>(
        () => DeleteNoteUseCase(instance<Repository>()));

    instance.registerFactory<EditNoteUseCase>(
        () => EditNoteUseCase(instance<Repository>()));
  }
}
