import 'package:bf_obc_admin/ui/AdminDashboard.dart';
import 'package:bf_obc_admin/ui/AdminLogin.dart';
import 'package:bf_obc_admin/ui/bills/CalculateBill.dart';
import 'package:bf_obc_admin/ui/ReportsPage.dart';
import 'package:bf_obc_admin/ui/adminprofile.dart';
import 'package:bf_obc_admin/ui/user_data/ManageUserScreen.dart';
import 'package:flutter/material.dart';

class SideNavigationBar extends StatefulWidget {
  final bool isActive;

  const SideNavigationBar({Key? key, required this.isActive}) : super(key: key);

  @override
  State<SideNavigationBar> createState() => _SideNavigationBarState();
}

class _SideNavigationBarState extends State<SideNavigationBar> {
  int _selectedIndex = 0; // Track the selected index

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the selected index from the route settings
    final routeSettings = ModalRoute.of(context)?.settings;
    if (routeSettings != null && routeSettings.arguments != null) {
      _selectedIndex = routeSettings.arguments as int;
    }
  }

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
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                const SizedBox(height: 10),
                const Text(
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
                    _selectedIndex == 0,
                    () => _onMenuItemTap(0, AdminDashboard()),
                  ),
                  _buildMenuItem(
                    context,
                    Icons.analytics,
                    "Reports",
                    _selectedIndex == 1,
                    () => _onMenuItemTap(1, ReportsPage()),
                  ),
                  _buildMenuItem(
                    context,
                    Icons.people,
                    "Manage User",
                    _selectedIndex == 2,
                    () => _onMenuItemTap(2, ManageUserScreen()),
                  ),
                  _buildMenuItem(
                    context,
                    Icons.receipt,
                    "Generate Bill",
                    _selectedIndex == 3,
                    () => _onMenuItemTap(3, CalculateBill()),
                  ),
                  _buildMenuItem(
                    context,
                    Icons.person,
                    "Profile",
                    _selectedIndex == 4,
                    () => _onMenuItemTap(4, AdminProfile()),
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => AdminLoginPage()),
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
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    bool isActive,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: isActive ? Color(0xFF4318FF) : Color(0xFFA3AED0)), // Active icon color
      title: Text(
        title,
        style: TextStyle(color: isActive ? Color(0xFF2B3674) : Color(0xFFA3AED0),fontWeight: FontWeight.w400), // Active text color
      ),
      onTap: onTap,
    );
  }

  void _onMenuItemTap(int index, Widget page) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
        settings: RouteSettings(arguments: index), // Pass the selected index
      ),
    );
  }
}