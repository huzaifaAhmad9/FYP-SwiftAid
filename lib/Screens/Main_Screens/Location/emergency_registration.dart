import 'package:swift_aid/Screens/personal_details/component/text_field.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/components/custom_text.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class EmergencyRegistration extends StatefulWidget {
  const EmergencyRegistration({super.key});

  @override
  State<EmergencyRegistration> createState() => _EmergencyRegistrationState();
}

class _EmergencyRegistrationState extends State<EmergencyRegistration> {
  final _controllers = List.generate(4, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Registration',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              const CustomText(
                text: 'Emergency Registration',
                size: 22.0,
                weight: FontWeight.bold,
              ),
              const CustomText(
                text: 'Send details to your nearest hospital',
                size: 15.0,
                weight: FontWeight.normal,
              ),
              SizedBox(height: screenHeight * 0.03),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      keyboardType: TextInputType.text,
                      hintText: 'Patient Name',
                      labelText: 'Enter your patient name',
                      cursor: AppColors.primaryColor,
                      labelStyle:
                          const TextStyle(color: AppColors.primaryColor),
                      controller: _controllers[0],
                      validator: (value) => value != null && value.isNotEmpty
                          ? null
                          : 'Patient Name is required',
                      borderColor: AppColors.primaryColor,
                      errorBorderColor: Colors.red,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      cursor: AppColors.primaryColor,
                      hintText: 'Enter your patient age',
                      labelText: 'Patient Age',
                      validator: (value) => value != null && value.isNotEmpty
                          ? null
                          : 'Age is required',
                      labelStyle:
                          const TextStyle(color: AppColors.primaryColor),
                      controller: _controllers[1],
                      borderColor: AppColors.primaryColor,
                      errorBorderColor: Colors.red,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      keyboardType: TextInputType.text,
                      cursor: AppColors.primaryColor,
                      hintText: 'Enter your patient detail',
                      labelText: 'Accident Detail',
                      validator: (value) => value != null && value.isNotEmpty
                          ? null
                          : 'Detail is required',
                      labelStyle:
                          const TextStyle(color: AppColors.primaryColor),
                      controller: _controllers[2],
                      borderColor: AppColors.primaryColor,
                      errorBorderColor: Colors.red,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      minLines: 5,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      hintText: 'Note of Patient .....',
                      hintStyle: const TextStyle(
                          color: AppColors.primaryColor,
                          fontStyle: FontStyle.italic),
                      cursor: AppColors.primaryColor,
                      labelStyle:
                          const TextStyle(color: AppColors.primaryColor),
                      controller: _controllers[3],
                      borderColor: AppColors.primaryColor,
                      errorBorderColor: Colors.red,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      borderRadius: 20.0,
                      text: 'Send Alert',
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          //! --------------------------------
                        }
                      },
                      backgroundColor: AppColors.primaryColor,
                      width: 350,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllers.asMap().forEach((i, c) => c.dispose());
    super.dispose();
  }
}
