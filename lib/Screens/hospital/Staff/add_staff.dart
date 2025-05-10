import 'package:swift_aid/Screens/personal_details/component/text_field.dart';
import 'package:swift_aid/Screens/personal_details/component/age.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class AddStaff extends StatefulWidget {
  const AddStaff({super.key});

  @override
  State<AddStaff> createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selectedSpecialization;
  String? _selectedGender;
  File? profileImage;
  int? _age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Staff',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(children: [
                const SizedBox(height: 10),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: profileImage != null
                              ? FileImage(profileImage!)
                              : const AssetImage('assets/images/profile.jpg')
                                  as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 3,
                      bottom: 1,
                      child: GestureDetector(
                        onTap: _showImagePickerSheet,
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                            color: AppColors.whiteColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: AppColors.primaryColor,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  keyboardType: TextInputType.name,
                  hintText: 'John Doe',
                  labelText: 'Name',
                  controller: nameController,
                  labelStyle: const TextStyle(color: AppColors.primaryColor),
                  borderColor: AppColors.primaryColor,
                  errorBorderColor: Colors.red,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'abc@gmail.com',
                  labelText: 'Email',
                  controller: emailController,
                  labelStyle: const TextStyle(color: AppColors.primaryColor),
                  borderColor: AppColors.primaryColor,
                  errorBorderColor: Colors.red,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    final emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  keyboardType: TextInputType.phone,
                  hintText: '03316127647',
                  labelText: 'Phone Num',
                  controller: phoneController,
                  labelStyle: const TextStyle(color: AppColors.primaryColor),
                  borderColor: AppColors.primaryColor,
                  errorBorderColor: Colors.red,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(11),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone Num is required';
                    } else if (value.length != 11) {
                      return 'Phone Num must be 11 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  keyboardType: TextInputType.number,
                  hintText: '19 yrs',
                  labelText: 'DOB (Age)',
                  readOnly: true,
                  onTap: () async {
                    final selectedDate = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DOBPickerScreen(),
                      ),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _age = _calculateAge(selectedDate);
                        dobController.text = '$_age yrs';
                      });
                    }
                  },
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : 'Date of Birth is required',
                  labelStyle: const TextStyle(color: AppColors.primaryColor),
                  controller: dobController,
                  borderColor: AppColors.primaryColor,
                  errorBorderColor: Colors.red,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField2<String>(
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    labelStyle: const TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  isExpanded: true,
                  value: _selectedGender,
                  items: ['Male', 'Female', 'Other']
                      .map((gender) => DropdownMenuItem<String>(
                            value: gender,
                            child: Text(
                              gender,
                              style: const TextStyle(color: Colors.black87),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  dropdownStyleData: DropdownStyleData(
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border:
                          Border.all(color: AppColors.primaryColor, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  validator: (value) =>
                      value != null ? null : 'Please select a gender',
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: descriptionController,
                  hintText: 'Enter Description',
                  labelText: 'Description',
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  borderColor: AppColors.primaryColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField2<String>(
                  decoration: InputDecoration(
                    labelText: 'Specialization',
                    labelStyle: const TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  isExpanded: true,
                  value: _selectedSpecialization,
                  items: [
                    'Cardiology',
                    'Neurology',
                    'Pediatrics',
                    'Orthopedics',
                    'Dermatology',
                    'Gynecology',
                    'Psychiatry',
                    'Oncology',
                    'General Medicine',
                    'Gastroenterology',
                    'Nephrology',
                    'Hematology',
                    'Pulmonology',
                    'Rheumatology',
                    'Ophthalmology',
                    'ENT',
                    'Anesthesiology',
                    'Pathology',
                    'Infectious Disease',
                    'Allergy and Immunology',
                    'Emergency Medicine',
                    'Geriatrics',
                  ]
                      .map((specialization) => DropdownMenuItem<String>(
                            value: specialization,
                            child: Text(
                              specialization,
                              style: const TextStyle(color: Colors.black87),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSpecialization = value;
                    });
                  },
                  dropdownStyleData: DropdownStyleData(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border:
                          Border.all(color: AppColors.primaryColor, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  validator: (value) =>
                      value != null ? null : 'Please select a specialization',
                ),
                const SizedBox(height: 20),
                CustomButton(
                  borderRadius: 20.0,
                  text: 'Add Staff',
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {}
                  },
                  backgroundColor: AppColors.primaryColor,
                  width: 350,
                ),
              ]),
            ),
          )
        ]),
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    dobController.dispose();
    emailController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  int _calculateAge(DateTime birthDate) {
    final currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }

//! Bottom Model Sheet
  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            children: [
              ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    color: AppColors.primaryColor,
                  ),
                  title: const Text("Pick from Gallery"),
                  onTap: () {
                    HapticFeedback.lightImpact();
                    _pickImage(
                      ImageSource.gallery,
                    );
                  }),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                  color: AppColors.primaryColor,
                ),
                title: const Text("Take from Camera"),
                onTap: () {
                  HapticFeedback.lightImpact();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

//! Pick image Function
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 85);

    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
    if (mounted) {
      Navigator.pop(context);
    }
  }
}
