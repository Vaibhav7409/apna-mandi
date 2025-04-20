import 'package:flutter/material.dart';

class ActivityHistory extends StatefulWidget {
  const ActivityHistory({super.key});

  @override
  State<ActivityHistory> createState() => _ActivityHistoryState();
}

class _ActivityHistoryState extends State<ActivityHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample sales history (replace with real data from a database or API)
  final List<Map<String, dynamic>> salesHistory = [
    {
      'date': '2024-12-01',
      'crop': 'Wheat',
      'quantity': '50 kg',
      'price': '₹1000',
      'status': 'Completed',
    },
    {
      'date': '2024-12-03',
      'crop': 'Rice',
      'quantity': '30 kg',
      'price': '₹750',
      'status': 'Completed',
    },
    {
      'date': '2024-12-05',
      'crop': 'Millets',
      'quantity': '20 kg',
      'price': '₹400',
      'status': 'Pending',
    },
  ];

  // Sample purchase history
  final List<Map<String, dynamic>> purchaseHistory = [
    {
      'date': '2024-11-28',
      'item': 'Fertilizer',
      'quantity': '2 bags',
      'price': '₹1200',
      'status': 'Completed',
    },
    {
      'date': '2024-11-25',
      'item': 'Seeds',
      'quantity': '5 kg',
      'price': '₹500',
      'status': 'Completed',
    },
    {
      'date': '2024-11-20',
      'item': 'Pesticides',
      'quantity': '3 bottles',
      'price': '₹800',
      'status': 'Completed',
    },
  ];

  // Sample payment history
  final List<Map<String, dynamic>> paymentHistory = [
    {
      'date': '2024-12-01',
      'type': 'Received',
      'amount': '₹1000',
      'description': 'Payment for Wheat sale',
      'status': 'Completed',
    },
    {
      'date': '2024-11-28',
      'type': 'Paid',
      'amount': '₹1200',
      'description': 'Payment for Fertilizer',
      'status': 'Completed',
    },
    {
      'date': '2024-11-25',
      'type': 'Paid',
      'amount': '₹500',
      'description': 'Payment for Seeds',
      'status': 'Completed',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity History'),
        centerTitle: true,
        backgroundColor: Colors.green,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Sales'),
            Tab(text: 'Purchases'),
            Tab(text: 'Payments'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSalesHistory(),
          _buildPurchaseHistory(),
          _buildPaymentHistory(),
        ],
      ),
    );
  }

  Widget _buildSalesHistory() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Sales History',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: salesHistory.length,
              itemBuilder: (context, index) {
                final sale = salesHistory[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              sale['crop'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: sale['status'] == 'Completed'
                                    ? Colors.green.withOpacity(0.2)
                                    : Colors.orange.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                sale['status'],
                                style: TextStyle(
                                  color: sale['status'] == 'Completed'
                                      ? Colors.green
                                      : Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.calendar_today,
                                size: 16, color: Colors.grey[700]),
                            const SizedBox(width: 5),
                            Text(
                              'Date: ${sale['date']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.inventory_2,
                                size: 16, color: Colors.grey[700]),
                            const SizedBox(width: 5),
                            Text(
                              'Quantity: ${sale['quantity']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.currency_rupee,
                                size: 16, color: Colors.grey[700]),
                            const SizedBox(width: 5),
                            Text(
                              'Price: ${sale['price']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseHistory() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Purchase History',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: purchaseHistory.length,
              itemBuilder: (context, index) {
                final purchase = purchaseHistory[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              purchase['item'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: purchase['status'] == 'Completed'
                                    ? Colors.green.withOpacity(0.2)
                                    : Colors.orange.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                purchase['status'],
                                style: TextStyle(
                                  color: purchase['status'] == 'Completed'
                                      ? Colors.green
                                      : Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.calendar_today,
                                size: 16, color: Colors.grey[700]),
                            const SizedBox(width: 5),
                            Text(
                              'Date: ${purchase['date']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.inventory_2,
                                size: 16, color: Colors.grey[700]),
                            const SizedBox(width: 5),
                            Text(
                              'Quantity: ${purchase['quantity']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.currency_rupee,
                                size: 16, color: Colors.grey[700]),
                            const SizedBox(width: 5),
                            Text(
                              'Price: ${purchase['price']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentHistory() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Payment History',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: paymentHistory.length,
              itemBuilder: (context, index) {
                final payment = paymentHistory[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              payment['type'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: payment['type'] == 'Received'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: payment['status'] == 'Completed'
                                    ? Colors.green.withOpacity(0.2)
                                    : Colors.orange.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                payment['status'],
                                style: TextStyle(
                                  color: payment['status'] == 'Completed'
                                      ? Colors.green
                                      : Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.calendar_today,
                                size: 16, color: Colors.grey[700]),
                            const SizedBox(width: 5),
                            Text(
                              'Date: ${payment['date']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.currency_rupee,
                                size: 16, color: Colors.grey[700]),
                            const SizedBox(width: 5),
                            Text(
                              'Amount: ${payment['amount']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.description,
                                size: 16, color: Colors.grey[700]),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                'Description: ${payment['description']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
