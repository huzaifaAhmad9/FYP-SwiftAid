import 'package:swift_aid/Screens/hospital/Staff/get_staff_list.dart';
import 'package:swift_aid/Screens/hospital/Staff/add_staff.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HospitalDashboard extends StatefulWidget {
  const HospitalDashboard({super.key});

  @override
  State<HospitalDashboard> createState() => _HospitalDashboardState();
}

class _HospitalDashboardState extends State<HospitalDashboard> {
  bool _isStaffExpanded = false;
  bool _isShiftExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(Icons.notifications),
          SizedBox(
            width: 10,
          )
        ],
        title: const Text(
          'Hospital DashBoard',
          style: TextStyle(color: AppColors.whiteColor, fontSize: 20),
        ),
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mayo Hospital',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'abc@example.com',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightGreyColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '+92 300 1234567',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightGreyColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cases_outlined),
              title: const Text('Cases'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            //! Expandable Staff section
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Staff'),
              trailing: Icon(_isStaffExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down),
              onTap: () {
                setState(() {
                  _isStaffExpanded = !_isStaffExpanded;
                });
              },
            ),
            if (_isStaffExpanded) ...[
              ListTile(
                contentPadding: const EdgeInsets.only(left: 60.0),
                leading: const Icon(Icons.person_add),
                title: const Text('Add Staff'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AddStaff()));
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 60.0),
                leading: const Icon(Icons.search),
                title: const Text('Get Staff'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const GetStaffList()));
                },
              ),
             
            ],

            //! Expandable Staff section
            ListTile(
              leading: const Icon(Icons.timelapse_sharp),
              title: const Text('Shift'),
              trailing: Icon(_isStaffExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down),
              onTap: () {
                setState(() {
                  _isShiftExpanded = !_isShiftExpanded;
                });
              },
            ),
            if (_isShiftExpanded) ...[
              ListTile(
                contentPadding: const EdgeInsets.only(left: 60.0),
                leading: const Icon(Icons.person_add),
                title: const Text('Add Shift'),
                onTap: () {
                  Navigator.pop(context);
                  //! Navigate to Add Staff screen
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 60.0),
                leading: const Icon(Icons.search),
                title: const Text('Get Shift'),
                onTap: () {
                  Navigator.pop(context);
                  //! Navigate to Add Staff screen
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 60.0),
                leading: const Icon(Icons.delete),
                title: const Text('Delete Staff'),
                onTap: () {
                  Navigator.pop(context);
                  //! Navigate to Delete Staff screen
                },
              ),
            ],
            ListTile(
              leading: const Icon(CupertinoIcons.profile_circled),
              title: const Text('Update Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Welcome to Hospital Dashboard!'),
      ),
    );
  }
}
