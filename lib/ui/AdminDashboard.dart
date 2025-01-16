import 'package:bf_obc_admin/ui/CommonLayout.dart';
import 'package:bf_obc_admin/ui/dashboard/RecentPayments.dart';
import 'package:bf_obc_admin/ui/dashboard/LineChart.dart';
import 'package:bf_obc_admin/ui/dashboard/PieChart.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      pageTitle: "Admin Dashboard",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Statistics Cards
          Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 14.0), // Add space between cards
        child: _buildStatCard("Total Users", "50", Icons.people, Color(0xFF4318FF)),
      ),
    ),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 14.0),
        child: _buildStatCard("Active User", "45", Icons.person, Color(0xFF4318FF)),
      ),
    ),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 14.0),
        child: _buildStatCard("Active Courier", "22", Icons.delivery_dining, Color(0xFF4318FF)),
      ),
    ),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 14.0),
        child: _buildStatCard("Active Broker", "23", Icons.business, Color(0xFF4318FF)),
      ),
    ),
  ],
),
const SizedBox(height: 20),


          // Charts Section
          Container(
            height: 340,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Total Jobs Line Chart
                Expanded(
                  flex: 3,
                  child: _buildCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(child: LineChartWidget()),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Activity Analysis Pie Chart
                Expanded(
                  flex: 2,
                  child: _buildCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            height: 35,
                            width: 571,
                            child: PieChartWidget(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Recent Payments Section
          RecentPaymentsWidget(),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        height: 94,
        child: _buildCard(
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: color.withOpacity(0.2),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
