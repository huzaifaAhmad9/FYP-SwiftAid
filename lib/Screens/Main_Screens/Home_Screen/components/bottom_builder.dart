import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class BottomBuilder extends StatelessWidget {
  final String name;
  final String profession;
  final String imagePath;
  final double rating;
  final String distance;

  const BottomBuilder({
    super.key,
    required this.name,
    required this.profession,
    required this.imagePath,
    required this.rating,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 250,
      width: 200,
      margin: EdgeInsets.only(right: screenWidth * 0.03),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.03),
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: AppColors.greenColor,
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(imagePath),
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
          Text(
            name,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Text(
            profession,
            style: const TextStyle(
              color: AppColors.greyColor,
              fontSize: 13,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 35,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColorLight.withOpacity(0.1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/star.png',
                              scale: 1.6,
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              rating.toStringAsFixed(1),
                              style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/loc.png',
                      scale: 1.4,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      distance,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomListView extends StatelessWidget {
  const BottomListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = List.generate(
      10,
      (index) => {
        "name": "Dr. Maria Elena $index",
        "profession": "Psychologist",
        "imagePath": 'assets/images/profile.jpg',
        "rating": 4.9,
        "distance": "1.5km\n away"
      },
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          items.length,
          (index) {
            final item = items[index];
            return BottomBuilder(
              name: item["name"],
              profession: item["profession"],
              imagePath: item["imagePath"],
              rating: item["rating"],
              distance: item["distance"],
            );
          },
        ),
      ),
    );
  }
}
