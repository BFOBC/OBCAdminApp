import 'package:bf_obc_admin/ui/CommonLayout.dart';
import 'package:bf_obc_admin/ui/bills/GenerateBill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CalculateBill extends StatelessWidget {
  final TextEditingController uidController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController unitsController = TextEditingController();
  final TextEditingController dueAmountController = TextEditingController();

  CalculateBill({Key? key}) : super(key: key);

  void _saveToFirestoreAndNavigate(BuildContext context) async {
    // Save the entered data to Firestore
    try {
      await FirebaseFirestore.instance.collection('bills').add({
        'uid': uidController.text.trim(),
        'date': dateController.text.trim(),
        'dueDate': dueDateController.text.trim(),
        'units': unitsController.text.trim(),
        'dueAmount': dueAmountController.text.trim(),
        'totalAmount': _calculateTotalAmount(unitsController.text),
      });

      // Navigate to GenerateBill screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GenerateBill()),
      );
    } catch (e) {
      // Handle Firestore save error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save bill: $e')),
      );
    }
  }

  String _calculateTotalAmount(String units) {
    int unitCount = int.tryParse(units) ?? 0;
    int totalAmount = unitCount * 40; // Example rate: Rs. 40 per unit
    return 'Rs. $totalAmount';
  }

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      pageTitle: "Generate Bill",
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Calculate Bill",
                  style: TextStyle(
                    color: Color(0xFF2B3674),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField("UID", "Enter user's UID", uidController),
                const SizedBox(height: 16),
                _buildTextField("Date", "Enter Date", dateController),
                const SizedBox(height: 16),
                _buildTextField("Due Date", "Enter due date of bill", dueDateController),
                const SizedBox(height: 16),
                _buildTextField("Units", "Enter user's units", unitsController),
                const SizedBox(height: 16),
                _buildTextField("Bill Due", "Enter due bill amount", dueAmountController),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => _saveToFirestoreAndNavigate(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4318FF),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Calculate",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, String hintText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 34,
          child: TextField(
            controller: controller,
            cursorHeight: 14,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2E65F3)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2B3674), width: 1.5),
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color(0xFFA3AED0),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
