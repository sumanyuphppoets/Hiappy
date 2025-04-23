import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> showImagePickerModal(BuildContext context) async {
  final picker = ImagePicker();
  File? imageFile;

  await showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt, color: Colors.green.shade700),
            title: Text("Camera"),
            onTap: () async {
              final picked = await picker.pickImage(source: ImageSource.camera);
              if (picked != null) {
                imageFile = File(picked.path);
              }
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library, color: Colors.green.shade700),
            title: Text("Gallery"),
            onTap: () async {
              final picked = await picker.pickImage(source: ImageSource.gallery);
              if (picked != null) {
                imageFile = File(picked.path);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );

  return imageFile;
}
