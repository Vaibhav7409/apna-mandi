import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Import the dart:io package to work with File
import 'package:provider/provider.dart';
import 'package:apna_mandi/providers/user_provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _phoneController = TextEditingController();
  XFile? _image; // Variable to store image file

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _nameController.text = userProvider.name ?? "Kisan";
    _bioController.text = userProvider.bio ?? "I am a farmer from XYZ region.";
    _phoneController.text = "9876543210";
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Picture Section
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _image != null
                      ? FileImage(
                          File(_image!.path)) // Convert the XFile to a File
                      : AssetImage('images/farmer.jpg') as ImageProvider,
                  child: _image == null
                      ? const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 40,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Name Field
            _buildTextField(
              label: 'Name',
              controller: _nameController,
              keyboardType: TextInputType.name,
              icon: Icons.person,
            ),

            // Bio Field
            _buildTextField(
              label: 'Bio',
              controller: _bioController,
              keyboardType: TextInputType.text,
              icon: Icons.text_fields,
            ),

            // Phone Number Field
            _buildTextField(
              label: 'Phone Number',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              icon: Icons.phone,
            ),

            const SizedBox(height: 20),

            // Save Button
            ElevatedButton(
              onPressed: () {
                // Update the UserProvider
                final userProvider =
                    Provider.of<UserProvider>(context, listen: false);
                userProvider.updateUserData(
                  name: _nameController.text,
                  bio: _bioController.text,
                  imagePath: _image?.path,
                );

                // Navigate back with the updated data
                Navigator.pop(context, {
                  'name': _nameController.text,
                  'bio': _bioController.text,
                  'imagePath': _image?.path,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
