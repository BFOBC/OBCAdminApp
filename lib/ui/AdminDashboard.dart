import 'package:bf_obc_admin/ui/CommonLayout.dart';
import 'package:bf_obc_admin/ui/charts/LineChart.dart';
import 'package:bf_obc_admin/ui/charts/PieChart.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Hardcoded data for the charts
    /*final pieChartData = [
      ActivityData('Deliveries', 50),
      ActivityData('Pickups', 30),
      ActivityData('Returns', 20),
    ];

    final lineChartData = [
      JobsData('Jan', 10),
      JobsData('Feb', 20),
      JobsData('Mar', 15),
      JobsData('Apr', 25),
      JobsData('May', 30),
      JobsData('Jun', 28),
    ];*/

    return CommonLayout(
      pageTitle: "Admin Dashboard", // Set the page title
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Statistics Cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard("Total Users", "50", Icons.people, Color(0xFF4318FF)),
              _buildStatCard("Active User", "45", Icons.person, Color(0xFF4318FF)),
              _buildStatCard("Active Courier", "22", Icons.delivery_dining, Color(0xFF4318FF)),
              _buildStatCard("Active Broker", "23", Icons.business, Color(0xFF4318FF)),
            ],
          ),
          const SizedBox(height: 20),

          // Charts Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Jobs Line Chart
              Expanded(
                flex: 2,
                child: _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Jobs",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      /*LineChartWidget(data: lineChartData),*/ // Replace placeholder with LineChartWidget
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Activity Analysis Pie Chart
              Expanded(
                child: _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Activity Analysis",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      /*PieChartWidget(data: pieChartData),*/ // Replace placeholder with PieChartWidget
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Recent Payments Section
          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Payments",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                _buildRecentPaymentItem("Mithlesh K. Singh", "Rs. 3000", "30s ago"),
                _buildRecentPaymentItem("Suron Maharjan", "Rs. 800", "58s ago"),
                _buildRecentPaymentItem("Sandesh Bajracharya", "Rs. 5500", "1m ago"),
                _buildRecentPaymentItem("Subin Sedhai", "Rs. 2000", "1m ago"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
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
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildRecentPaymentItem(String name, String amount, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blueAccent.withOpacity(0.2),
                child: Icon(Icons.person, color: Colors.blueAccent),
              ),
              const SizedBox(width: 10),
              Text(name),
            ],
          ),
          Row(
            children: [
              Text(amount, style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text(time, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
