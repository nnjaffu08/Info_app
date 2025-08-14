import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/personal_info_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        elevation: 2,
      ),
      body: BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
        builder: (context, state) {
          if (state is PersonalInfoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PersonalInfoLoaded) {
            final info = state.info;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Personal Information',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow('Name', info.name, Icons.person),
                      const SizedBox(height: 12),
                      _buildInfoRow('Email', info.email, Icons.email),
                      const SizedBox(height: 12),
                      _buildInfoRow('Phone', info.phone, Icons.phone),
                      const SizedBox(height: 24),
                      const Text(
                        'Skills',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: info.skills
                            .map((skill) => Chip(
                                  label: Text(skill),
                                  backgroundColor: Colors.blue[50],
                                  labelStyle:
                                      const TextStyle(color: Colors.black87),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Experiences',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: info.experiences
                            .map((experience) => Chip(
                                  label: Text(experience),
                                  backgroundColor: Colors.blue[50],
                                  labelStyle:
                                      const TextStyle(color: Colors.black87),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is PersonalInfoError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(
              child: Text('No data available. Please save your information.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/');
        },
        child: const Icon(Icons.edit),
        tooltip: 'Edit Profile',
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$label: ${value.isEmpty ? "Not provided" : value}',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
