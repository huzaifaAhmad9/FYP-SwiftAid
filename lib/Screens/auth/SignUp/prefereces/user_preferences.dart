import 'package:dropdown_button2/dropdown_button2.dart'
    show DropdownButtonFormField2, DropdownStyleData;
import 'package:swift_aid/Screens/personal_details/component/blood_group.dart';
import 'package:swift_aid/Screens/personal_details/component/text_field.dart';
import 'package:swift_aid/Screens/personal_details/component/gender.dart';
import 'package:swift_aid/Screens/personal_details/component/height.dart';
import 'package:swift_aid/Screens/personal_details/component/weight.dart';
import 'package:swift_aid/Screens/personal_details/component/age.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class UserPreferences extends StatefulWidget {
  const UserPreferences({super.key});

  @override
  State<UserPreferences> createState() => _UserPreferencesState();
}

class _UserPreferencesState extends State<UserPreferences> {
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selectedHealthState;
  bool _isVerified = false;
  int? _age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Set Profile',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 15),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey[200]),
                child: Image.asset(
                  'assets/images/splash.png',
                  color: AppColors.primaryColor,
                  cacheHeight: 30,
                  cacheWidth: 30,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 30,
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Enter All Personal Details .....',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(children: [
                const SizedBox(height: 10),
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
                CustomTextFormField(
                  keyboardType: TextInputType.streetAddress,
                  hintText: 'House 7 Apt 4',
                  labelText: 'Address',
                  controller: addressController,
                  labelStyle: const TextStyle(color: AppColors.primaryColor),
                  borderColor: AppColors.primaryColor,
                  errorBorderColor: Colors.red,
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : 'Address is required',
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  keyboardType: TextInputType.text,
                  hintText: 'AB-',
                  labelText: 'Blood Group',
                  controller: bloodGroupController,
                  readOnly: true,
                  onTap: () async {
                    final selectedGroup = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const BloodGroupSelectionScreen()),
                    );
                    if (selectedGroup != null) {
                      setState(() {
                        bloodGroupController.text = selectedGroup;
                      });
                    }
                  },
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : 'Blood Group is required',
                  labelStyle: const TextStyle(color: AppColors.primaryColor),
                  borderColor: AppColors.primaryColor,
                  errorBorderColor: Colors.red,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  keyboardType: TextInputType.text,
                  hintText: '170cm',
                  labelText: 'Height',
                  controller: heightController,
                  readOnly: true,
                  onTap: () async {
                    final selectedHeight = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HeightSelectionScreen(),
                      ),
                    );
                    if (selectedHeight != null) {
                      setState(() {
                        heightController.text = '$selectedHeight cm';
                      });
                    }
                  },
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : 'Height is required',
                  labelStyle: const TextStyle(color: AppColors.primaryColor),
                  borderColor: AppColors.primaryColor,
                  errorBorderColor: Colors.red,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  keyboardType: TextInputType.text,
                  hintText: '20Kg',
                  labelText: 'Weight',
                  controller: weightController,
                  readOnly: true,
                  onTap: () async {
                    final selectedWeight = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WeightSelectionScreen(),
                      ),
                    );
                    if (selectedWeight != null) {
                      setState(() {
                        weightController.text = '$selectedWeight Kg';
                      });
                    }
                  },
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : 'Weight is required',
                  labelStyle: const TextStyle(color: AppColors.primaryColor),
                  borderColor: AppColors.primaryColor,
                  errorBorderColor: Colors.red,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  keyboardType: TextInputType.text,
                  hintText: 'M',
                  labelText: 'Gender',
                  controller: genderController,
                  readOnly: true,
                  onTap: () async {
                    final selectedGender = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GenderSelectionScreen(),
                      ),
                    );
                    if (selectedGender != null) {
                      setState(() {
                        genderController.text = selectedGender;
                      });
                    }
                  },
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : 'Gender is required',
                  labelStyle: const TextStyle(color: AppColors.primaryColor),
                  borderColor: AppColors.primaryColor,
                  errorBorderColor: Colors.red,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField2<String>(
                  decoration: InputDecoration(
                    labelText: 'Health State',
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
                  value: _selectedHealthState,
                  items: [
                    'Healthy',
                    'Sick',
                    'Recovering',
                    'Under Treatment',
                    'Critical',
                    'In Recovery',
                    'Inactive',
                    'Active',
                    'Stable',
                  ]
                      .map((state) => DropdownMenuItem<String>(
                            value: state,
                            child: Text(
                              state,
                              style: const TextStyle(color: Colors.black87),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedHealthState = value;
                    });
                  },
                  dropdownStyleData: DropdownStyleData(
                    width: 180, // Adjusted for better spacing
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
                      value != null ? null : 'Please select a health state',
                ),
                const SizedBox(height: 20),
                SwitchListTile(
                  title: const Text(
                    'Verified',
                    style: TextStyle(color: AppColors.blackColor),
                  ),
                  value: _isVerified,
                  onChanged: (value) {
                    setState(() {
                      _isVerified = value;
                    });
                  },
                  activeColor: AppColors.primaryColor,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  borderRadius: 20.0,
                  text: 'Update Profile',
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      //! logic here --->
                    }
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
    dobController.dispose();
    addressController.dispose();
    heightController.dispose();
    weightController.dispose();
    genderController.dispose();
    bloodGroupController.dispose();
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
}
