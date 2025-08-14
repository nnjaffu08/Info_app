import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/personal_info.dart';
import '../../../domain/usecases/get_personal_info.dart';
import '../../../domain/usecases/save_personal_info.dart';

part 'personal_info_event.dart';
part 'personal_info_state.dart';

class PersonalInfoBloc extends Bloc<PersonalInfoEvent, PersonalInfoState> {
  final SavePersonalInfo savePersonalInfo;
  final GetPersonalInfo getPersonalInfo;

  PersonalInfoBloc(this.savePersonalInfo, this.getPersonalInfo)
      : super(PersonalInfoInitial()) {
    on<SavePersonalInfoEvent>((event, emit) async {
      emit(PersonalInfoLoading());
      try {
        await savePersonalInfo(event.info);
        emit(PersonalInfoSaved());
      } catch (e) {
        emit(PersonalInfoError(e.toString()));
      }
    });

    on<LoadPersonalInfoEvent>((event, emit) async {
      emit(PersonalInfoLoading());
      try {
        final info = await getPersonalInfo(event.id);
        emit(PersonalInfoLoaded(info));
      } catch (e) {
        emit(PersonalInfoError(e.toString()));
      }
    });
  }
}
