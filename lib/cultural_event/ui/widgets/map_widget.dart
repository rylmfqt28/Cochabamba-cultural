import 'package:cochabambacultural/cultural_event/utils/new_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  final LatLng initialLocation;
  final List<Marker> markers;

  const MapWidget(
      {Key? key, required this.initialLocation, required this.markers})
      : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  NewMarker newMarker = NewMarker();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
          center: widget.initialLocation, //LatLng(-17.3927, -66.1590),
          zoom: 9.2,
          onLongPress: (position, latLng) {
            setState(() {
              widget.markers.clear();
              widget.markers.add(newMarker.createdMarker(latLng, context));
            });
          }),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'OpenStreetMap contributors',
          onSourceTapped: null,
        ),
      ],
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.cochabambacultural',
        ),
        MarkerLayerOptions(markers: widget.markers)
      ],
    );
  }
}
