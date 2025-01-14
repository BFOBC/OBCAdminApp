import 'package:flutter/material.dart';
import 'package:bf_obc_admin/ui/AdminDashboard.dart';
import 'package:bf_obc_admin/ui/AdminLogin.dart';
import 'package:bf_obc_admin/ui/bills/CalculateBill.dart';
import 'package:bf_obc_admin/ui/ReportsPage.dart';
import 'package:bf_obc_admin/ui/adminprofile.dart';
import 'package:bf_obc_admin/ui/user_data/ManageUserScreen.dart';

class SideNavigationBar extends StatefulWidget {
  final bool isActive;

  const SideNavigationBar({Key? key, required this.isActive}) : super(key: key);

  @override
  State<SideNavigationBar> createState() => _SideNavigationBarState();
}

class _SideNavigationBarState extends State<SideNavigationBar> {
  int _selectedIndex = 0; // Track the selected index

  // List of screens corresponding to each navigation item
  final List<Widget> _screens = [
    AdminDashboard(),
    ReportsPage(),
    ManageUserScreen(),
    CalculateBill(),
    AdminProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Side Navigation Bar
          Container(
            width: 250,
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
                          _selectedIndex == 0, // Check if this item is selected
                          () {
                            setState(() {
                              _selectedIndex = 0; // Update the selected index
                            });
                          },
                        ),
                        _buildMenuItem(
                          context,
                          Icons.analytics,
                          "Reports",
                          _selectedIndex == 1, // Check if this item is selected
                          () {
                            setState(() {
                              _selectedIndex = 1; // Update the selected index
                            });
                          },
                        ),
                        _buildMenuItem(
                          context,
                          Icons.people,
                          "Manage User",
                          _selectedIndex == 2, // Check if this item is selected
                          () {
                            setState(() {
                              _selectedIndex = 2; // Update the selected index
                            });
                          },
                        ),
                        _buildMenuItem(
                          context,
                          Icons.receipt,
                          "Generate Bill",
                          _selectedIndex == 3, // Check if this item is selected
                          () {
                            setState(() {
                              _selectedIndex = 3; // Update the selected index
                            });
                          },
                        ),
                        _buildMenuItem(
                          context,
                          Icons.person,
                          "Profile",
                          _selectedIndex == 4, // Check if this item is selected
                          () {
                            setState(() {
                              _selectedIndex = 4; // Update the selected index
                            });
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
                            Navigator.push(
                              context,
                              MaterialPageRoute (builder: (context) => AdminLoginPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide.none,
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
          ),

          // Main Content Area
          Expanded(
            child: _screens[_selectedIndex], // Display the selected screen
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
      leading: Icon(icon, color: isActive ? Color(0xFF4318FF) : Color(0xFFA3AED0)), // Update icon color
      title: Text(
        title,
        style: TextStyle(color: isActive ? Color(0xFF012970) : Color(0xFFA3AED0)), // Update text color
      ),
      onTap: onTap,
    );
  }
}