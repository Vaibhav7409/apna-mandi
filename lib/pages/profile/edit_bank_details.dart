import 'package:flutter/material.dart';

class EditBankDetails extends StatefulWidget {
  final Map<String, String>
      currentDetails; // Current bank details passed from BankDetails

  const EditBankDetails({super.key, required this.currentDetails});

  @override
  State<EditBankDetails> createState() => _EditBankDetailsState();
}

class _EditBankDetailsState extends State<EditBankDetails> {
  // TextEditingControllers to handle text input
  late TextEditingController accountHolderNameController;
  late TextEditingController accountNumberController;
  late TextEditingController ifscCodeController;
  late TextEditingController bankNameController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with current bank details
    accountHolderNameController =
        TextEditingController(text: widget.currentDetails['accountHolderName']);
    accountNumberController =
        TextEditingController(text: widget.currentDetails['accountNumber']);
    ifscCodeController =
        TextEditingController(text: widget.currentDetails['ifscCode']);
    bankNameController =
        TextEditingController(text: widget.currentDetails['bankName']);
  }

  // Function to save and return the updated details to the previous screen
  void _saveChanges() {
    Map<String, String> updatedDetails = {
      'accountHolderName': accountHolderNameController.text,
      'accountNumber': accountNumberController.text,
      'ifscCode': ifscCodeController.text,
      'bankName': bankNameController.text,
    };

    // Pop the screen and pass the updated details back
    Navigator.pop(context, updatedDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Bank Details'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Text
            Text(
              'Edit Your Bank Details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),

            // Account Holder Name Input
            TextField(
              controller: accountHolderNameController,
              decoration: const InputDecoration(
                labelText: 'Account Holder Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Account Number Input
            TextField(
              controller: accountNumberController,
              decoration: const InputDecoration(
                labelText: 'Account Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // IFSC Code Input
            TextField(
              controller: ifscCodeController,
              decoration: const InputDecoration(
                labelText: 'IFSC Code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Bank Name Input
            TextField(
              controller: bankNameController,
              decoration: const InputDecoration(
                labelText: 'Bank Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            // Save Button (Attractive)
            Center(
              child: ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                ),
                child: Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
