import 'package:apna_mandi/pages/order.dart';
import 'package:apna_mandi/providers/slot_bookings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apna_mandi/pages/home.dart';

class SlotBookings extends StatefulWidget {
  const SlotBookings({super.key});

  @override
  State<SlotBookings> createState() => _SlotBookingsState();
}

class _SlotBookingsState extends State<SlotBookings> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Upcoming', 'Completed', 'Cancelled'];

  List<Map<String, dynamic>> get filteredSlots {
    final slotBookingsProvider =
        Provider.of<SlotBookingsProvider>(context, listen: false);

    if (_selectedFilter == 'All') {
      return slotBookingsProvider.bookedSlots;
    } else if (_selectedFilter == 'Upcoming') {
      return slotBookingsProvider.upcomingSlots;
    } else if (_selectedFilter == 'Completed') {
      return slotBookingsProvider.completedSlots;
    } else if (_selectedFilter == 'Cancelled') {
      return slotBookingsProvider.cancelledSlots;
    }

    return [];
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Upcoming':
        return Colors.blue;
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slot Bookings'),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filters.map((filter) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(filter),
                      selected: _selectedFilter == filter,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                      backgroundColor: Colors.green.withOpacity(0.1),
                      selectedColor: Colors.green,
                      labelStyle: TextStyle(
                        color: _selectedFilter == filter
                            ? Colors.white
                            : Colors.green,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Booked Slots List
          Expanded(
            child: Consumer<SlotBookingsProvider>(
              builder: (ctx, slotBookingsProvider, child) {
                final slots = filteredSlots;

                if (slots.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No ${_selectedFilter.toLowerCase()} bookings',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        if (_selectedFilter != 'All')
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _selectedFilter = 'All';
                              });
                            },
                            child: const Text('View all bookings'),
                          ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: slots.length,
                  itemBuilder: (context, index) {
                    final slot = slots[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Status and Date Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(slot['status'])
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    slot['status'],
                                    style: TextStyle(
                                      color: _getStatusColor(slot['status']),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  slot['date'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Market and Time
                            Row(
                              children: [
                                Icon(Icons.store, color: Colors.grey[700]),
                                const SizedBox(width: 8),
                                Text(
                                  slot['market'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                Icon(Icons.access_time,
                                    color: Colors.grey[700]),
                                const SizedBox(width: 8),
                                Text(
                                  slot['time'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Slot Number
                            Row(
                              children: [
                                Icon(Icons.place, color: Colors.grey[700]),
                                const SizedBox(width: 8),
                                Text(
                                  'Slot: ${slot['slot']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Crop Details
                            Row(
                              children: [
                                Icon(Icons.agriculture,
                                    color: Colors.grey[700]),
                                const SizedBox(width: 8),
                                Text(
                                  '${slot['crop']} - ${slot['quantity']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Action Buttons
                            if (slot['status'] == 'Upcoming')
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      _showCancelConfirmationDialog(slot);
                                    },
                                    child: const Text(
                                      'Cancel Booking',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      _showRescheduleDialog(slot);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Reschedule'),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to the Order page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Order()),
          );
        },
        backgroundColor: Colors.green,
        icon: const Icon(Icons.add),
        label: const Text('Book New Slot'),
      ),
    );
  }

  void _showCancelConfirmationDialog(Map<String, dynamic> slot) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: Text(
            'Are you sure you want to cancel your booking for ${slot['crop']} on ${slot['date']}?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              // Use the provider to cancel the booking
              Provider.of<SlotBookingsProvider>(context, listen: false)
                  .cancelBooking(slot['date'], slot['time'], slot['market']);

              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking cancelled successfully'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text(
              'Yes, Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showRescheduleDialog(Map<String, dynamic> slot) {
    DateTime selectedDate = DateTime.now();
    String selectedTime = slot['time'];

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Reschedule Booking'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Current booking: ${slot['crop']} on ${slot['date']} at ${slot['time']}'),
              const SizedBox(height: 16),
              const Text('Select new date and time:'),
              const SizedBox(height: 8),
              // Date picker button
              ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: Text(
                  'Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                ),
              ),
              const SizedBox(height: 8),
              // Time dropdown
              DropdownButton<String>(
                value: selectedTime,
                isExpanded: true,
                items: [
                  '09:00 AM',
                  '10:00 AM',
                  '11:00 AM',
                  '12:00 PM',
                  '01:00 PM',
                  '02:00 PM',
                  '03:00 PM',
                  '04:00 PM'
                ].map((String time) {
                  return DropdownMenuItem<String>(
                    value: time,
                    child: Text(time),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedTime = newValue;
                    });
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Format the date
                final formattedDate =
                    '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';

                // Use the provider to reschedule the booking
                Provider.of<SlotBookingsProvider>(context, listen: false)
                    .rescheduleBooking(slot['date'], slot['time'],
                        slot['market'], formattedDate, selectedTime);

                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Booking rescheduled successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Reschedule'),
            ),
          ],
        ),
      ),
    );
  }
}
