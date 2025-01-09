import 'package:bf_obc_admin/ui/CommonLayout.dart';
import 'package:flutter/material.dart';

class AdminProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      pageTitle: "Profile", // Set the page title
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 480,
                width: double.infinity,
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 135,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF868CFF), Color(0xFF4318FF)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Your Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              fontFamily: 'DM Sans',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),
                    buildInfoRow("Admin ID:", "110A"),
                    buildInfoRow("Name:", "Adela Parkson"),
                    buildInfoRow("Address:", "Khumaltar, Lalitpur"),
                    buildInfoRow("Contact No.:", "9841236978"),
                    buildInfoRow("Email:", "Adela98@gmail.com"),
                    buildInfoRow("Password:", "********"),
                  ],
                ),
              ),
              // CircleAvatar positioned in the Stack
              Positioned(
                top: 80,
                right: 60,
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
              ),
              // Edit Button positioned below the CircleAvatar
              Positioned(
                top: 280, // Adjust this value to position the button below the avatar
                right: 90, // Adjust this value to center the button horizontally
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button press to edit profile
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3965FF),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: 40),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}