import 'package:swift_aid/Screens/personal_details/component/text_field.dart';
import 'package:swift_aid/components/responsive_sized_box.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/components/custom_text.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class EmergencyRegistration extends StatefulWidget {
  const EmergencyRegistration({super.key});

  @override
  State<EmergencyRegistration> createState() => _EmergencyRegistrationState();
}

class _EmergencyRegistrationState extends State<EmergencyRegistration> {
  final _controllers = List.generate(4, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();

  String? _selectedGender;
  bool _hasInjury = false;
  bool _isConscious = true;
  final List<File> _selectedImages = [];

  final ImagePicker _picker = ImagePicker();

  Future<void> _showImagePickerSheet() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (_) => SizedBox(
        height: 120,
        child: Column(
          children: [
            ListTile(
              leading:
                  const Icon(Icons.camera_alt, color: AppColors.primaryColor),
              title: const Text("Take a Photo"),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: AppColors.primaryColor,
              ),
              title: const Text("Choose from Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickMultipleImagesFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  Future<void> _pickMultipleImagesFromGallery() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
      });
    }
  }

  Widget _buildImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: _selectedImages.length + 1,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        if (index == _selectedImages.length) {
          return GestureDetector(
            onTap: _showImagePickerSheet,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(Icons.add, size: 30, color: Colors.grey),
              ),
            ),
          );
        }
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                _selectedImages[index],
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: () {
                  setState(() => _selectedImages.removeAt(index));
                },
                child: const CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.black54,
                  child: Icon(Icons.close, size: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registration',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
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
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      hintText: 'Enter your patient age',
                      labelText: 'Patient Age',
                      cursor: AppColors.primaryColor,
                      validator: (value) => value != null && value.isNotEmpty
                          ? null
                          : 'Age is required',
                      controller: _controllers[1],
                      borderColor: AppColors.primaryColor,
                      errorBorderColor: Colors.red,
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      keyboardType: TextInputType.text,
                      hintText: 'Enter your patient detail',
                      labelText: 'Accident Detail',
                      cursor: AppColors.primaryColor,
                      validator: (value) => value != null && value.isNotEmpty
                          ? null
                          : 'Detail is required',
                      controller: _controllers[2],
                      borderColor: AppColors.primaryColor,
                      errorBorderColor: Colors.red,
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      minLines: 5,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      hintText: 'Note of Patient .....',
                      hintStyle: const TextStyle(
                          color: AppColors.primaryColor,
                          fontStyle: FontStyle.italic),
                      cursor: AppColors.primaryColor,
                      controller: _controllers[3],
                      borderColor: AppColors.primaryColor,
                      errorBorderColor: Colors.red,
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedGender != null
                              ? AppColors.primaryColor
                              : AppColors.primaryColor,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: _selectedGender,
                        icon: const Icon(Icons.arrow_drop_down),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Gender',
                          labelStyle: TextStyle(color: AppColors.primaryColor),
                        ),
                        items: ['Male', 'Female', 'Other']
                            .map((gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text(gender),
                                ))
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selectedGender = value),
                        validator: (value) =>
                            value == null ? 'Select Gender' : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SwitchListTile(
                      title: const Text("Visible Injury"),
                      value: _hasInjury,
                      onChanged: (val) => setState(() => _hasInjury = val),
                      activeColor: AppColors.primaryColor,
                    ),
                    SwitchListTile(
                      title: const Text("Is Conscious"),
                      value: _isConscious,
                      onChanged: (val) => setState(() => _isConscious = val),
                      activeColor: AppColors.primaryColor,
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: _showImagePickerSheet,
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: _selectedImages.isEmpty
                            ? const Center(
                                child: Icon(Icons.add,
                                    size: 50, color: Colors.grey),
                              )
                            : _buildImageGrid(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// Submit Button
                    CustomButton(
                      borderRadius: 20.0,
                      text: 'Send Alert',
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          //! logic here
                        }
                      },
                      backgroundColor: AppColors.primaryColor,
                      width: 350,
                    ),
                    2.heightBox
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
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }
}
