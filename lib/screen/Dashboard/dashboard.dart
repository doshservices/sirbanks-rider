import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:sirbank_rider/model/mapTypeModel.dart';
import 'package:sirbank_rider/provider/auth.dart';
import 'package:sirbank_rider/screen/Dashboard/widget/myActivity.dart';
import 'package:sirbank_rider/utils/shared/appDrawer.dart';
import 'package:sirbank_rider/utils/shared/rounded_raisedbutton.dart';
class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  final String screenName = "HOME";
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  // Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(6.537216, 3.348890), zoom: 16);

  CircleId selectedCircle;

  String currentLocationName;
  String newLocationName;
  // String _placemark = '';
  GoogleMapController mapController;
  bool checkPlatform = Platform.isIOS;
  double distance = 0;
  bool nightMode = false;
  VoidCallback showPersBottomSheetCallBack;
  List<MapTypeModel> sampleData = new List<MapTypeModel>();
  // Map<PolylineId, Polyline> _polyLines = <PolylineId, Polyline>{};
  PolylineId selectedPolyline;
  bool isShowDefault = false;

  List<bool> isSelected;
  bool availableStatus;

  String driverId;
  String token, lastName, firstName, phonepref, avatar;
  var riderRequestData;
  var requestTimeout;
  var requestAccepted;
  var tripcancledByrider;
  String rideTripId;

  _connectSocket() {
    final auth = Provider.of<Auth>(context, listen: false);
    Future.delayed(Duration(seconds: 2), () async {
      // print(
      //     "Connecting Logged In User: ${auth.user.firstName}, ID: ${auth.user.id}");
      Auth.initSocket();
      await Auth.socketUtils.initSocket(auth.token);
      Auth.socketUtils.connectToSocket();
      Auth.socketUtils.setConnectListener(onConnect);
      Auth.socketUtils.setOnConnectionErrorListener(onConnectError);
      Auth.socketUtils.setOnDisconnectListener(onDisconnect);
      // Auth.socketUtils.setOnErrorListener(onError);
      // Provider.of<SocketController>(context, listen: false)
      //     .registerPractitionerListeners();
    });
  }

  onConnect(data) {
    print('********** Connected : ${data.toString()}');
  }

  onConnectError(data) {
    print('*********** onConnectError : ${data.toString()}');
  }

  onConnectTimeout(data) {
    print('********** onConnectTimeout : ${data.toString()}');
  }

  onError(data) {
    print('********* onError : ${data.toString()}');
  }

  onDisconnect(data) {
    Auth.socketUtils.socket.close();
    print('********* onDisconnect : ${data.toString()}');
  }

  @override
  void initState() {
    super.initState();
    _connectSocket();
    isSelected = [true, false];
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
              height: 200,
              child: Column(
                children: [
                  Container(
                      height: 60,
                      color: Color(0xff24414D),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            'Exit?',
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            '',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      )),
                  Container(
                      height: 60,
                      color: Color(0xffF2F2F2),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            'Are you sure you want to exit the App?',
                            style: TextStyle(
                                fontSize: 13,
                                color: Color(0xffFB5448),
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      )),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  return Navigator.of(context).pop(false);
                                },
                                child: Text(
                                  'No',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff24414D),
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                // height: 55,
                                width: 150,
                                child: RoundedRaisedButton(
                                  // circleborderRadius: 10,
                                  title: "Yes",
                                  titleColor: Colors.white,
                                  buttonColor: Color(0xff24414D),
                                  onPress: () {
                                    return Navigator.of(context).pop(true);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )) ??
        false;
  }

  // void _closeModalBottomSheet() {
  //   if (_controller != null) {
  //     _controller.close();
  //     _controller = null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // riderRequest();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: new MenuScreens(activeScreenName: screenName),
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              _buildMapLayer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MyActivity(
                      userImage: null,
                      userName: '$firstName ',
                      level: '',
                      totalEarned: '\0',
                      hoursOnline: 0.0,
                      totalDistance: '',
                      totalJob: 0,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapLayer() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          // _controller.complete(controller);
        },
        // markers: Set.from(markers),
      ),
    );
  }
}
