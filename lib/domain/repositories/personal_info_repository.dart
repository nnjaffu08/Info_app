import '../entities/personal_info.dart';

abstract class PersonalInfoRepository {
  Future<void> savePersonalInfo(PersonalInfo info);
  Future<PersonalInfo> getPersonalInfo(String id);
}
