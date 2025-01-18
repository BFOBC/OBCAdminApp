import 'package:bf_obc_admin/ui/reports-screen/PaymentDetails.dart';
import 'package:bf_obc_admin/ui/reports-screen/PendingPayments.dart';
import 'package:bf_obc_admin/ui/reports-screen/StackedChart.dart';
import 'package:flutter/material.dart';
import 'CommonLayout.dart'; // Import the CommonLayout

class ReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      pageTitle: "Reports", // Set the page title
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Payment Details Section
          PaymentDetails(paymentRepository: PaymentRepository()), // Use the PaymentDetails widget

          const SizedBox(height: 20),

          // Container for Weekly Payments and Pending Payments
          Container(
            height: 400, // Specify the height of the container
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Weekly Payments Section
                Expanded(
                  flex: 1,
                  child: StackedChart(), // Use the StackedChart widget
                ),
                const SizedBox(width: 16), // Space between the two columns

                // Pending Payments Section
                Expanded(
                  flex: 1,
                  child: PendingPayments(), // Use the PendingPayments widget
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}