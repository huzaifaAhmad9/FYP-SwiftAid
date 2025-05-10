import 'package:swift_aid/Screens/doctor_screens/Doctor_Details/doctor_details.dart';
import 'package:swift_aid/Screens/hospital/Staff/add_staff.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GetStaffList extends StatefulWidget {
  const GetStaffList({super.key});

  @override
  State<GetStaffList> createState() => _GetStaffListState();
}

class _GetStaffListState extends State<GetStaffList> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  //! ======================================================================
  //! Make List Only for testing purpose ---- Change it with APi Logic
  List<Map<String, String>> staffList = [
    {
      'name': 'Dr. Sarah Khan',
      'description': 'Senior Cardiologist with 10 years of experience.',
      'specialization': 'Cardiology',
      'image':
          'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8ZG9jdG9yfGVufDB8fDB8fHww'
    },
    {
      'name': 'Dr. Ali Raza',
      'description': 'Expert in neurological disorders.',
      'specialization': 'Neurology',
      'image':
          'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8ZG9jdG9yfGVufDB8fDB8fHww'
    },
    {
      'name': 'Dr. Fatima Sheikh',
      'description': 'Child health and wellness specialist.',
      'specialization': 'Pediatrics',
      'image':
          'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8ZG9jdG9yfGVufDB8fDB8fHww'
    },
  ];
  //! ======================================================================

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredList = _isSearching
        ? staffList
            .where((staff) => staff['name']!
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList()
        : staffList;

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                cursorColor: AppColors.whiteColor,
                style: const TextStyle(color: AppColors.whiteColor),
                decoration: const InputDecoration(
                  hintText: 'Search by name',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                onChanged: (value) => setState(() {}),
              )
            : const Text(
                'All Staff',
                style: TextStyle(color: AppColors.whiteColor),
              ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
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
                'All Staff List .....',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor),
              )
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              physics: const BouncingScrollPhysics(),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final staff = filteredList[index];
                return Slidable(
                  key: ValueKey(staff['id'] ?? index),
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    extentRatio: 0.25,
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AddStaff()));
                        },
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    extentRatio: 0.25,
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          //! Logic here
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Del',
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const DoctorDetails()));
                    },
                    child: Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primaryColor.withAlpha(30),
                          backgroundImage: NetworkImage(staff['image']!),
                        ),
                        title: Text(staff['name'] ?? 'Unknown'),
                        subtitle:
                            Text(staff['description'] ?? 'No description'),
                        trailing: Text(
                          staff['specialization'] ?? 'N/A',
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
      }
    });
  }
}
