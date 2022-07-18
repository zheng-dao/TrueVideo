// import 'package:location/location.dart';
import 'package:truvideo_enterprise/service/location/_interface.dart';

class LocationServiceImpl extends LocationService {
  // final Location _location;
  //
  // //#region Initializers
  //
  // LocationServiceImpl({Location? location})
  //     : _location = location ?? Location();
  //
  // //#endregion
  //
  // @override
  // Future<LocationModel> getCurrentLocation() async {
  //   var serviceEnabled = await _location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await _location.requestService();
  //     if (!serviceEnabled) {
  //       throw CustomException(message: "Location service disabled");
  //     }
  //   }
  //
  //   var permissionGranted = await _location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await _location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       throw CustomException(message: "Location permission denied");
  //     }
  //   }
  //
  //   final data = await _location.getLocation();
  //   if (data.latitude == null || data.longitude == null) {
  //     throw CustomException();
  //   }
  //
  //   return LocationModel(
  //     latitude: data.latitude ?? 0.0,
  //     longitude: data.longitude ?? 0.0,
  //   );
  // }
  //
  // @override
  // Future<bool> requestPermission() async {
  //   var serviceEnabled = await _location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await _location.requestService();
  //     if (!serviceEnabled) {
  //       return false;
  //     }
  //   }
  //
  //   var permissionGranted = await _location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await _location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       return false;
  //     }
  //   }
  //
  //   return true;
  // }
  //
  // @override
  // Future<bool> withPermission() async {
  //   var serviceEnabled = await _location.serviceEnabled();
  //   if (!serviceEnabled) return false;
  //
  //   var permissionGranted = await _location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) return false;
  //
  //   return true;
  // }

}
