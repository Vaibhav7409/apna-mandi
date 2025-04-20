import 'dart:io'; // Importing dart:io package for File
import 'package:image_picker/image_picker.dart'; // Importing image_picker package
import 'package:flutter/material.dart';
import 'package:apna_mandi/providers/slot_bookings_provider.dart';
import 'package:provider/provider.dart';
import 'profile/slot_bookings.dart'; // Import the SlotBookings class

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String _selectedDate = '';
  String _selectedTime = '09:00 AM';
  String _selectedCrop = 'Wheat';
  String _quantity = '';

  // Location fields
  final _villageController = TextEditingController();
  final _districtController = TextEditingController();
  final _stateController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _nearbyController = TextEditingController();

  // Available options
  final List<String> _timeSlots = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM'
  ];
  final List<String> _crops = [
    'Wheat',
    'Rice',
    'Maize',
    'Pulses',
    'Millets',
    'Vegetables',
    'Fruits',
    'Sugarcane',
    'Cotton',
    'Tobacco'
  ];

  // Image picker
  XFile? _image;

  @override
  void initState() {
    super.initState();
    // Set default date to tomorrow
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    _selectedDate =
        '${tomorrow.year}-${tomorrow.month.toString().padLeft(2, '0')}-${tomorrow.day.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _villageController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _pincodeController.dispose();
    _nearbyController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  void _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate =
            '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Agriculture Pickup'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Crop Details
              _buildSectionHeader('Crop Details', Icons.agriculture),
              const SizedBox(height: 16),

              // Crop Selection
              _buildDropdownField(
                label: 'Select Crop',
                value: _selectedCrop,
                items: _crops,
                onChanged: (value) {
                  setState(() {
                    _selectedCrop = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a crop';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Quantity Input
              _buildTextField(
                label: 'Quantity (Quintal)',
                controller: TextEditingController(text: _quantity),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _quantity = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter quantity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Crop Image Upload
              _buildImageUploadSection(),
              const SizedBox(height: 24),

              // Section 2: Location Details
              _buildSectionHeader('Location Details', Icons.location_on),
              const SizedBox(height: 16),

              // Village
              _buildTextField(
                label: 'Village',
                controller: _villageController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter village name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // District
              _buildTextField(
                label: 'District',
                controller: _districtController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter district name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // State
              _buildTextField(
                label: 'State',
                controller: _stateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter state name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Pincode
              _buildTextField(
                label: 'Pincode',
                controller: _pincodeController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter pincode';
                  }
                  if (value.length != 6) {
                    return 'Pincode must be 6 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Nearby Landmark
              _buildTextField(
                label: 'Nearby Landmark',
                controller: _nearbyController,
                hintText: 'e.g., Temple, School, etc.',
              ),
              const SizedBox(height: 24),

              // Section 3: Pickup Details
              _buildSectionHeader('Pickup Details', Icons.calendar_today),
              const SizedBox(height: 16),

              // Date Selection
              _buildDateField(),
              const SizedBox(height: 16),

              // Time Selection
              _buildDropdownField(
                label: 'Select Time',
                value: _selectedTime,
                items: _timeSlots,
                onChanged: (value) {
                  setState(() {
                    _selectedTime = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _confirmOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Book Pickup',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.green),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    required String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    TextInputType? keyboardType,
    Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            hintText: hintText,
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
          keyboardType: keyboardType,
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Date',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _selectDate,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade50,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDate,
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload Crop Image',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(_image!.path),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const Icon(
                      Icons.image,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload Image'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _confirmOrder() {
    if (_selectedCrop.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a crop')),
      );
      return;
    }

    if (_quantity.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter quantity')),
      );
      return;
    }

    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload a crop image')),
      );
      return;
    }

    if (_selectedDate.isEmpty || _selectedTime.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select pickup date and time')),
      );
      return;
    }

    if (_villageController.text.isEmpty ||
        _districtController.text.isEmpty ||
        _stateController.text.isEmpty ||
        _pincodeController.text.isEmpty ||
        _nearbyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter location details')),
      );
      return;
    }

    try {
      // Create a new booking with explicit status
      final booking = {
        'date': _selectedDate,
        'time': _selectedTime,
        'market':
            'Default Market', // Using a default market since we removed market selection
        'slot':
            'A-${DateTime.now().millisecondsSinceEpoch % 100}', // Generate a random slot number
        'status': 'Upcoming', // Explicitly set status to Upcoming
        'crop': _selectedCrop,
        'quantity': '$_quantity Quintal',
        'location': {
          'village': _villageController.text,
          'district': _districtController.text,
          'state': _stateController.text,
          'pincode': _pincodeController.text,
          'nearby': _nearbyController.text,
        },
        'imagePath': _image!.path,
      };

      // Add the booking to the provider
      Provider.of<SlotBookingsProvider>(context, listen: false)
          .addBooking(booking);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pickup booked successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Wait for the snackbar to be visible
      Future.delayed(const Duration(milliseconds: 500), () {
        // Check if the widget is still mounted before using context
        if (mounted) {
          // Navigate to the slot bookings page instead of going back
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SlotBookings()),
          );
        }
      });
    } catch (e) {
      // Show error message if something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error booking pickup: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: const Order(),
  ));
}
