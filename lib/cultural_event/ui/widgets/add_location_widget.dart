import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/responsive.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:cochabambacultural/cultural_event/constans/map_constants.dart';

class AddLocationWidget extends StatefulWidget {
  final LatLng initialLocation;
  final List<Marker> markers;
  final MapController mapController;

  const AddLocationWidget(
      {Key? key,
      required this.initialLocation,
      required this.markers,
      required this.mapController})
      : super(key: key);

  @override
  State<AddLocationWidget> createState() => _AddLocationWidgetState();
}

class _AddLocationWidgetState extends State<AddLocationWidget> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return SizedBox(
      height: responsive.hp(20),
      child: FlutterMap(
          mapController: widget.mapController,
          options: MapOptions(
              center: LatLng(-17.3927, -66.1590),
              zoom: MapConstants.zoomPreView),
          nonRotatedChildren: [
            AttributionWidget.defaultWidget(
              source: MapConstants.source,
              onSourceTapped: null,
            ),
          ],
          layers: [
            TileLayerOptions(
                urlTemplate: MapConstants.urlTemplate,
                userAgentPackageName: MapConstants.userAgentPackageName),
            MarkerLayerOptions(markers: widget.markers)
          ]),
    );
  }
}
