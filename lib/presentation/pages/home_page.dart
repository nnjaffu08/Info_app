import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/personal_info.dart';
import '../blocs/personal_info_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _skillController = TextEditingController();
  final _experienceController = TextEditingController();
  final List<String> _skills = [];
  final List<String> _experiences = [];

  @override
  void initState() {
    super.initState();
    context
        .read<PersonalInfoBloc>()
        .add(const LoadPersonalInfoEvent('user_id'));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _skillController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Profile'),
        centerTitle: true,
        elevation: 2,
      ),
      body: BlocConsumer<PersonalInfoBloc, PersonalInfoState>(
        listener: (context, state) {
          if (state is PersonalInfoSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Information saved successfully!')),
            );
            context
                .read<PersonalInfoBloc>()
                .add(const LoadPersonalInfoEvent('user_id'));
          } else if (state is PersonalInfoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is PersonalInfoLoaded) {
            _nameController.text = state.info.name;
            _emailController.text = state.info.email;
            _phoneController.text = state.info.phone;
            setState(() {
              _skills.clear();
              _skills.addAll(state.info.skills);
              _experiences.clear();
              _experiences.addAll(state.info.experiences);
            });
          }
        },
        builder: (context, state) {
          if (state is PersonalInfoLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter Your Information',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                          _nameController, 'Full Name', Icons.person),
                      const SizedBox(height: 16),
                      _buildTextField(_emailController, 'Email', Icons.email,
                          TextInputType.emailAddress),
                      const SizedBox(height: 16),
                      _buildTextField(_phoneController, 'Phone', Icons.phone,
                          TextInputType.phone),
                      const SizedBox(height: 24),
                      _buildAddItemSection('Skills', _skillController, _skills,
                          () {
                        setState(() {
                          if (_skillController.text.isNotEmpty) {
                            _skills.add(_skillController.text);
                            _skillController.clear();
                          }
                        });
                      }),
                      _buildItemList('Skills', _skills),
                      const SizedBox(height: 24),
                      _buildAddItemSection(
                          'Experiences', _experienceController, _experiences,
                          () {
                        setState(() {
                          if (_experienceController.text.isNotEmpty) {
                            _experiences.add(_experienceController.text);
                            _experienceController.clear();
                          }
                        });
                      }),
                      _buildItemList('Experiences', _experiences),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final info = PersonalInfo(
                                    id: 'user_id',
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    phone: _phoneController.text,
                                    skills: _skills,
                                    experiences: _experiences,
                                  );
                                  context
                                      .read<PersonalInfoBloc>()
                                      .add(SavePersonalInfoEvent(info));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Save Information',
                                  style: TextStyle(fontSize: 14)),
                            ),
                          ),
                          Flexible(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/profile');
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('View Profile',
                                  style: TextStyle(fontSize: 14)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      [TextInputType? keyboardType]) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.grey[100],
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if (label == 'Email' &&
            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildAddItemSection(String label, TextEditingController controller,
      List<String> items, VoidCallback onAdd) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Add $label',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: onAdd,
          icon: const Icon(Icons.add_circle, color: Colors.blue),
          tooltip: 'Add $label',
        ),
      ],
    );
  }

  Widget _buildItemList(String label, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items
              .asMap()
              .entries
              .map(
                (entry) => Chip(
                  label: Text(entry.value),
                  deleteIcon: const Icon(Icons.cancel, size: 18),
                  onDeleted: () {
                    setState(() {
                      items.removeAt(entry.key);
                    });
                  },
                  backgroundColor: Colors.blue[50],
                  labelStyle: const TextStyle(color: Colors.black87),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
