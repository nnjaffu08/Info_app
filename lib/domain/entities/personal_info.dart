import 'package:equatable/equatable.dart';

class PersonalInfo extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final List<String> skills;
  final List<String> experiences;

  const PersonalInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.skills,
    required this.experiences,
  });

  @override
  List<Object> get props => [id, name, email, phone, skills, experiences];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'skills': skills,
      'experiences': experiences,
    };
  }

  factory PersonalInfo.fromMap(Map<String, dynamic> map) {
    return PersonalInfo(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      skills: List<String>.from(map['skills'] ?? []),
      experiences: List<String>.from(map['experiences'] ?? []),
    );
  }
}
