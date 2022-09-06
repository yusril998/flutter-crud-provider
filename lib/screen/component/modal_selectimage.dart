import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_mobile_flutter/screen/component/default_bottomsheet.dart';

showModalChooseImage(BuildContext context,
    {required Function(File) onCallback}) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      builder: (BuildContext pickerContext) {
        return DefaultBottomSheet(widgets: [
          /// feedback card

          /// ratings
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: InkWell(
              onTap: () async {
                final ImagePicker _picker = ImagePicker();

                // Capture a photo
                final XFile? photo =
                    await _picker.pickImage(source: ImageSource.camera);
                if (photo != null) {
                  File retImage = File(photo.path);
                  onCallback(retImage);
                }
              },
              child: Row(
                children: [
                  Icon(
                    Icons.camera,
                    size: 25,
                  ),
                  SizedBox(width: 24),
                  Text(
                    "Kamera",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// edit profile
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: InkWell(
              onTap: () async {
                final ImagePicker _picker = ImagePicker();
                // Pick an image
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  File retImage = File(image.path);
                  onCallback(retImage);
                }
              },
              child: Row(
                children: [
                  Icon(
                    Icons.image,
                    size: 25,
                  ),
                  SizedBox(width: 24),
                  Text(
                    "Galeri",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]);
      });
}
