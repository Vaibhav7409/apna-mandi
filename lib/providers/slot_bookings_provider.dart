import 'package:flutter/foundation.dart';

class SlotBookingsProvider with ChangeNotifier {
  // List of all booked slots - starting with an empty list
  final List<Map<String, dynamic>> _bookedSlots = [];

  // Getter for all booked slots
  List<Map<String, dynamic>> get bookedSlots => [..._bookedSlots];

  // Getter for upcoming slots
  List<Map<String, dynamic>> get upcomingSlots =>
      _bookedSlots.where((slot) => slot['status'] == 'Upcoming').toList();

  // Getter for completed slots
  List<Map<String, dynamic>> get completedSlots =>
      _bookedSlots.where((slot) => slot['status'] == 'Completed').toList();

  // Getter for cancelled slots
  List<Map<String, dynamic>> get cancelledSlots =>
      _bookedSlots.where((slot) => slot['status'] == 'Cancelled').toList();

  // Add a new booking
  void addBooking(Map<String, dynamic> booking) {
    // Ensure the booking has a status
    if (!booking.containsKey('status')) {
      booking['status'] = 'Upcoming';
    }

    _bookedSlots.add(booking);
    notifyListeners();
  }

  // Update a booking's status
  void updateBookingStatus(
      String date, String time, String market, String newStatus) {
    final index = _bookedSlots.indexWhere((slot) =>
        slot['date'] == date &&
        slot['time'] == time &&
        slot['market'] == market);

    if (index != -1) {
      _bookedSlots[index]['status'] = newStatus;
      notifyListeners();
    }
  }

  // Reschedule a booking
  void rescheduleBooking(
      String date, String time, String market, String newDate, String newTime) {
    final index = _bookedSlots.indexWhere((slot) =>
        slot['date'] == date &&
        slot['time'] == time &&
        slot['market'] == market);

    if (index != -1) {
      _bookedSlots[index]['date'] = newDate;
      _bookedSlots[index]['time'] = newTime;
      notifyListeners();
    }
  }

  // Cancel a booking
  void cancelBooking(String date, String time, String market) {
    updateBookingStatus(date, time, market, 'Cancelled');
  }

  // Complete a booking
  void completeBooking(String date, String time, String market) {
    updateBookingStatus(date, time, market, 'Completed');
  }
}
