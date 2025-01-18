import 'package:bf_obc_admin/ui/SeeAllRecentPayments.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecentPaymentsData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream to get recent payments
  Stream<List<Map<String, dynamic>>> getRecentPayments(int limit) {
    return _firestore
        .collection('payments')
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return {
                'name': data['name'] ?? 'Unknown',
                'amount': data['amount'] ?? 'Unknown',
                'avatar': data['avatar'],
                'timestamp': (data['timestamp'] as Timestamp?)?.toDate(),
              };
            }).toList());
  }
}

class RecentPaymentsWidget extends StatelessWidget {
  final RecentPaymentsData _recentPaymentsData = RecentPaymentsData();

  @override
  Widget build(BuildContext context) {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and "See All" Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Payments",
                style: TextStyle(
                  color: Color(0xFF1B2559),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeeAllRecentPayments(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF4F7FE),
                  foregroundColor: const Color(0xFF4318FF),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
          StreamBuilder<List<Map<String, dynamic>>>(
            stream: _recentPaymentsData.getRecentPayments(5),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final payments = snapshot.data ?? [];

              if (payments.isEmpty) {
                return const Text("No recent payments found.");
              }
              final limitedPayments = payments.take(5).toList();
              
              return Column(
                children: payments.map((payment) {
                  return _buildRecentPaymentItem(
                    payment['name'] ?? 'Unknown',
                    payment['avatar'] as String?,
                    "Rs. ${payment['amount']}",
                    _formatTimestamp(payment['timestamp'] as DateTime?),
                  );
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
                    : null,
                child: avatarUrl == null || avatarUrl.isEmpty
                    ? const Icon(Icons.person, color: Colors.blueAccent)
                    : null,
              ),
              const SizedBox(width: 10),
              Text(name),
            ],
          ),
          Row(
            children: [
              Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 75),
              Text(time, style: const TextStyle(color: Colors.grey)),
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
