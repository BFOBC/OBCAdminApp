import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bf_obc_admin/ui/bills/BillDataTable.dart';
import 'package:bf_obc_admin/ui/CommonLayout.dart';

class GenerateBill extends StatelessWidget {
  const GenerateBill({Key? key}) : super(key: key);

  Stream<List<Map<String, dynamic>>> fetchBillsFromFirestore() async* {
  final billsStream = FirebaseFirestore.instance.collection('bills').snapshots();

  await for (final snapshot in billsStream) {
    List<Map<String, dynamic>> billsData = await Future.wait(
      snapshot.docs.map((doc) async {
        Map<String, dynamic> bill = doc.data();
        String? uid = bill['uid'];

        // Initialize additional fields
        String? name;
        String? address;
        String? scNo;

        if (uid != null && uid.isNotEmpty) {
          print('Fetching data for UID: $uid');

          // Check in 'broker' collection
          QuerySnapshot<Map<String, dynamic>> brokerQuery = await FirebaseFirestore.instance
              .collection('broker')
              .where('uid', isEqualTo: uid) // Use 'where' clause to match the uid field
              .get();

          if (brokerQuery.docs.isNotEmpty) {
            print('Broker data found for UID: $uid');
            final brokerData = brokerQuery.docs.first.data();
            name = brokerData['name'];
            address = brokerData['address'];
            scNo = brokerData['scNo'];
          } else {
            print('No broker data found for UID: $uid, checking courier collection');

            // If not in 'broker', check in 'courier' collection
            QuerySnapshot<Map<String, dynamic>> courierQuery = await FirebaseFirestore.instance
                .collection('courier')
                .where('uid', isEqualTo: uid) // Use 'where' clause to match the uid field
                .get();

            if (courierQuery.docs.isNotEmpty) {
              print('Courier data found for UID: $uid');
              final courierData = courierQuery.docs.first.data();
              name = courierData['name'];
              address = courierData['address'];
              scNo = courierData['scNo'];
            } else {
              print('No courier data found for UID: $uid');
            }
          }
        } else {
          print('UID is null or empty');
        }

        // Add the additional fields to the bill data
        bill['name'] = name ?? 'N/A';
        bill['address'] = address ?? 'N/A';
        bill['scNo'] = scNo ?? 'N/A';

        return bill;
      }).toList(),
    );

    yield billsData;
  }
}

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      pageTitle: "Generate Bill",
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bill Information Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Bill",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Add your download logic here
                    },
                    label: const Text("Download"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3965FF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // StreamBuilder for dynamic data
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: fetchBillsFromFirestore(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching data.'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available.'));
                  }
                  return BillDataTable(data: snapshot.data!);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}