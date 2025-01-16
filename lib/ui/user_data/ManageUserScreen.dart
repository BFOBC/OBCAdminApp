import 'package:bf_obc_admin/ui/AddUserScreen.dart';
import 'package:bf_obc_admin/ui/CommonLayout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:country_icons/country_icons.dart';

class ManageUserScreen extends StatelessWidget {
  const ManageUserScreen({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> fetchUserData() async {
    try {
      List<Map<String, dynamic>> users = [];
      QuerySnapshot courierSnapshot =
          await FirebaseFirestore.instance.collection('courier').get();

      for (var doc in courierSnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        final List<dynamic> passports = data['passports'] ?? [];
        String passportCountries = passports
            .map((passport) => passport['countryName'] ?? 'N/A')
            .join(', ');

        final List<dynamic> visas = data['visas'] ?? [];
        String visaCountries =
            visas.map((visa) => visa['countryName'] ?? 'N/A').join(', ');

        users.add({
          'uid': data['uid'] ?? 'N/A',
          'name': data['name'] ?? 'N/A',
          'passports': passportCountries,
          'domain': data['domain'] ?? 'N/A',
          'visas': visaCountries,
          'amount': data['amount'] ?? 'N/A',
          'status': data['active'] ?? false,
        });
      }

      return users;
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      return [];
    }
  }

  String getCountryCode(String countryName) {
    final Map<String, String> countryCodes = {
      'pakistan': 'pk',
      'india': 'in',
      'usa': 'us',
      'germany': 'de',
    };

    String? code = countryCodes[countryName.toLowerCase()];
    if (code == null) {
      debugPrint("Warning: Country name '$countryName' not recognized.");
      return 'unknown';
    }
    return code;
  }

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      pageTitle: "Manage User",
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Row with "Add User" button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "User Details",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddUserScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3965FF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text("Add User"),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // User Data Table with white background
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: fetchUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error loading user data.'),
                        );
                      } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        List<Map<String, dynamic>> users = snapshot.data!;

                        return DataTable(
                          columnSpacing: 50.0,
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => const Color.fromARGB(255, 255, 255, 255)),
                          headingTextStyle: const TextStyle(
                            color: Color(0xFFA3AED0),
                            fontWeight: FontWeight.w500,
                            fontFamily: 'DM Sans',
                            fontSize: 14.0,
                          ),
                          dataTextStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          columns: const [
                            DataColumn(label: Text('UID')),
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('Passport Countries')),
                            DataColumn(label: Text('Domain Name')),
                            DataColumn(label: Text('Visa Countries')),
                            DataColumn(label: Text('Amount')),
                            DataColumn(label: Text('Active Status')),
                            DataColumn(label: Text('Action')),
                          ],
                          rows: users.map((user) {
                            List<String> passportCountries =
                                user['passports'].split(', ');
                            List<String> visaCountries =
                                user['visas'].split(', ');

                            return DataRow(cells: [
                              DataCell(Text(user['uid'])),
                              DataCell(Text(user['name'])),
                              DataCell(Row(
                                children: passportCountries.map((country) {
                                  String countryCode =
                                      getCountryCode(country);
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(right: 8.0),
                                    child: Image.asset(
                                      'assets/images/flags/${countryCode.toLowerCase()}.png',
                                      height: 30,
                                      width: 30,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(Icons.flag,
                                            color: Colors.grey);
                                      },
                                    ),
                                  );
                                }).toList(),
                              )),
                              DataCell(Text(user['domain'])),
                              DataCell(Row(
                                children: visaCountries.map((country) {
                                  String countryCode =
                                      getCountryCode(country);
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(right: 8.0),
                                    child: Image.asset(
                                      'assets/images/flags/${countryCode.toLowerCase()}.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                  );
                                }).toList(),
                              )),
                              DataCell(Text(user['amount'].toString())),
                              DataCell(
                                Switch(
                                  value: user['status'],
                                  onChanged: (value) {
                                    // Update status logic
                                  },
                                  activeColor: Color(0xFF2B3674), // Active color
                                  inactiveTrackColor: Color.fromARGB(255, 248, 249, 255), // Inactive track color
                                ),
                              ),
                              DataCell(Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit_note_outlined,
                                        color: Colors.blue,
                                        size: 30),
                                    onPressed: () {
                                      // Edit action logic
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline,
                                        color: Colors.red,
                                        size: 30,),
                                    onPressed: () {
                                      // Delete action logic
                                    },
                                  ),
                                ],
                              )),
                            ]);
                          }).toList(),
                        );
                      } else {
                        return const Center(child: Text('No users found.'));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
