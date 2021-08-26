import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sirbank_rider/model/getTrip_detail.dart';
import 'package:sirbank_rider/utils/socket_utils.dart';

class SocketController with ChangeNotifier {
  static SocketUtils socketUtils;
  GetTripDetailModel getTripDetailModel;
  List<DriverLocModel> driverlocModel = [];
  Map<String, dynamic> getTrip;
  // IncomingCall incomingCall;
  int onlinePractitionerscount = 0;
  dynamic currentPatientOnCallSocket;

  // void endIncomingCall() {
  //   incomingCall = null;
  //   notifyListeners();
  // }
  // static initSocket() {
  //   if (null == socketUtils) {
  //     socketUtils = SocketUtils();
  //   }
  // }

  void setCurrentPatientOnCallSocket(dynamic socket) {
    currentPatientOnCallSocket = socket;
    notifyListeners();
  }

  registerPractitionerListeners() {
    // Auth.socketUtils.listenForNewCare(onTripDetailSRecieved);
  }

  // registerPatientListeners() {
  //   Auth.socketUtils.listenForIncomingCall(onIncomingCallRecieved);
  //   Auth.socketUtils.listenForOnlinePractitioners(onOnlinePractitionersRecieved);
  // }

  // onIncomingCallRecieved(data) {
  //   print("new incoming call");
  //   debugPrint(data.toString(), wrapWidth: 1025);
  //   incomingCall = IncomingCall(
  //     roomId: data["roomId"],
  //     token: data["token"],
  //     practitionerName: data["practitionerName"],
  //     socket: data["socket"],
  //   );
  //   notifyListeners();
  // }

  // onOnlinePractitionersRecieved(data) {
  //   print("updated practitioner list");
  //   onlinePractitionerscount = data.length;
  //   print(data.length);

  //   debugPrint(data.toString(), wrapWidth: 1025);

  //   notifyListeners();
  // }

  onTripDetailSRecieved(String datavalue) {
    print("new video arrived");
    print(datavalue);
    // print("+++++++++++"+ datavalue['duration'].toString());
    var data = jsonDecode(datavalue);
    print("+++++++++++");
    getTrip = data;
    if(data!=null){
      GetTripDetailModel getTripDetail = GetTripDetailModel();
    getTripDetail.duration = data['duration'];
    getTripDetail.distance = data['distance'];
    getTripDetail.lowerEstimate = data['estimatedFare']['lowerEstimate'];
    getTripDetail.higherEstimate = data['estimatedFare']['higherEstimate'];
    if(data["drivers"]!=null){
      List<dynamic> entities = data["drivers"];
     entities.forEach((entity) {
       DriverLocModel driverLoc = DriverLocModel();
       driverLoc.lat = entity['lat'];
       driverLoc.long = entity['lon'];

       driverlocModel.add(driverLoc);
     });

      getTripDetail.driverLocation = driverlocModel;
    }else{
      getTripDetail.driverLocation = driverlocModel;
    }

    getTripDetailModel = getTripDetail;
    
    }
    // {"duration":"1 hour 9 mins","distance":"17.3 km",
    //   "estimatedFare":{"lowerEstimate":1900,"higherEstimate":2100},
    //   "durationToRider":"2 hours 1 min","distanceToRider":"32.9 km",
    //   "drivers":[{"lon":3.251979,"lat":6.6903758}]}
    
    notifyListeners();
  }
}