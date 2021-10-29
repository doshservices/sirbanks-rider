import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
// import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:sirbank_rider/model/mapTypeModel.dart';
import 'package:sirbank_rider/provider/socket_controller.dart';
import 'package:sirbank_rider/screen/Dashboard/tripdetail/widget/select_ride_accepted.dart';
import 'widget/select_ride.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;

class TripDetails extends StatefulWidget {
  const TripDetails({Key key}) : super(key: key);

  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  LocationData _currentPosition;
  String _address, _dateTime;
  Completer<GoogleMapController> _controller = Completer();
  String state, region, address = "Search Address";
  GlobalKey<FormState> _distributorFormKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  Location location = Location();
  bool isLoading = false;
  bool _isInit = true;
  double driverslat, driverslon;
  List<dynamic> distributor = [];
  double _originLatitude, _originLongitude;
  double _destLatitude, _destLongitude;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  double lat, long;

  bool _isSearchProcessing = false;

  StreamSubscription _locationSubscription;
  GoogleMapController _mapController;
  LatLng _initialcameraposition = LatLng(6.465422, 3.406448); 
  final String screenName = "HOME";
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  // Completer<GoogleMapController> _controller = Completer();
  // GoogleMapController _controller;

  CircleId selectedCircle;

  String currentLocationName;
  String newLocationName;
  // String _placemark = '';
  // GoogleMapController mapController;
  bool checkPlatform = Platform.isIOS;
  double distance = 0;
  bool nightMode = false;
  VoidCallback showPersBottomSheetCallBack;
  List<MapTypeModel> sampleData = new List<MapTypeModel>();
  // Map<PolylineId, Polyline> _polyLines = <PolylineId, Polyline>{};
  PolylineId selectedPolyline;
  bool isShowDefault = false;
  GoogleMapController _controller1;

  List<bool> isSelected;
  bool availableStatus;


  @override
  void initState() {
    getLoc();
    super.initState();
    isSelected = [true, false];
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }
  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller1 = _cntlr;
    location.onLocationChanged.listen((l) {
      _controller1.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 18),
        ),
      );
    });
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      // await Provider.of<SocketController>(context, listen: false).getTrip;
      setState(() {
        _isInit = false;
        distributor = Provider.of<SocketController>(context, listen: false)
            .getTrip["drivers"];
            print("////////  " + distributor.toString());
        driverslat = distributor[0]['lat'];
        driverslon = distributor[0]['lon'];
      });
      Iterable _markers = Iterable.generate(
        distributor.length,
        (index) {
          return Marker(
              markerId: MarkerId(distributor[index]['lat'].toString()),
              position: LatLng(
                distributor[index]['lat'],
                distributor[index]['lon'],
              ),
              onTap: () {
                // showbottomSheetValue(distributor[index], context);
              },
              infoWindow:
                  InfoWindow(title: distributor[index]['lat'].toString()));
        },
      );
      setState(() {
        // markers = _markers;
      });
    }
    super.didChangeDependencies();
  }


  submit() async {
    FocusScope.of(context).unfocus();

    if (!_distributorFormKey.currentState.validate()) {
      return;
    }
    _distributorFormKey.currentState.save();
    print(state);
    try {
      setState(() {
        isLoading = true;
        address = state + ", " + region;
      });
      var loc = 'warri, Delta';
      print(address);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context).settings.arguments as Map;
    var value = Provider.of<SocketController>(context, listen: false).getTrip;
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.white,
      body: _isInit
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: _initialcameraposition,
                    zoom: 1,
                  ),
                  myLocationEnabled: true,
                  tiltGesturesEnabled: true,
                  compassEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  markers: Set<Marker>.of(markers.values),
                  polylines: Set<Polyline>.of(polylines.values),
                  // circles: Set.of((circle != null) ? [circle] : []),
                  onMapCreated: _onMapCreated,
                ),
                new Positioned(
                    top: 60,
                    left: 30,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 50,
                            child: Card(
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.keyboard_arrow_left),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                      ],
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Consumer<SocketController>(
                    builder: (ctx, datavalue, _) {
                      return datavalue.driverFound == null ?
                      SelectRide(data: data, value: value): SelectRideAcceptedWidgt(data: datavalue.driverFound);}),
                  ),
                )
              ],
            ),
    );
  }

  // void _onMapCreated(GoogleMapController controller) async {
  //   _mapController = controller;
  // }

  _searchDialog(context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        content: Builder(
          builder: (context) {
            return Container();
            // Search(query: widget.trackingNumber);
          },
        ),
      ),
    ).then(
      (value) {
        if (value != null) {
          _initMarkers();
          setState(() {});
        }
      },
    );
  }

  //initialized marker and polylines
  _initMarkers() {
    final data = ModalRoute.of(context).settings.arguments as Map;
    // {"duration":"1 hour 6 mins","distance":"20.0 km","estimatedFare":{"lowerEstimate":2000,"higherEstimate":2200},
// "durationToRider":"2 hours 30 mins","distanceToRider":"37.0 km","drivers":[{"lon":3.2038342,"lat":6.6582027}]}

    _originLatitude = double.parse(driverslat.toString());
    _originLongitude = double.parse(driverslon.toString());
    _destLatitude = double.parse(lat.toString());
    _destLongitude = double.parse(long.toString());

    /// origin marker
    _addMarker(LatLng(_originLatitude, _originLongitude), "Pickup",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "Destination",
        BitmapDescriptor.defaultMarkerWithHue(118));

    _getPolyline();
  }

//get cordinates
  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCgeGrZMAyo5CWsgP6YcYTYaHmVcDkRYB4",
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
      //wayPoints: [PolylineWayPoint(location: "$pickupAddress")],
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

//polyling functions

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.blue, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

//add pickup and destination markers
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: descriptor,
      position: position,
      infoWindow: InfoWindow(
        title: "$id",
      ),
    );
    markers[markerId] = marker;
  }

  getLoc() async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        _initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);

        DateTime now = DateTime.now();
        _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
        _getAddress(_currentPosition.latitude, _currentPosition.longitude)
            .then((value) {
          setState(() {
            lat = _currentPosition.latitude;
            long = _currentPosition.longitude;
            _address = "${value.first.addressLine}";
            _initMarkers();
          });
        });
      });
    });
  }

  Future<List<Address>> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }
}