import '../entities/personal_info.dart';
import '../repositories/personal_info_repository.dart';

class SavePersonalInfo {
  final PersonalInfoRepository repository;

  SavePersonalInfo(this.repository);

  Future<void> call(PersonalInfo info) async {
    await repository.savePersonalInfo(info);
  }
}
