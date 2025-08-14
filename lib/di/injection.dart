import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import '../data/repositories/personal_info_repository_impl.dart';
import '../domain/repositories/personal_info_repository.dart';
import '../domain/usecases/get_personal_info.dart';
import '../domain/usecases/save_personal_info.dart';
import '../presentation/blocs/personal_info_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // Blocs
  locator.registerFactory(() => PersonalInfoBloc(
        locator(),
        locator(),
      ));

  // Use cases
  locator.registerLazySingleton(() => SavePersonalInfo(locator()));
  locator.registerLazySingleton(() => GetPersonalInfo(locator()));

  // Repositories
  locator.registerLazySingleton<PersonalInfoRepository>(
    () => PersonalInfoRepositoryImpl(locator()),
  );

  // Data sources
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
}
