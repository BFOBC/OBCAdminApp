import 'package:flutter/material.dart';

class BillDataTable extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const BillDataTable({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.all(0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.resolveWith<Color>(
            (states) => const Color(0xFFE1ECFF).withOpacity(0.3),
          ),
          columns: const [
            DataColumn(label: Text('UID')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Address')),
            DataColumn(label: Text('SCNO.')),
            DataColumn(label: Text('Units')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Due Date')),
            DataColumn(label: Text('Due Amount')),
            DataColumn(label: Text('Total Amount')),
          ],
          rows: data.map((row) {
            return _buildDataRow(row);
          }).toList(),
        ),
      ),
    );
  }

  // Reusable method to build a DataRow
  DataRow _buildDataRow(Map<String, dynamic> row) {
    return DataRow(
      color: WidgetStateProperty.resolveWith<Color>(
        (states) => Colors.white,
      ),
      cells: [
        _buildDataCell(row['uid']),
        _buildDataCell(row['name']),
        _buildDataCell(row['address']),
        _buildDataCell(row['scNo']),
        _buildDataCell(row['units']),
        _buildDataCell(row['date']),
        _buildDataCell(row['dueDate']),
        _buildDataCell(row['dueAmount']),
        _buildDataCell(row['totalAmount']),
      ],
    );
  }

  // Reusable method to build a DataCell
  DataCell _buildDataCell(dynamic value) {
    return DataCell(
      Text(
        value?.toString() ?? '',
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}