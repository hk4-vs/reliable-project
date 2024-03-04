import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reliable/models/image_upload_response_model.dart';
import 'package:reliable/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:reliable/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ApiService {
  getAllProductsData() async {
    const url = "https://api.escuelajs.co/api/v1/products";
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      log("response body : ${response.body}");
      log("response statusCode: ${response.statusCode}");
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as List;

        List<ProductModel> products = body.map((e) {
          return ProductModel.fromJson(e);
        }).toList();

        log(products.toString());

        return products;
      } else {
        return throw ("Data fetch failed");
      }
    } catch (e) {
      return throw ("Data fetch failed");
    }
  }

  static Future uploadImage(
      {required File imageFile, required BuildContext context}) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://api.escuelajs.co/api/v1/files/upload'));
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));
    var response = await request.send();

    
    if (response.statusCode == 201 || response.statusCode == 200) {
      log('Image uploaded successfully');
      String responseBody = await response.stream.bytesToString().then((value) {
         Utils.getErrorMessage(
            context: context,
            title: "Success",
            message: "Image uploaded successfully", isError: false);
            return value;
      });
      log("response body: $responseBody");
            return UploadImageModel.fromJson(jsonDecode(responseBody));
     
      
    } else {
      log('Failed to upload image');
      // ignore: use_build_context_synchronously
      Utils.getErrorMessage(
          context: context, title: "Error", message: "Image uploaded failed");
          return null;
    }
  }

  static pickImageFromGallery({required BuildContext context}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
     // ignore: use_build_context_synchronously
     return uploadImage(imageFile: File(pickedFile.path), context: context);
    }
    return null;
  }

 static Future<void> launchInBrowser({required String url}) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
