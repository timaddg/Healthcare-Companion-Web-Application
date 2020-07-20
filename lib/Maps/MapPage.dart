import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:dio/dio.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String searchadd;
  Marker marker;
  Circle circle;
  Location _locationTracker = Location();
  Position _currentPosition;
  StreamSubscription _locationsubscription;
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  Completer<GoogleMapController> _controller = Completer();
  MapType _currentMapType = MapType.normal;
  static const LatLng _center = const LatLng(13.0305, 77.5649);

  GoogleMapController mapController;

  List<BankLocations> _banks = BankLocations.getLocations();
  List<DropdownMenuItem<BankLocations>> _dropDownMenuItems;
  BankLocations _selectedLocation;

  Dio dio = new Dio();
  void printLoc() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator.getCurrentPosition().then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });

    Response resp = await dio.get(
        "https://maps.googleapis.com/maps/api/directions/json?origin=${_currentPosition.latitude},${_currentPosition.longitude}&destination=12.964140,77.573196&key=AIzaSyCmScoBJUB3HOurdT4k1snXrin9C0OemfQ");
    var x = resp.data["routes"][0]["legs"][0]["distance"]["text"];
    print(x);
  }

  @override
  void initState() {
    // TODO: implement initState
    _dropDownMenuItems = buildDropDownMenuItems(_banks);
    _selectedLocation = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<BankLocations>> buildDropDownMenuItems(List _banks) {
    List<DropdownMenuItem<BankLocations>> items = List();
    for (BankLocations bank in _banks) {
      items.add(
        DropdownMenuItem(
          value: bank,
          child: Text(bank.name),
        ),
      );
    }
    return items;
  }

  onChangeDropDownItems(BankLocations selectedLocation) {
    setState(() {
      _selectedLocation = selectedLocation;
    });
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  // Searches the entered location, changes camera
  _searchandnavigate() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: LatLng(_selectedLocation.addr.latitude,_selectedLocation.addr.longitude),
        infoWindow: InfoWindow(
          title: _selectedLocation.name,
          snippet: _selectedLocation.desc,
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));

      Geolocator()
          .placemarkFromCoordinates(
              _selectedLocation.addr.latitude, _selectedLocation.addr.longitude)
          .then((result) {
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(
                    result[0].position.latitude, result[0].position.longitude),
                zoom: 40)));
      });

      printLoc();
    });
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/reddot.jpg");
    return byteData.buffer.asUint8List();
  }

//  Zoom minus button
  Future<void> _zoomminus(double zoomval) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _lastMapPosition, zoom: zoomval)));
  }

  // Zoom plus button
  Future<void> _zoomplus(double zoomval) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _lastMapPosition, zoom: zoomval)));
  }

  // Adds a marker
  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  double zoomval = 11.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back,
            ),
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
          title: Text('Google Maps'),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(
          children: <Widget>[
            // To render Google Map
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
            ),

            // Select bank
            Positioned(
                top: 30.0,
                right: 10.0,
                left: 10.0,
                child: Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'Select a bank:',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      DropdownButton(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        value: _selectedLocation,
                        items: _dropDownMenuItems,
                        onChanged: onChangeDropDownItems,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      FlatButton(
                        color: Colors.lightGreen,
                        onPressed: _searchandnavigate,
                       child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),

                      )
                    ],
                  ),
                )),

            // To change satellite/normal view
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 90, 3, 3),
              child: FloatingActionButton(
                heroTag: "btn1",
                onPressed: () {
                  setState(() {
                    _onMapTypeButtonPressed();
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: Colors.green,
                child: const Icon(Icons.map, size: 34.0),
              ),
            ),

            // Buttons to add marker and zoom in
//            Padding(
//              padding: const EdgeInsets.all(16.0),
//              child: Align(
//                alignment: Alignment.topRight,
//                child: Column(
//                  children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.fromLTRB(0, 73, 3, 3),
//                      child: FloatingActionButton(
//                        heroTag: "btn2",
//                        onPressed: _onAddMarkerButtonPressed,
//                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                        backgroundColor: Colors.green,
//                        child: const Icon(Icons.add_location, size: 34.0),
//                      ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.fromLTRB(0, 5, 3, 0),
//                      child: FloatingActionButton(
//                        heroTag: "btn3",
//                        onPressed: () {
//                          zoomval++;
//                          _zoomplus(zoomval);
//                        },
//                        materialTapTargetSize: MaterialTapTargetSize.padded,
//                        backgroundColor: Colors.green,
//                        child: const Icon(Icons.add_circle_outline, size: 31.0),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
          ],
        ),
      ),
    );
  }
}

class BankLocations {
  LatLng addr;
  String name, desc;

  BankLocations(this.addr, this.name, this.desc);

  static List<BankLocations> getLocations() {
    return <BankLocations>[
      BankLocations(
          LatLng(12.999481, 77.569433), "Bangalore Blood Bank", "Malleshwaram"),
      BankLocations(
          LatLng(13.023912, 77.584651), "Grace Blood Bank", "Anand Nagar"),
      BankLocations(
          LatLng(12.998773, 77.552667), "Navarang Blood Bank", "Rajajinagar"),
      BankLocations(
          LatLng(12.964140, 77.573196), "Victoria Hospital", "New Tharagupet"),
      BankLocations(
          LatLng(13.099120, 77.590802), "Lions Blood Bank", "Yelahanka")
    ];
  }
}
