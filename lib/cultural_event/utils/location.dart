import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class Location {
  Future<String> getAddress(LatLng location) async {
    List<Placemark> place =
        await placemarkFromCoordinates(location.latitude, location.longitude);

    String locality = place[0].locality == null ? "" : '${place[0].locality!},';
    String subAdministrativeArea = place[0].subAdministrativeArea == null
        ? ""
        : '${place[0].subAdministrativeArea!},';
    String thoroughfare =
        place[0].thoroughfare == null ? "" : place[0].thoroughfare!;

    return '$locality $subAdministrativeArea $thoroughfare';
  }
}
