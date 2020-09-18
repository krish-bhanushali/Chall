import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/services.dart';

class Permissions {
  static Future<bool> cameraAndMicrophonePermissionsGranted() async {
    PermissionStatus cameraPermissionStatus = await _getCameraPermission();
    PermissionStatus microphonePermissionStatus =
    await _getMicrophonePermission();

    if (cameraPermissionStatus == PermissionStatus.granted &&
        microphonePermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      _handleInvalidPermissions(
          cameraPermissionStatus, microphonePermissionStatus);
      return false;
    }
  }

  static Future<PermissionStatus> _getCameraPermission() async {


    PermissionStatus statusOfCamera = await Permission.camera.request();

    return statusOfCamera ??
          statusOfCamera.isUndetermined;
  }

  static Future<PermissionStatus> _getMicrophonePermission() async {
    PermissionStatus permission1 ;

      PermissionStatus permissionStatus =
      await Permission.microphone.request();

      return permissionStatus ??
          PermissionStatus.undetermined;


  }

  static void _handleInvalidPermissions(
      PermissionStatus cameraPermissionStatus,
      PermissionStatus microphonePermissionStatus,
      ) {
    if (cameraPermissionStatus == PermissionStatus.denied &&
        microphonePermissionStatus == PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to camera and microphone denied",
          details: null);
    } else if (cameraPermissionStatus == PermissionStatus.denied &&
        microphonePermissionStatus == PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }
}