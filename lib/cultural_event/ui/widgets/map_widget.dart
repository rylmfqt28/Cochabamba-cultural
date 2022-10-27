import 'package:flutter/material.dart';

import 'package:cochabambacultural/cultural_event/utils/location.dart';
import 'package:cochabambacultural/cultural_event/utils/new_marker.dart';

import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';

import 'package:cochabambacultural/cultural_event/constans/map_constants.dart';

class MapWidget extends StatefulWidget {
  final LatLng initialLocation;
  final List<Marker> markers;
  final TextEditingController location;
  final MapController mapController;

  const MapWidget(
      {Key? key,
      required this.initialLocation,
      required this.markers,
      required this.location,
      required this.mapController})
      : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  NewMarker newMarker = NewMarker();
  Location location = Location();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
          center: widget.initialLocation,
          zoom: MapConstants.zoomMap,
          onLongPress: (position, latLng) async {
            widget.mapController.move(latLng, widget.mapController.zoom);
            widget.mapController.move(latLng, widget.mapController.zoom);
            widget.mapController.move(latLng, widget.mapController.zoom);
            String locationEvent = await location.getAddress(latLng);
            setState(() {
              widget.markers.clear();
              widget.markers.add(newMarker.createdMarker(latLng, context));
              widget.initialLocation.latitude = latLng.latitude;
              widget.initialLocation.longitude = latLng.longitude;
              widget.location.text = locationEvent;
            });
          }),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: MapConstants.source,
          onSourceTapped: null,
        ),
      ],
      layers: [
        TileLayerOptions(
          urlTemplate: MapConstants.urlTemplate,
          userAgentPackageName: MapConstants.userAgentPackageName,
        ),
        MarkerLayerOptions(markers: widget.markers)
      ],
    );
  }
}
