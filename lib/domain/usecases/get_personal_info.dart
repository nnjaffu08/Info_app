import '../entities/personal_info.dart';
import '../repositories/personal_info_repository.dart';

class GetPersonalInfo {
  final PersonalInfoRepository repository;

  GetPersonalInfo(this.repository);

  Future<PersonalInfo> call(String id) async {
    return await repository.getPersonalInfo(id);
  }
}
