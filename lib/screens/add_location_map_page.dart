import 'package:cane_9_app/screens/add_location_info_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cane_9_app/keys.dart';

class AddLocationMapPage extends StatefulWidget {
  const AddLocationMapPage({super.key});

  @override
  State<AddLocationMapPage> createState() => _AddLocationMapPageState();
}

class _AddLocationMapPageState extends State<AddLocationMapPage> {
  final TextEditingController _controller = TextEditingController();
  Placemark? placemark;
  double? latitude;
  double? longitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            width: double.infinity,
            height: 30,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(217, 217, 217, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.only(left: 16),
            child: Center(
              child: GooglePlaceAutoCompleteTextField(
                textEditingController: _controller,
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                googleAPIKey: mapsApiKey,
                inputDecoration: const InputDecoration(
                  hintText: 'Enter Address...',
                  border: InputBorder.none,
                ),
                getPlaceDetailWithLatLng: (Prediction prediction) async {
                  double fetchedLongitude =
                      double.parse(prediction.lng.toString());
                  double fetchedLatitude =
                      double.parse(prediction.lat.toString());
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                      fetchedLatitude, fetchedLongitude);
                  setState(() {
                    placemark = placemarks[0];
                    latitude = fetchedLatitude;
                    longitude = fetchedLongitude;
                  });
                },
                itmClick: (Prediction prediction) {
                  _controller.text = prediction.description ?? "";
                  _controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: prediction.description?.length ?? 0),
                  );
                },
              ),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          foregroundColor: const Color.fromRGBO(112, 112, 112, 1),
        ),
        floatingActionButton: placemark == null
            ? null
            : FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) {
                      return AddLocationInfoPage(
                        placemark: placemark!,
                      );
                    },
                  ));
                },
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                child: const Icon(Icons.arrow_forward),
              ));
  }
}
