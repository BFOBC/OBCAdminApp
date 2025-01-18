import 'package:bf_obc_admin/ui/SeeAllPendingPayments.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PendingPayments extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and "See All" Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pending Payments",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B2559), // Dark text color
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeeAllPendingPayments(),
                    ),
                   );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF4F7FE),
                    foregroundColor: Color(0xFF4318FF),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // List of Payments
            StreamBuilder<QuerySnapshot>(
  stream: _firestore.collection('pendingPayments').orderBy('timestamp', descending: true).snapshots(),
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return Center(child: Text("Error: ${snapshot.error}"));
    }
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return const Center(
        child: Text("No pending payments found."),
      );
    }

    final payments = snapshot.data!.docs;
    print("Fetched Payments: ${payments.length}");
    for (var payment in payments) {
      print(payment.data());
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: payments.length,
      itemBuilder: (context, index) {
        final paymentData = payments[index].data() as Map<String, dynamic>;
        final name = paymentData['name'] ?? "Unknown";
        final scno = paymentData['scno'] ?? "N/A";
        final amount = paymentData['amount'] ?? 0;
        final avatar = paymentData['avatar'] ?? "https://via.placeholder.com/150";

        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(avatar),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1D1E2C),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "SCNO: $scno",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "Rs. $amount",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D1E2C),
                ),
              ),
            ],
          ),
        );
      },
    );
  },
)

          ],
        ),
      ),
    );
  }
}
