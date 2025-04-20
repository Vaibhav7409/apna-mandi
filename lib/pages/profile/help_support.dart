import 'package:flutter/material.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({super.key});

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact Us Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Us',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.green),
                        const SizedBox(width: 10),
                        Text(
                          '+91 98765 43210',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.email, color: Colors.green),
                        const SizedBox(width: 10),
                        Text(
                          'support@apnamandi.com',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.green),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '201310, Block D, Alpha 1,Greater Noida, UP, India',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // FAQs Section
            Text(
              'FAQs',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            FAQItem(
              question: 'What is Apna Mandi?',
              answer:
                  'Apna Mandi is a platform connecting farmers directly to consumers, ensuring fair prices and fresh produce.',
            ),
            FAQItem(
              question: 'How do I book a slot?',
              answer:
                  'You can book a slot by going to the order section in your Home screen and selecting a time that suits you.',
            ),
            FAQItem(
              question: 'How can I contact customer support?',
              answer:
                  'You can contact us via phone at +91 98765 43210 or email us at support@apnamandi.com.',
            ),
            FAQItem(
              question: 'Can I delete my account?',
              answer:
                  'Yes, you can delete your account from the Delete Account section in your profile settings.',
            ),
            FAQItem(
              question: 'How do I list my produce?',
              answer:
                  'Go to the My Produce section, add details about your products, and list them for sale on the platform.',
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for an FAQ Item
class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({required this.question, required this.answer, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              answer,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
