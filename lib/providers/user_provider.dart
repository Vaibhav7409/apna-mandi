import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Initialize logger
final _logger = Logger('UserProvider');

class UserProvider with ChangeNotifier {
  String? _email;
  String? _name;
  String? _bio;
  String? _imagePath;
  String? _role;
  String? _status;

  String? get email => _email;
  String? get name => _name;
  String? get bio => _bio;
  String? get imagePath => _imagePath;
  String? get role => _role;
  String? get status => _status;

  UserProvider() {
    _logger.info('UserProvider initialized');
    setInitialData();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _bio = prefs.getString('user_bio');
      _imagePath = prefs.getString('user_image_path');
      _role = prefs.getString('user_role');
      _status = prefs.getString('user_status');
      notifyListeners();
    } catch (e) {
      _logger.warning('Error loading saved data: $e');
    }
  }

  Future<void> _saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_bio != null) await prefs.setString('user_bio', _bio!);
      if (_imagePath != null) {
        await prefs.setString('user_image_path', _imagePath!);
      }
      if (_role != null) await prefs.setString('user_role', _role!);
      if (_status != null) await prefs.setString('user_status', _status!);
    } catch (e) {
      _logger.warning('Error saving data: $e');
    }
  }

  void updateUserData({
    String? email,
    String? name,
    String? bio,
    String? imagePath,
    String? role,
    String? status,
  }) {
    try {
      _logger.info(
          'Updating user data: email=$email, name=$name, role=$role, status=$status');

      // Validate inputs
      if (email != null && email.isEmpty) {
        _logger.warning('Attempted to update with empty email');
        return;
      }

      if (name != null && name.isEmpty) {
        _logger.warning('Attempted to update with empty name');
        return;
      }

      // Update data
      if (email != null) _email = email;
      if (name != null) _name = name;
      if (bio != null) _bio = bio;
      if (imagePath != null) _imagePath = imagePath;
      if (role != null) _role = role;
      if (status != null) _status = status;

      _logger.info(
          'User data updated successfully: email=$_email, name=$_name, role=$_role, status=$_status');
      _saveData(); // Save to SharedPreferences
      notifyListeners();
    } catch (e) {
      _logger.severe('Error updating user data: $e');
      // Re-throw to allow caller to handle
      rethrow;
    }
  }

  void setInitialData() {
    try {
      _logger.info('Setting initial user data');
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        _logger.info('Current user found: ${user.uid}');
        _email = user.email;
        // Set name as email prefix if no display name
        _name = user.email?.split('@')[0];
        _bio ??= "I am a farmer from India"; // Default bio
        _role ??= "user"; // Default role
        _status ??= "active"; // Default status
      } else {
        _logger.info('No current user found');
      }
      notifyListeners();
    } catch (e) {
      _logger.severe('Error setting initial data: $e');
    }
  }

  void clearUserData() {
    _email = null;
    _name = null;
    _bio = null;
    _imagePath = null;
    _role = null;
    _status = null;
    notifyListeners();
  }
}
