part of 'personal_info_bloc.dart';

abstract class PersonalInfoState extends Equatable {
  const PersonalInfoState();

  @override
  List<Object> get props => [];
}

class PersonalInfoInitial extends PersonalInfoState {}

class PersonalInfoLoading extends PersonalInfoState {}

class PersonalInfoSaved extends PersonalInfoState {}

class PersonalInfoLoaded extends PersonalInfoState {
  final PersonalInfo info;

  const PersonalInfoLoaded(this.info);

  @override
  List<Object> get props => [info];
}

class PersonalInfoError extends PersonalInfoState {
  final String message;

  const PersonalInfoError(this.message);

  @override
  List<Object> get props => [message];
}
