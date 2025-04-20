import 'package:flutter/material.dart';
import 'package:apna_mandi/pages/profile/edit_bank_details.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({super.key});

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  // Sample bank details (replace with actual data in production)
  String accountHolderName = "Kisan";
  String accountNumber = "1234567890";
  String ifscCode = "HDFC0001234";
  String bankName = "HDFC Bank";

  // Function to update the bank details after editing
  void _updateBankDetails(Map<String, String> updatedDetails) {
    setState(() {
      accountHolderName = updatedDetails['accountHolderName']!;
      accountNumber = updatedDetails['accountNumber']!;
      ifscCode = updatedDetails['ifscCode']!;
      bankName = updatedDetails['bankName']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Details'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Title
            Text(
              'Your Bank Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),

            // Bank Details Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Account Holder Name
                    _buildDetailRow('Account Holder Name', accountHolderName),

                    // Account Number
                    _buildDetailRow('Account Number', accountNumber),

                    // IFSC Code
                    _buildDetailRow('IFSC Code', ifscCode),

                    // Bank Name
                    _buildDetailRow('Bank Name', bankName),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Edit Details Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  // Navigate to EditBankDetails and pass current details
                  final updatedDetails = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditBankDetails(
                        currentDetails: {
                          'accountHolderName': accountHolderName,
                          'accountNumber': accountNumber,
                          'ifscCode': ifscCode,
                          'bankName': bankName,
                        },
                      ),
                    ),
                  );

                  // If updated details are received, update the state
                  if (updatedDetails != null) {
                    _updateBankDetails(updatedDetails);
                  }
                },
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text('Edit Details'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to display a detail row
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            '$title:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(width: 10),
          // Value
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
