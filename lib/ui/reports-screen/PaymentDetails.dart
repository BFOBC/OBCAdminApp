import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Import the intl package

class PaymentDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // White background
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Payment Details",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2B3674), // Header color
              ),
            ),
            const SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('payments').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No payment data available."),
                  );
                }

                final payments = snapshot.data!.docs;

                return Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1),
                  },
                  border: TableBorder(
                    horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  children: [
                    _buildTableHeader(),
                    ..._buildTableRows(payments),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: const BoxDecoration(color: Colors.transparent), // No background for header
      children: [
        _buildTableCell("Users", isHeader: true),
        _buildTableCell("Address", isHeader: true),
        _buildTableCell("Date", isHeader: true),
        _buildTableCell("Amount", isHeader: true),
      ],
    );
  }

  List<TableRow> _buildTableRows(List<QueryDocumentSnapshot> payments) {
    return payments.map((payment) {
      final data = payment.data() as Map<String, dynamic>;
            final name = data['name'] ?? "N/A";
      final address = data['address'] ?? "N/A";
      final amount = data['amount'] ?? "N/A";
      final timestamp = (data['timestamp'] as Timestamp?)?.toDate();
      
      // Format the date using the intl package
      String date = "N/A";
      if (timestamp != null) {
        date = DateFormat("d MMM yyyy").format(timestamp); // Format the date to "12 Jan 2021"
      }

      return TableRow(
        decoration: const BoxDecoration(
          color: Colors.white, // Ensure rows have a white background
        ),
        children: [
          _buildTableCell(name),
          _buildTableCell(address),
          _buildTableCell(date),
          _buildTableCell("Rs. $amount"),
        ],
      );
    }).toList();
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14, // Font size 14px
          fontWeight: isHeader ? FontWeight.normal : FontWeight.bold,
          color: isHeader ? Color(0xFFA3AED0) : Color(0xFF2B3674), // Header and row colors
        ),
      ),
    );
  }
}
