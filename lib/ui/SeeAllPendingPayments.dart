import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'CommonLayout.dart'; // Import the CommonLayout

class PendingPayment {
  final FirebaseFirestore _firestore;

  PendingPayment({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getRecentPaymentsStream() {
    return _firestore
        .collection('pendingPayments')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }
}

class SeeAllPendingPayments extends StatelessWidget {
  final PendingPayment paymentRepository = PendingPayment();

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      pageTitle: "Pending Payments", // Set the page title
      child: Card(
        color: Colors.white, // White background
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: paymentRepository.getRecentPaymentsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No recent payments found."),
                    );
                  }

                  final payments = snapshot.data!;

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
      ),
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: const BoxDecoration(color: Colors.transparent), // No background for header
      children: [
        _buildTableCell("UID", isHeader: true),
        _buildTableCell("Users", isHeader: true),
        _buildTableCell("Amount", isHeader: true),
        _buildTableCell("Date", isHeader: true),
      ],
    );
  }

  List<TableRow> _buildTableRows(List<Map<String, dynamic>> payments) {
    return payments.map((data) {
      final uid = data['uid'] ?? "N/A";
      final name = data['name'] ?? "N/A";
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
          _buildTableCell(uid),
          _buildTableCell(name),
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
