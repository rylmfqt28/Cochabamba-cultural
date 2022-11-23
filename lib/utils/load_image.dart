import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:cochabambacultural/utils/app_colors.dart';

import 'package:cochabambacultural/utils/snack_messages.dart';

class LoadImage {
  final SnackMessages snackMessages = SnackMessages();
  final colorApp = AppColors();

  final String _messageImagePrincipal =
      'Solo se puede agregar una imagen principal.';
  final String _messageImageSecondary =
      'Solo se puede agregar 4 imagenes secundarias.';

  Future<String> getPathImageSelected() async {
    final imageSelected = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (imageSelected != null) {
      return imageSelected.path;
    }

    return '';
  }

  Future<String> loadImage(
      int length, int maxQuantity, BuildContext context) async {
    String _path = '';
    if (length < maxQuantity) {
      _path = await getPathImageSelected();
      return _path;
    }

    _messageInfoLoadImage(context,
        (maxQuantity == 1) ? _messageImagePrincipal : _messageImageSecondary);

    return '';
  }

  _messageInfoLoadImage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        snackMessages.getSnack(message, colorApp.infoColor, context, 140));
  }
}
