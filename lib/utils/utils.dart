import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:reliable/api-services/api_services.dart';
import 'package:reliable/custom-widgets/image_widget.dart';
import 'package:reliable/models/image_upload_response_model.dart';

class Utils {
  static getErrorMessage(
      {required BuildContext context,
      required String title,
      required String message,
      bool isError = true}) async {
    await Flushbar(
      title: title,
      message: message,
      icon: isError
          ? const Icon(
              Icons.error,
            )
          : const Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
      backgroundColor: isError ? Colors.red : Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      borderRadius: BorderRadius.circular(8.0),
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  static showImageUploaded(
      {required BuildContext context, required UploadImageModel uploadImage}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("Image Uploaded"),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                MyImageWidget(url: uploadImage.location.toString()),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  uploadImage.filename.toString(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ]),
              actions: [
                TextButton(
                  onPressed: () {
                    ApiService.launchInBrowser(
                        url: uploadImage.location!.toString());
                  },
                  child: const Text("Open in Browser"),
                )
              ]);
        });
  }
}
