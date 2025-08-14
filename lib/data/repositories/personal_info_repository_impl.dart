import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/personal_info.dart';
import '../../domain/repositories/personal_info_repository.dart';

class PersonalInfoRepositoryImpl implements PersonalInfoRepository {
  final FirebaseFirestore firestore;

  PersonalInfoRepositoryImpl(this.firestore);

  @override
  Future<void> savePersonalInfo(PersonalInfo info) async {
    await firestore.collection('personal_info').doc(info.id).set(info.toMap());
  }

  @override
  Future<PersonalInfo> getPersonalInfo(String id) async {
    final doc = await firestore.collection('personal_info').doc(id).get();
    if (doc.exists) {
      return PersonalInfo.fromMap(doc.data()!);
    }
    return const PersonalInfo(
        id: '', name: '', email: '', phone: '', skills: [], experiences: []);
  }
}
