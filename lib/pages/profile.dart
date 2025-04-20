import 'package:apna_mandi/pages/profile/activity_history.dart';
import 'package:apna_mandi/pages/profile/bank_details.dart';
import 'package:apna_mandi/pages/profile/edit_profile.dart';
import 'package:apna_mandi/pages/profile/help_support.dart';
import 'package:apna_mandi/pages/profile/settings.dart';
import 'package:apna_mandi/pages/profile/slot_bookings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apna_mandi/providers/user_provider.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userName = userProvider.name ?? 'Kisan';
    final userBio = userProvider.bio ??
        'Bio: Passionate about farming and sustainable agriculture';
    final userImagePath = userProvider.imagePath;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 242, 242, 242),
        title: Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Information Section
              Card(
                color: Color(0xFFF1F8E9),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: userImagePath != null
                            ? FileImage(File(userImagePath))
                            : AssetImage('images/farmer.jpg') as ImageProvider,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userName,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            Text('Farmer',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey)),
                            SizedBox(height: 5),
                            Text(userBio,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Navigation Options
              _buildOptionCard('Edit Profile', Icons.edit, () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfile()),
                );

                // Check if result is not null
                if (result != null) {
                  userProvider.updateUserData(
                    name: result['name'],
                    bio: result['bio'],
                    imagePath: result['imagePath'],
                  );
                }
              }),
              _buildOptionCard('Bank Details', Icons.money_outlined, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BankDetails()),
                );
              }),
              _buildOptionCard('Settings', Icons.settings, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              }),
              _buildOptionCard('Activity/History', Icons.history, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActivityHistory()),
                );
              }),
              _buildOptionCard('Slot Bookings', Icons.calendar_today, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SlotBookings()),
                );
              }),
              _buildOptionCard('Help/Support', Icons.help_outline, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpSupport()),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, color: Color(0xFF6B8E23), size: 28),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Profile(),
  ));
}
