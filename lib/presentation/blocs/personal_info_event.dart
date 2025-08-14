part of 'personal_info_bloc.dart';

abstract class PersonalInfoEvent extends Equatable {
  const PersonalInfoEvent();

  @override
  List<Object> get props => [];
}

class SavePersonalInfoEvent extends PersonalInfoEvent {
  final PersonalInfo info;

  const SavePersonalInfoEvent(this.info);

  @override
  List<Object> get props => [info];
}

class LoadPersonalInfoEvent extends PersonalInfoEvent {
  final String id;

  const LoadPersonalInfoEvent(this.id);

  @override
  List<Object> get props => [id];
}
