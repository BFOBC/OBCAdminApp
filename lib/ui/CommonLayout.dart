import 'package:flutter/material.dart';
import 'package:bf_obc_admin/ui/SideNavigationBar.dart';

class CommonLayout extends StatelessWidget {
  final String pageTitle;
  final Widget child;

  const CommonLayout({
    Key? key,
    required this.pageTitle,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF4F7FE), // Background color
        child: Row(
          children: [
            // SideNavigationBar
            SideNavigationBar(isActive: true),

            // Main Content Area
            Expanded(
              child: Stack(
                children: [
                  // Content Area with Scroll
                  Positioned.fill(
                    top: 130, // Adjust to leave space for the fixed header
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: child,
                      ),
                    ),
                  ),

                  // Fixed Header
                  Positioned(
                    top: 10,
                    left: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 16.0,
                      ),
                      color: const Color(0xFFF4F7FE), // Header background
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Page Title (Replaces the back button's position)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pageTitle,
                                    style: const TextStyle(
                                      color: Color(0xFF2B3674),
                                      fontFamily: 'DM Sans',
                                      fontSize: 34,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    "Company Name",
                                    style: TextStyle(
                                      color: Color(0xFF05CD99),
                                      fontFamily: 'DM Sans',
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),

                              // Search Bar (Remains in the top-right corner)
                              Container(
                                width: 400,
                                height: 50,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16,),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.search, color: Colors.grey),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Search',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Icon(Icons.dark_mode,
                                        color: Color(0xFFA3AED0)),
                                    SizedBox(width: 16),
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundImage: AssetImage(
                                          'assets/images/avatar.png'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}