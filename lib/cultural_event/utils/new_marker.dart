import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

class NewMarker {
  Marker createdMarker(LatLng location, BuildContext context) {
    return Marker(
        point: location,
        builder: (context) => SvgPicture.asset(
              'assets/event_icon.svg',
              height: 50,
              width: 40,
            ));
  }
}
