import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDataTable extends StatelessWidget {
  const UserDataTable({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> _fetchUserData() async {
    // Replace this with actual Firestore fetch logic
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No users found'));
        }

        final List<Map<String, dynamic>> users = snapshot.data!;

        return DataTable(
          columns: const [
            DataColumn(label: Text('UID')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Passport')),
            DataColumn(label: Text('Division Name')),
            DataColumn(label: Text('Visa')),
            DataColumn(label: Text('Amount')),
            DataColumn(label: Text('Active Status')),
            DataColumn(label: Text('Actions')),
          ],
          rows: users.map((user) {
            return DataRow(
              cells: [
                DataCell(Text(user['uid'] ?? 'N/A')),
                DataCell(Text(user['name'] ?? 'N/A')),
                DataCell(Text(user['passport'] ?? 'N/A')), // Displaying passport name instead of flag
                DataCell(Text(user['division_name'] ?? 'N/A')),
                DataCell(Text(user['visa'] ?? 'N/A')), // Displaying visa name instead of flag
                DataCell(Text(user['amount']?.toString() ?? 'N/A')),
                DataCell(Switch(
                  value: user['is_active'] ?? false,
                  onChanged: (value) {
                    // Add functionality to update active status here
                  },
                )),
                DataCell(Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Replace with edit functionality
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        // Replace with delete functionality
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                )),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
