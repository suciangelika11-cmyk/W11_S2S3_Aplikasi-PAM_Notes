
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class _Place {
  final String name;
  final LatLng point;

  const _Place(this.name, this.point);
}

const _places = [
  _Place('Kampus', LatLng(-6.2088, 106.8456)),
  _Place('Perpustakaan', LatLng(-6.2095, 106.8470)),
  _Place('Kantin', LatLng(-6.2080, 106.8440)),
];

class CampusMap extends StatelessWidget {
  const CampusMap({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: _places.first.point,
        initialZoom: 15,
      ),

      children: [
        TileLayer(
          urlTemplate:
              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'id.ac.del.pam_notes',
        ),

        MarkerLayer(
          markers: _places.map((p) {
            return Marker(
              point: p.point,
              width: 44,
              height: 44,
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(p.name)),
                  );
                },
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 44,
                ),
              ),
            );
          }).toList(),
        ),

        const RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              '© OpenStreetMap contributors',
            ),
          ],
        ),
      ],
    );
  }
}
