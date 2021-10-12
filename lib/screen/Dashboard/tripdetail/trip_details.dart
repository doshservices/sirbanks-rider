import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sirbank_rider/provider/socket_controller.dart';
import 'widget/select_ride.dart';

class TripDetails extends StatefulWidget {
  const TripDetails({Key key}) : super(key: key);

  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  Completer<GoogleMapController> _controller = Completer();
  String state, region, address = "Search Address";
  GlobalKey<FormState> _distributorFormKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool _isInit = true;
  List<dynamic> distributor = [];

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      // await Provider.of<SocketController>(context, listen: false).getTrip;
      setState(() {
        _isInit = false;
        distributor = Provider.of<SocketController>(context, listen: false)
            .getTrip["drivers"];
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
                showbottomSheetValue(distributor[index], context);
              },
              infoWindow:
                  InfoWindow(title: distributor[index]['lat'].toString()));
        },
      );
      setState(() {
        markers = _markers;
      });
    }
    super.didChangeDependencies();
  }

  void showbottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (ctx) {
          return StatefulBuilder(builder: (context, setState) {
            return new Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _distributorFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Container(
                              width: 100,
                              height: 5,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: GestureDetector(
                              onTap: () {
                                showbottomSheet(context);
                              },
                              child: Text(
                                "Search",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  void showbottomSheetValue(distributorModel, BuildContext context) {
    final data = ModalRoute.of(context).settings.arguments as Map;
    var value = Provider.of<SocketController>(context, listen: false).getTrip;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (ctx) {
          return StatefulBuilder(builder: (context, setState) {
            return new Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xff24414D), width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/motor.png',
                                    width: 60,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "${value['durationToRider'].toString()} / ${value['distanceToRider'].toString()}",
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "To your \n Destination",
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xff24414D), width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.my_location_outlined,
                                    color: Color(0xffFB5448),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    data['startloc'].toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    color: Color(0xff24414D),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    data['endloc'].toString(),
                                    style: TextStyle(fontSize: 15),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xff4CE4B1)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                child: Column(children: [
                                  Image.asset('assets/icons/call.png'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Call',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xff4252FF)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                child: Column(children: [
                                  Image.asset('assets/icons/chart.png'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Call',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              // height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xffBEC2CE)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                child: Column(children: [
                                  Image.asset('assets/icons/cancel.png'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Call',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(6.537216, 3.348890), zoom: 5);

  Future<void> _goToTheLake(_kLake) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  void initState() {
    super.initState();
  }

  Iterable markers = [];

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
      // List<Location> locations = await locationFromAddress(address);
      // print("******" + locations.toString());
      // print(locations[0].latitude);
      // final CameraPosition _kLake = CameraPosition(
      //     // bearing: 192.8334901395799,
      //     target: LatLng(locations[0].latitude, locations[0].longitude),
      //     tilt: 59.440717697143555,
      //     zoom: 14);
      // GoogleMap.of(_key).moveCamera(bounds, animated: true, zoom: 16);
      // _goToTheLake(_kLake);
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
                  mapType: MapType.terrain,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: Set.from(markers),
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
                    child: SelectRide(
                      data : data,
                      value : value
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class AppConstant {
  static List<Map<String, dynamic>> list = [
    {"title": "one", "id": "1", "lat": 23.7985053, "lon": 90.3842538},
    {"title": "two", "id": "2", "lat": 23.802236, "lon": 90.3700},
    {"title": "three", "id": "3", "lat": 23.8061939, "lon": 90.3771193},
  ];
}
