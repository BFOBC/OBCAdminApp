import 'package:bf_obc_admin/ui/AdminDashboard.dart';
import 'package:bf_obc_admin/ui/AdminLogin.dart';
import 'package:bf_obc_admin/ui/bills/CalculateBill.dart';
import 'package:bf_obc_admin/ui/user_data/ManageUserScreen.dart';
import 'package:bf_obc_admin/ui/ReportsPage.dart';
import 'package:bf_obc_admin/ui/adminprofile.dart';
import 'package:flutter/material.dart';

class SideNavigationBar extends StatefulWidget {
  final bool isActive;

  const SideNavigationBar({Key? key, required this.isActive}) : super(key: key);

  @override
  State<SideNavigationBar> createState() => _SideNavigationBarState();
}

class _SideNavigationBarState extends State<SideNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Profile Section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                SizedBox(height: 10),
                Text(
                  "Admin",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Navigation Menu
          Flexible(
            fit: FlexFit.loose,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildMenuItem(
                    context,
                    Icons.home,
                    "Admin Dashboard",
                    widget.isActive,
                    () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => AdminDashboard()),
                     );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    Icons.analytics,
                    "Reports",
                    false,
                    () {
                      // Navigate to Reports Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReportsPage()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    Icons.people,
                    "Manage User",
                    false,
                    () {
                      // Navigate to Manage User Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ManageUserScreen()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    Icons.receipt,
                    "Generate Bill",
                    false,
                    () {
                      // Navigate to Generate Bill Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CalculateBill()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    Icons.person,
                    "Profile",
                    false,
                    () {
                      // Navigate to Profile Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminProfile()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Logout Button
          Expanded(
  child: Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF868CFF), Color(0xFF4318FF)],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => AdminLoginPage())
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Remove button's border radius
              side: BorderSide.none, // Remove button's border
            ),
            elevation: 0,
          ),
          child: const SizedBox(
            width: double.infinity,
            height: 40,
            child: Center(
              child: Text("Logout", style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    ),
  ),
),

        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context,
      IconData icon,
      String title,
      bool isActive,
      VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: isActive ? Color(0xFF4318FF) : Color(0xFFA3AED0)),
      title: Text(
        title,
        style: TextStyle(color: isActive ? Color(0xFF2B3674) : Color(0xFFA3AED0)),
      ),
      onTap: onTap,
    );
  }
}