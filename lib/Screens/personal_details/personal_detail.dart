import 'package:swift_aid/Screens/personal_details/component/blood_group.dart';
import 'package:swift_aid/Screens/personal_details/component/text_field.dart';
import 'package:swift_aid/Screens/personal_details/component/gender.dart';
import 'package:swift_aid/Screens/personal_details/component/height.dart';
import 'package:swift_aid/Screens/personal_details/component/weight.dart';
import 'package:swift_aid/Screens/personal_details/component/age.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class PersonalDetail extends StatefulWidget {
  const PersonalDetail({super.key});

  @override
  State<PersonalDetail> createState() => _PersonalDetailState();
}

class _PersonalDetailState extends State<PersonalDetail> {
  final _controllers = List.generate(10, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
  String? _selectedBloodGroup;
  int? _age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Personal Details',
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
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 15,
                ),
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
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Enter All Personal Details .....',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor),
                )
              ],
            ),
            Column(
              children: <Widget>[
                SingleChildScrollView(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: _formKey,
                    child: Column(children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: 'John',
                        labelText: 'First Name',
                        labelStyle:
                            const TextStyle(color: AppColors.primaryColor),
                        controller: _controllers[0],
                        validator: (value) => value != null && value.isNotEmpty
                            ? null
                            : 'First Name is required',
                        borderColor: AppColors.primaryColor,
                        errorBorderColor: Colors.red,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        hintText: 'Doe',
                        labelText: 'Last Name',
                        labelStyle:
                            const TextStyle(color: AppColors.primaryColor),
                        controller: _controllers[1],
                        borderColor: AppColors.primaryColor,
                        errorBorderColor: Colors.red,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'abc@gmail.com',
                        labelText: 'Email',
                        validator: (value) => value != null && value.isNotEmpty
                            ? null
                            : 'Email is required',
                        labelStyle:
                            const TextStyle(color: AppColors.primaryColor),
                        controller: _controllers[2],
                        borderColor: AppColors.primaryColor,
                        errorBorderColor: Colors.red,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.phone,
                        hintText: '3316127647',
                        labelText: 'Phone Num',
                        validator: (value) => value != null &&
                                value.isNotEmpty &&
                                value.length != 10
                            ? null
                            : 'Phone Num is required',
                        labelStyle:
                            const TextStyle(color: AppColors.primaryColor),
                        controller: _controllers[3],
                        borderColor: AppColors.primaryColor,
                        errorBorderColor: Colors.red,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                              _controllers[4].text = '$_age yrs';
                            });
                          }
                        },
                        validator: (value) => value != null && value.isNotEmpty
                            ? null
                            : 'Date of Birth is required',
                        labelStyle:
                            const TextStyle(color: AppColors.primaryColor),
                        controller: _controllers[4],
                        borderColor: AppColors.primaryColor,
                        errorBorderColor: Colors.red,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.text,
                        hintText: 'AB-',
                        labelText: 'Blood Group',
                        controller:
                            TextEditingController(text: _selectedBloodGroup),
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
                              _selectedBloodGroup = selectedGroup;
                            });
                          }
                        },
                        validator: (value) => value != null && value.isNotEmpty
                            ? null
                            : 'Blood Group is required',
                        labelStyle:
                            const TextStyle(color: AppColors.primaryColor),
                        borderColor: AppColors.primaryColor,
                        errorBorderColor: Colors.red,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.text,
                        hintText: '170cm',
                        labelText: 'Height',
                        controller: _controllers[5],
                        readOnly: true,
                        onTap: () async {
                          final selectedHeight = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const HeightSelectionScreen(),
                            ),
                          );
                          if (selectedHeight != null) {
                            setState(() {
                              _controllers[5].text = '$selectedHeight cm';
                            });
                          }
                        },
                        validator: (value) => value != null && value.isNotEmpty
                            ? null
                            : 'Height is required',
                        labelStyle:
                            const TextStyle(color: AppColors.primaryColor),
                        borderColor: AppColors.primaryColor,
                        errorBorderColor: Colors.red,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.text,
                        hintText: '20Kg',
                        labelText: 'Weight',
                        controller: _controllers[6],
                        readOnly: true,
                        onTap: () async {
                          final selectedWeight = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const WeightSelectionScreen(),
                            ),
                          );
                          if (selectedWeight != null) {
                            setState(() {
                              _controllers[6].text = '$selectedWeight Kg';
                            });
                          }
                        },
                        validator: (value) => value != null && value.isNotEmpty
                            ? null
                            : 'Weight is required',
                        labelStyle:
                            const TextStyle(color: AppColors.primaryColor),
                        borderColor: AppColors.primaryColor,
                        errorBorderColor: Colors.red,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.text,
                        hintText: 'M',
                        labelText: 'Gender',
                        controller: _controllers[7],
                        readOnly: true,
                        onTap: () async {
                          final selectedGender = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const GenderSelectionScreen(),
                            ),
                          );
                          if (selectedGender != null) {
                            setState(() {
                              _controllers[7].text = selectedGender;
                            });
                          }
                        },
                        validator: (value) => value != null && value.isNotEmpty
                            ? null
                            : 'Gender is required',
                        labelStyle:
                            const TextStyle(color: AppColors.primaryColor),
                        borderColor: AppColors.primaryColor,
                        errorBorderColor: Colors.red,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        borderRadius: 20.0,
                        text: 'Upload Details',
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            //! --------------------------------
                          }
                        },
                        backgroundColor: AppColors.primaryColor,
                        width: 350,
                      ),
                    ]),
                  ),
                )
              ],
            )
          ]),
        ));
  }

  @override
  void dispose() {
    _controllers.asMap().forEach((i, c) => c.dispose());
    super.dispose();
  }
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
