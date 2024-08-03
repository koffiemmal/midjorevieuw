/**
 * import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart' as webservice;
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as loc;

import 'package:midjo/src/model/location_model.dart';
import 'package:midjo/src/view/account_view.dart';
import 'package:midjo/src/view_models/carstraject_register.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static const LatLng _pGooglePlex = LatLng(6.125626, 1.225418);
  late gmaps.GoogleMapController mapController;
  final TextEditingController _searchController = TextEditingController();
  LatLng _searchLocation = _pGooglePlex;
  LatLng? _userPlace;
  final GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: 'AIzaSyBlwGfh25ryANDshKP-iKPp9iFVgxkiAJ4');
  List<Prediction> _placePredictions = [];
  loc.LocationData? _currentLocation;
  final String apiKey = 'AIzaSyBlwGfh25ryANDshKP-iKPp9iFVgxkiAJ4';
  List<LatLng> polylineCoordinates = [];
  String _totalDuration = '';
  String? _durations;
  LatLng? _start;
  LatLng? _end;

  List<LocationPLace> _LocationMarked = [
    LocationPLace(
        placeName: 'Bé', location: LatLng(6.137126200000001, 1.2490082)),
    LocationPLace(placeName: 'Dékon', location: LatLng(6.1256983, 1.2253621)),
    LocationPLace(
        placeName: 'Kodjoviakope',
        location: LatLng(6.122198699999999, 1.2049233)),
    LocationPLace(
        placeName: 'Adidogome', location: LatLng(6.1256983, 1.2253621)),
    LocationPLace(placeName: 'Zanguéra', location: LatLng(6.228453, 1.1185143)),
    LocationPLace(
        placeName: 'Aeroport de Lomé', location: LatLng(6.1704244, 1.2529823)),
    LocationPLace(
        placeName: 'Tokoin', location: LatLng(6.142058599999999, 1.2109306)),
    LocationPLace(placeName: 'Baguida', location: LatLng(6.1642856, 1.3262744)),
  ];

  Future<void> _getDirections(LatLng startPoint, LatLng endPoint,String duration) async {
    final directions = webservice.GoogleMapsDirections(apiKey: apiKey);
    final response = await directions.directionsWithLocation(
      webservice.Location(lat: startPoint.latitude, lng: startPoint.longitude),
      webservice.Location(lat: endPoint.latitude, lng: endPoint.longitude),
    );

    if (response.isOkay) {
      final route = response.routes[0];
      final polyline = route.overviewPolyline.points;
      final points = PolylinePoints().decodePolyline(polyline);

      setState(() {
        polylineCoordinates = points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
        _totalDuration = route.legs[0].duration.text;
      });
    }
  }

  static Future<String> _getDirectionsTime(
      LatLng startPoint, LatLng endPoint) async {
    String Duration;
    final directions = webservice.GoogleMapsDirections(
        apiKey: 'AIzaSyBlwGfh25ryANDshKP-iKPp9iFVgxkiAJ4');
    final response = await directions.directionsWithLocation(
      webservice.Location(lat: startPoint.latitude, lng: startPoint.longitude),
      webservice.Location(lat: endPoint.latitude, lng: endPoint.longitude),
    );

    if (response.isOkay) {
      final route = response.routes[0];
      Duration = route.legs[0].duration.text;
      return Duration;
    } else {
      return "N/A";
    }
  }

  //_getDirections(_userPlace!, _pGooglePlex);
  @override
  void initState() {
    super.initState();
    _getLocationUpdates();
  }

  Future<void> _getLocationUpdates() async {
    loc.Location location = loc.Location();
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((loc.LocationData currentLocation) {
      setState(() {
        _currentLocation = currentLocation;
        _userPlace =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });

      if (mapController != null) {
        /*       mapController.animateCamera(
          gmaps.CameraUpdate.newCameraPosition(
            gmaps.CameraPosition(target: _userPlace!, zoom: 15),
          ),
        ); */
      }
    });
  }
  

  void _onSearchChanged(String value) async {
    if (value.isEmpty) {
      setState(() {
        _placePredictions = [];
      });
      return;
    }

    final predictions = await _places.autocomplete(
      value,
      components: [Component(Component.country, "tg")],
    );
    setState(() {
      _placePredictions = predictions.predictions;
    });
  }

  void _onPredictionSelected(Prediction prediction) async {
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(prediction.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    setState(() {
      _searchLocation = LatLng(lat, lng);
      _placePredictions = [];
      _searchController.text = prediction.description!;
    });

    mapController.animateCamera(
      gmaps.CameraUpdate.newCameraPosition(
        gmaps.CameraPosition(target: _searchLocation, zoom: 15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          gmaps.GoogleMap(
            initialCameraPosition: gmaps.CameraPosition(
              target: _userPlace ??
                  _pGooglePlex, // Utiliser _pGooglePlex par défaut
              zoom: 15,
            ),
            polylines: {
              gmaps.Polyline(
                polylineId: gmaps.PolylineId('route'),
                points: polylineCoordinates,
                color: Colors.blue,
                width: 5,
              ),
            },
            markers: {
              for (var location in _LocationMarked)
                gmaps.Marker(
                  markerId: gmaps.MarkerId(location.placeName),
                  position: LatLng(
                      location.location.latitude, location.location.longitude),
                  infoWindow:
                      gmaps.InfoWindow(title: 'Station ${location.placeName}'),
                  icon: gmaps.BitmapDescriptor.defaultMarker,
                ),
            },
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onMapCreated: (gmaps.GoogleMapController controller) {
              mapController = controller;
              if (_userPlace != null) {
                mapController.animateCamera(
                  gmaps.CameraUpdate.newCameraPosition(
                    gmaps.CameraPosition(target: _userPlace!, zoom: 15),
                  ),
                );
              }
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 410,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: "Ou allez-vous ?",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        _onSearchChanged(value);
                      },
                    ),
                  ),
                  if (_placePredictions.isEmpty)
                    Column(
                      children: [
                        Container(
                          height: 150, // Adjust height as needed
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _LocationMarked.length,
                            itemBuilder: (BuildContext context, int index) {
                              final String duration =
                                  '${_getDirectionsTime(_userPlace!, _LocationMarked[index].location)}';
                              return CarsTraject(
                                text: _LocationMarked[index].placeName,
                                time: '$duration',
                                function: () {
                                  setState(() {
                                    _getDirections(_userPlace!,
                                        _LocationMarked[index].location);
                                  });
                                  ;
                                },
                              );
                            },
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CarsLongTraject(
                                  text: 'Campus Nord', time: '45min'),
                              CommentCaMarche(text: 'Comment \n ca marche'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (_placePredictions.isNotEmpty)
                    Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount: _placePredictions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_placePredictions[index].description!),
                            onTap: () {
                              _onPredictionSelected(_placePredictions[index]);
                              //      _getDirections(_userPlace!, _placePredictions[index].placeId.l)
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AccountView()));
              },
              child: Container(
                margin: EdgeInsets.only(top: 40, left: 10),
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(162, 0, 0, 0),
                        blurRadius: 5,
                        offset: Offset(1, 5))
                  ]),
                  height: 45,
                  width: 45,
                  child: Image.asset('assets/images/profil.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

 */