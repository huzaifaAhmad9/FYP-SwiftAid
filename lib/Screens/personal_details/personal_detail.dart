import 'package:swift_aid/Screens/personal_details/component/text_field.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class PersonalDetail extends StatefulWidget {
  const PersonalDetail({super.key});

  @override
  State<PersonalDetail> createState() => _PersonalDetailState();
}

class _PersonalDetailState extends State<PersonalDetail> {
  final _controllers = List.generate(5, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/images/Button.png",
                ),
                iconSize: 40.0,
              ),
              const SizedBox(
                width: 75,
              ),
              const Text(
                "Personal Detail",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Spacer()
            ],
          ),
          const SizedBox(
            height: 30,
          ),
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
                  labelStyle: const TextStyle(color: AppColors.primaryColor),
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
                  labelStyle: const TextStyle(color: AppColors.primaryColor),
                  controller: _controllers[1],
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
                  validator: (value) =>
                      value != null && value.isNotEmpty && value.length != 11
                          ? null
                          : 'Phone Num is required',
                  labelStyle: const TextStyle(color: AppColors.primaryColor),
                  controller: _controllers[2],
                  borderColor: AppColors.primaryColor,
                  errorBorderColor: Colors.red,
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomButton(
                  text: 'Upload Details',
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      //! --------------------------------
                    }
                  },
                  backgroundColor: AppColors.primaryColor,
                  width: 350,
                )
              ]),
            ),
          )
        ],
      ),
    ));
  }
}
