import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecentPaymentsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Payments",
            style: TextStyle(
              color: Color(0xFF1B2559),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('payments')
                .orderBy('timestamp', descending: true)
                .limit(5)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Text("No recent payments found.");
              }

              final payments = snapshot.data!.docs;
              return Column(
                children: payments.map((payment) {
                  final data = payment.data() as Map<String, dynamic>;
                  final name = data['name'] ?? 'Unknown';
                  final amount = data['amount'] ?? 'Unknown';
                  final avatarUrl = data['avatar'] ?? null;
                  final timestamp = data['timestamp'] as Timestamp?;
                  final time = timestamp != null ? _formatTimestamp(timestamp.toDate()) : "Unknown time";

                  return _buildRecentPaymentItem(name, avatarUrl, "Rs. $amount", time);
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecentPaymentItem(String name, String? avatarUrl, String amount, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blueAccent.withOpacity(0.2),
              backgroundImage: avatarUrl != null && avatarUrl.isNotEmpty
              ? NetworkImage(avatarUrl)
              : null, // Fallback to null if avatarUrl is empty
              child: avatarUrl == null || avatarUrl.isEmpty
              ? Icon(Icons.person, color: Colors.blueAccent)
              : null, // Display icon only if no avatar URL
              ),
              const SizedBox(width: 10),
              Text(name),
            ],
          ),
          Row(
            children: [
              Text(amount, style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 75),
              Text(time, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime? timestamp) {
    if (timestamp == null) return "Unknown time";
    final duration = DateTime.now().difference(timestamp);
    if (duration.inSeconds < 60) {
      return "${duration.inSeconds}s ago";
    } else if (duration.inMinutes < 60) {
      return "${duration.inMinutes}m ago";
    } else if (duration.inHours < 24) {
      return "${duration.inHours}h ago";
    } else {
      return "${duration.inDays}d ago";
    }
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
