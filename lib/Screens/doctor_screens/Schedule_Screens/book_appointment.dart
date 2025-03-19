import 'package:swift_aid/Screens/personal_details/component/text_field.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/components/custom_text.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({super.key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;
  String? _selectedGender;
  List<String> availableTimes = [];
  List<String> genders = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    _updateAvailableTimes(_selectedDate);
  }

  void _updateAvailableTimes(DateTime date) {
    setState(() {
      availableTimes = [
        '09:00 AM',
        '10:00 AM',
        '11:00 AM',
        '02:00 PM',
        '03:00 PM',
        '05:00 PM',
        '06:00 PM',
        '07:00 PM',
        '09:00 PM',
        '10:00 PM',
        '10:30 PM',
      ];
      _selectedTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Appointment"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableCalendar(
                focusedDay: _selectedDate,
                firstDay: DateTime.now(),
                lastDay: DateTime.utc(2030, 1, 1),
                calendarFormat: CalendarFormat.week,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDate = selectedDay;
                    _updateAvailableTimes(selectedDay);
                  });
                },
                selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                calendarStyle: const CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: AppColors.greyColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  "Available Time Slots",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.5,
                ),
                itemCount: availableTimes.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedTime == availableTimes[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTime = availableTimes[index];
                      });
                    },
                    child: Card(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.greyColor.withOpacity(0.1),
                      child: Center(
                        child: Text(
                          availableTimes[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              const CustomText(
                text: 'Patient Details',
                size: 17,
                align: TextAlign.left,
                isCenter: false,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                keyboardType: TextInputType.name,
                cursor: AppColors.primaryColor,
                hintText: 'Enter Name',
                labelText: 'Patient Name',
                validator: (value) => value != null && value.isNotEmpty
                    ? null
                    : 'Name is required',
                labelStyle: const TextStyle(color: AppColors.primaryColor),
                borderColor: AppColors.primaryColor,
                errorBorderColor: Colors.red,
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                keyboardType: TextInputType.number,
                cursor: AppColors.primaryColor,
                hintText: 'Enter Patient Age',
                labelText: 'Age',
                validator: (value) => value != null && value.isNotEmpty
                    ? null
                    : 'Age is required',
                labelStyle: const TextStyle(color: AppColors.primaryColor),
                borderColor: AppColors.primaryColor,
                errorBorderColor: Colors.red,
              ),
              const SizedBox(height: 12),
              const CustomText(
                text: 'Gender',
                size: 16,
                align: TextAlign.left,
                isCenter: false,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.5,
                ),
                itemCount: genders.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedGender == genders[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedGender = genders[index];
                      });
                    },
                    child: Card(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.greyColor.withOpacity(0.1),
                      child: Center(
                        child: Text(
                          genders[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              const CustomTextFormField(
                minLines: 5,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                hintStyle: TextStyle(
                    color: AppColors.primaryColor, fontStyle: FontStyle.italic),
                hintText: 'Note of Patient .....',
                cursor: AppColors.primaryColor,
                labelStyle: TextStyle(color: AppColors.primaryColor),
                // controller: _controllers[3],
                borderColor: AppColors.primaryColor,
                errorBorderColor: Colors.red,
              ),
              const SizedBox(height: 20),
              CustomButton(
                borderRadius: 20.0,
                text: 'Set Appointment',
                onPressed: () {
                  //! Logic
                },
                backgroundColor: AppColors.primaryColor,
                width: 350,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
