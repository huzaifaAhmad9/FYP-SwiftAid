import 'package:swift_aid/Screens/doctor_screens/Doctor_Details/doctor_details.dart';
import 'package:swift_aid/components/responsive_sized_box.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class SearchDoctors extends StatefulWidget {
  const SearchDoctors({super.key});

  @override
  State<SearchDoctors> createState() => _SearchDoctorsState();
}

class _SearchDoctorsState extends State<SearchDoctors> {
  final List<Map<String, dynamic>> doctors = [
    {
      "name": "Dr. John Doe",
      "specialty": "Cardiologist",
      "image": "assets/images/dr2.png",
      "rating": 4.5,
      "online": false
    },
    {
      "name": "Dr. Alice Smith",
      "specialty": "Dermatologist",
      "image": "assets/images/dr3.png",
      "rating": 4.0,
      "online": true
    },
    {
      "name": "Dr. Robert Brown",
      "specialty": "Pediatrician",
      "image": "assets/images/dr3.png",
      "rating": 4.2,
      "online": true
    },
    {
      "name": "Dr. Emily Davis",
      "specialty": "Orthopedic",
      "image": "assets/images/dr2.png",
      "rating": 3.8,
      "online": false
    },
    {
      "name": "Dr. William Wilson",
      "specialty": "Neurologist",
      "image": "assets/images/dr3.png",
      "rating": 4.6,
      "online": false
    },
    {
      "name": "Dr. Michael Lee",
      "specialty": "Oncologist",
      "image": "assets/images/dr2.png",
      "rating": 4.1,
      "online": false
    },
  ];

  List<Map<String, dynamic>> filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    filteredDoctors = doctors;
  }

  void filterDoctors(String query) {
    setState(() {
      filteredDoctors = doctors.where((doctor) {
        return doctor["name"]!.toLowerCase().contains(query.toLowerCase()) ||
            doctor["specialty"]!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          4.heightBox,
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const DoctorHomeScreen()));
                },
              ),
              20.widthBox,
              const Text("Doctors",
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              const Spacer(),
              const Icon(Icons.tune),
            ],
          ),
          2.heightBox,
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: TextField(
              onChanged: filterDoctors,
              decoration: InputDecoration(
                hintText: "Search by name or specialty",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide:
                      const BorderSide(color: AppColors.whiteColor, width: 2.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(top: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];
                return DoctorCard(
                  doctorName: doctor["name"]!,
                  specialty: doctor["specialty"]!,
                  imageUrl: doctor["image"]!,
                  rating: doctor["rating"]!,
                  isOnline: doctor["online"]!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String imageUrl;
  final double rating;
  final bool isOnline;

  const DoctorCard({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.imageUrl,
    required this.rating,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DoctorDetails(),
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    child: ClipOval(
                      child: Image.asset(
                        imageUrl,
                        fit: BoxFit.contain,
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                  if (isOnline)
                    const Positioned(
                      bottom: 5,
                      right: 5,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                doctorName,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                specialty,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  Text(
                    "Rating: $rating",
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
