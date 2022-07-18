import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mime_type/mime_type.dart';

class CustomSimpleS3 {
  static const MethodChannel _methodChannel = MethodChannel('simple_s3');

  static const EventChannel _eventChannel = EventChannel("simple_s3_events");

  ///Provide stream of dynamic type. This stream contains upload percentage.
  Stream get getUploadPercentage => _eventChannel.receiveBroadcastStream();

  ///Upload function takes File, S3 bucket name, pool ID and region as required param
  ///Default access control is PUBLIC_READ
  ///Debugging is disable by default this will prevent any logs and messages
  ///To enable use debugLog:true
  Future<String> uploadFile(
    File file,
    String bucketName,
    String poolID,
    CustomAWSRegion region, {
    String s3FolderPath = "",
    String? fileName,
    CustomAWSRegion? subRegion,
    S3AccessControl accessControl = S3AccessControl.publicRead,
    bool useTimeStamp = false,
    TimestampLocation timeStampLocation = TimestampLocation.prefix,
    bool debugLog = false,
  }) async {
    Map<String, dynamic> args = <String, dynamic>{};
    String result;
    String contentType;

    if (!await file.exists()) throw SimpleS3Errors.fileDoesNotExistsError;

    if (!(fileName != null && fileName.isNotEmpty)) {
      String originalFileName = file.path.split('/').last.replaceAll(" ", "");

      if (useTimeStamp) {
        int timestamp = DateTime.now().millisecondsSinceEpoch;

        if (timeStampLocation == TimestampLocation.prefix) {
          // ignore: unnecessary_string_escapes
          fileName = '$timestamp\_$originalFileName';
        } else {
          // ignore: unnecessary_string_escapes
          fileName = '${originalFileName.split(".").first}\_$timestamp\.${originalFileName.split(".").last}';
        }
      } else {
        fileName = originalFileName;
      }
    }

    contentType = mime(fileName) ?? "";

    if (debugLog) {
      debugPrint('S3 Upload Started <-----------------');
      debugPrint(" ");
      debugPrint("File Name: $fileName");
      debugPrint(" ");
      debugPrint("Content Type: $contentType");
      debugPrint(" ");
    }

    args.putIfAbsent("filePath", () => file.path);
    args.putIfAbsent("poolID", () => poolID);
    args.putIfAbsent("region", () => region.region);
    args.putIfAbsent("bucketName", () => bucketName);
    args.putIfAbsent("fileName", () => fileName);
    args.putIfAbsent("s3FolderPath", () => s3FolderPath);
    args.putIfAbsent("debugLog", () => debugLog);
    args.putIfAbsent("contentType", () => contentType);
    args.putIfAbsent("subRegion", () => subRegion != null ? subRegion.region : "");
    args.putIfAbsent("accessControl", () => accessControl.index);

    bool methodResult = await _methodChannel.invokeMethod('upload', args);

    if (methodResult) {
      String currentRegion = subRegion != null ? subRegion.region : region.region;
      String currentPath = s3FolderPath != "" ? "$bucketName/$s3FolderPath/$fileName" : "$bucketName/$fileName";

      result = "https://s3-$currentRegion.amazonaws.com/$currentPath";

      if (debugLog) {
        debugPrint("Status: Uploaded");
        debugPrint(" ");
        debugPrint("URL: $result");
        debugPrint(" ");
        debugPrint("Access Type: $accessControl");
        debugPrint(" ");
        debugPrint('S3 Upload Completed-------------->');
        debugPrint(" ");
      }
    } else {
      if (debugLog) {
        debugPrint("Status: Error");
        debugPrint(" ");
        debugPrint('S3 Upload Error------------------>');
      }
      throw SimpleS3Errors.uploadError;
    }

    return result;
  }

  ///S3 Delete static function requires no instance
  ///Returns bool on success
  static Future<bool> delete(
    String filePath,
    String bucketName,
    String poolID,
    CustomAWSRegion region, {
    CustomAWSRegion? subRegion,
    bool debugLog = false,
  }) async {
    Map<String, dynamic> args = <String, dynamic>{};

    if (debugLog) {
      debugPrint('S3 Delete Object Started <--------------');
      debugPrint(" ");
      debugPrint("Object Path: $filePath");
      debugPrint(" ");
    }

    args.putIfAbsent("poolID", () => poolID);
    args.putIfAbsent("region", () => region.region);
    args.putIfAbsent("bucketName", () => bucketName);
    args.putIfAbsent("filePath", () => filePath);
    args.putIfAbsent("debugLog", () => debugLog);
    args.putIfAbsent("subRegion", () => subRegion != null ? subRegion.region : "");

    bool methodResult = await _methodChannel.invokeMethod('delete', args);

    if (methodResult) {
      if (debugLog) {
        debugPrint(" ");
        debugPrint("S3 Delete Completed------------------>");
        debugPrint(" ");
      }
    } else {
      if (debugLog) {
        debugPrint("Status: Error");
        debugPrint(" ");
        debugPrint("S3 Object Deletion Error------------->");
      }
      throw SimpleS3Errors.deleteError;
    }

    return methodResult;
  }
}

class CustomAWSRegion {
  String region;

  CustomAWSRegion(this.region);
}

///AWS regions class created for consistency maintenance
///contains static getters which returns an private class internally.
class AWSRegions {
  static CustomAWSRegion get usEast1 => CustomAWSRegion("us-east-1");

  static CustomAWSRegion get usEast2 => CustomAWSRegion("us-east-2");

  static CustomAWSRegion get usWest1 => CustomAWSRegion("us-west-1");

  static CustomAWSRegion get usWest2 => CustomAWSRegion("us-west-2");

  static CustomAWSRegion get euWest1 => CustomAWSRegion("eu-west-1");

  static CustomAWSRegion get euWest2 => CustomAWSRegion("eu-west-2");

  static CustomAWSRegion get euWest3 => CustomAWSRegion("eu-west-3");

  static CustomAWSRegion get euNorth1 => CustomAWSRegion("eu-north-1");

  static CustomAWSRegion get euCentral1 => CustomAWSRegion("eu-central-1");

  static CustomAWSRegion get apSouthEast1 => CustomAWSRegion("ap-southeast-1");

  static CustomAWSRegion get apSouthEast2 => CustomAWSRegion("ap-southeast-2");

  static CustomAWSRegion get apNorthEast1 => CustomAWSRegion("ap-northeast-1");

  static CustomAWSRegion get apNorthEast2 => CustomAWSRegion("ap-northeast-2");

  static CustomAWSRegion get apSouth1 => CustomAWSRegion("ap-south-1");

  static CustomAWSRegion get apEast1 => CustomAWSRegion("ap-east-1");

  static CustomAWSRegion get saEast1 => CustomAWSRegion("sa-east-1");

  static CustomAWSRegion get cnNorth1 => CustomAWSRegion("cn-north-1");

  static CustomAWSRegion get caCentral1 => CustomAWSRegion("ca-central-1");

  static CustomAWSRegion get usGovWest1 => CustomAWSRegion("us-gov-west-1");

  static CustomAWSRegion get usGovEast1 => CustomAWSRegion("us-gov-east-1");

  static CustomAWSRegion get cnNorthWest1 => CustomAWSRegion("cn-northwest-1");

  static CustomAWSRegion get meSouth1 => CustomAWSRegion("me-south-1");
}

///TimeStamp enum
enum TimestampLocation { prefix, suffix }

///enum for Internal errors
enum SimpleS3Errors { fileDoesNotExistsError, uploadError, deleteError }

///Access control enum
enum S3AccessControl { unknown, private, publicRead, publicReadWrite, authenticatedRead, awsExecRead, bucketOwnerRead, bucketOwnerFullControl }
