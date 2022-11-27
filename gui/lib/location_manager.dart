import 'package:location/location.dart';

//location manager for lat long coords

class LocationManager {
  double latitude = 90.0;
  double longitude = 135.0;

  LocationManager() {
    initialize();
  }

  void initialize() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        //maybe ask for services to be enabled
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        //maybe ask for permission to be granted
        return;
      }
    }

    locationData = await location.getLocation();
    latitude = locationData.latitude!;
    longitude = locationData.longitude!;
  }
}