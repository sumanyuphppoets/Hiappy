import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hiappy/features/auth/presentation/thank_you_screen.dart';
import 'package:image_picker/image_picker.dart';

class FamilyMemberProfile extends StatefulWidget {
  const FamilyMemberProfile({Key? key}) : super(key: key);

  @override
  State<FamilyMemberProfile> createState() => _FamilyMemberProfileState();
}

class _FamilyMemberProfileState extends State<FamilyMemberProfile> {
  File? _imageFile;
  String? _selectedAvatar;

  final List<String> avatarAssets = [
    'assets/images/avatar1.png',
    'assets/images/avatar2.png',
    'assets/images/avatar3.png',
    'assets/images/avatar4.png',
    'assets/images/avatar5.png',
    'assets/images/avatar6.png',
  ];

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    File? imageFile;

    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.green.shade700),
              title: const Text("Camera"),
              onTap: () async {
                final picked = await picker.pickImage(source: ImageSource.camera);
                if (picked != null) {
                  imageFile = File(picked.path);
                  setState(() {
                    _imageFile = imageFile;
                    _selectedAvatar = null;
                  });
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: Colors.green.shade700),
              title: const Text("Gallery"),
              onTap: () async {
                final picked = await picker.pickImage(source: ImageSource.gallery);
                if (picked != null) {
                  imageFile = File(picked.path);
                  setState(() {
                    _imageFile = imageFile;
                    _selectedAvatar = null;
                  });
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onAvatarSelected(String avatarPath) {
    setState(() {
      _selectedAvatar = avatarPath;
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F8FF),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Image.asset('assets/images/splash_screen_logo.png', height: 60),
            const SizedBox(height: 20),
            const Text('Sign up with Email', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 6),
            const Text(
              'Profile picture',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF3B82F6),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text('Upload a profile picture'),
            const SizedBox(height: 12),

            GestureDetector(
              onTap: () => _pickImage(context),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue.shade100,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : _selectedAvatar != null
                        ? AssetImage(_selectedAvatar!) as ImageProvider
                        : null,
                child: _imageFile == null && _selectedAvatar == null
                    ? const Icon(Icons.camera_alt, color: Colors.white, size: 30)
                    : null,
              ),
            ),

            const SizedBox(height: 20),
            const Text('or select a profile picture'),
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 15,
                runSpacing: 15,
                children: avatarAssets.map((avatarPath) {
                  final isSelected = _selectedAvatar == avatarPath;
                  return GestureDetector(
                    onTap: () => _onAvatarSelected(avatarPath),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.transparent,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(avatarPath),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GestureDetector(
                onTap: () {
                  if (_imageFile != null || _selectedAvatar != null) {
                    // Proceed with selected profile picture
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Next pressed')),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ThankYouScreen(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select or upload a picture')),
                    );
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF10B981)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.double_arrow, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
