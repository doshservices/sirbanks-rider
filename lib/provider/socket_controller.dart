import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sirbank_rider/model/driverFound.dart';
import 'package:sirbank_rider/model/getTrip_detail.dart';
import 'package:sirbank_rider/utils/shared/rounded_raisedbutton.dart';
import 'package:sirbank_rider/utils/socket_utils.dart';

class SocketController with ChangeNotifier {
  static SocketUtils socketUtils;
  GetTripDetailModel getTripDetailModel;
  List<DriverLocModel> driverlocModel = [];
  DriverFoundModel driverfoundModel;
  Map<String, dynamic> getTrip;
  Map<String, dynamic> driverFound;
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
    if (data != null) {
      GetTripDetailModel getTripDetail = GetTripDetailModel();
      getTripDetail.duration = data['duration'];
      getTripDetail.distance = data['distance'];
      getTripDetail.lowerEstimate = data['estimatedFare']['lowerEstimate'];
      getTripDetail.higherEstimate = data['estimatedFare']['higherEstimate'];
      if (data["drivers"] != null) {
        List<dynamic> entities = data["drivers"];
        entities.forEach((entity) {
          DriverLocModel driverLoc = DriverLocModel();
          driverLoc.lat = entity['lat'];
          driverLoc.long = entity['lon'];

          driverlocModel.add(driverLoc);
        });

        getTripDetail.driverLocation = driverlocModel;
      } else {
        getTripDetail.driverLocation = driverlocModel;
      }
      getTripDetailModel = getTripDetail;
    }

    notifyListeners();
  }

  onDRIVERFOUND(String datavalue) {
    print(datavalue);
    print("Drive Found+++++++++++  " + datavalue.toString());
    var data = jsonDecode(datavalue);
    print("+++++++++++");
    if (data != null) {
      driverFound = data;
      //   GetTripDetailModel getTripDetail = GetTripDetailModel();
      // getTripDetail.duration = data['duration'];
      // getTripDetail.distance = data['distance'];
      // getTripDetail.lowerEstimate = data['estimatedFare']['lowerEstimate'];
      // getTripDetail.higherEstimate = data['estimatedFare']['higherEstimate'];
      // if(data["drivers"]!=null){
      //   List<dynamic> entities = data["drivers"];
      //  entities.forEach((entity) {
      //    DriverLocModel driverLoc = DriverLocModel();
      //    driverLoc.lat = entity['lat'];
      //    driverLoc.long = entity['lon'];

      //    driverlocModel.add(driverLoc);
      //  });

      //   getTripDetail.driverLocation = driverlocModel;
      // }else{
      //   getTripDetail.driverLocation = driverlocModel;
      // }
      // getTripDetailModel = getTripDetail;
    }

    notifyListeners();
  }

  onTripEnded(String datavalue) {
    print(datavalue);
    print("Drive Found+++++++++++  " + datavalue.toString());
    var data = jsonDecode(datavalue);
    print("+++++++++++");
    if (data != null) {
      driverFound = data;
      Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(fontSize: 1),
        content: Container(
          height: 260,
          child: Column(
            children: [
              Container(
                  height: 50,
                  color: Color(0xff24414D),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        'Trip Ended',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )),
              Expanded(
                child: Container(
                    color: Color(0xffF2F2F2),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Destination',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xffBDBDBD),
                                  fontWeight: FontWeight.w600),
                              // textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              getTrip['pickUp'].toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff24414D),
                                  fontWeight: FontWeight.w600),
                              // textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Trip Duration : ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff24414D),
                                  fontWeight: FontWeight.w600),
                              // textAlign: TextAlign.left,
                            ),
                            Text(
                              data['tripDuration'].toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff24414D),
                                  fontWeight: FontWeight.w600),
                              // textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Trip Cost : ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff24414D),
                                  fontWeight: FontWeight.w600),
                              // textAlign: TextAlign.left,
                            ),
                            Text(
                              data['total'].toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff24414D),
                                  fontWeight: FontWeight.w600),
                              // textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            child: RoundedRaisedButton(
                              // circleborderRadius: 10,
                              title: "Confirm",
                              titleColor: Colors.white,
                              buttonColor: Color(0xff24414D),
                              onPress: () async {
                                // getTrip = data;
                                Get.back();
                                Get.back();
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
      );
    }

    notifyListeners();
  }

  onNoDRIVERFOUND(String datavalue) {
    print(datavalue);
    print("+++++++++++" + datavalue.toString());
    // var data = jsonDecode(datavalue);
    print("+++++++++++");
    if (datavalue != null) {
      Get.snackbar('Drivers Not Found', datavalue.toString(),
          barBlur: 0,
          dismissDirection: SnackDismissDirection.VERTICAL,
          backgroundColor: Colors.green,
          overlayBlur: 0,
          animationDuration: Duration(seconds: 3),
          duration: Duration(seconds: 6));
    }
    notifyListeners();
  }

  onTripCancelled(String datavalue) {
    print(datavalue);
    print("+++++++++++" + datavalue.toString());
    // var data = jsonDecode(datavalue);
    print("+++++++++++");
    if (datavalue != null) {
      Get.snackbar('Trip Cancel', datavalue.toString(),
          barBlur: 0,
          dismissDirection: SnackDismissDirection.VERTICAL,
          backgroundColor: Colors.green,
          overlayBlur: 0,
          animationDuration: Duration(seconds: 3),
          duration: Duration(seconds: 6));
      Get.back();
      Get.back();
    }
    notifyListeners();
  }
}

// {
// ""tripId"": ""new trip id"",
// ""driverId"": ""driver id"",
// ""pickUp"": ""12b MacDonald Omole Phase"",
// ""pickUpLon"": ""11.222"",
// ""pickUpLat"": ""33.666"",
// ""dropOff"": ""HubMart Berga road"",
// ""dropOffLon"": ""22.455"",
// ""dropOffLat"": ""32.455"",
// ""distance"": ""36 km"",
// ""duration"": ""2 hours 27 mins""'
// ""estimatedFare"": {
//      lowerEstimate,
//      higherEstimate
//  },
// ""distanceToRider"": ""21 km"",
// ""durationToRider"": ""22 mins"",
// ""payment"": {
//      ""method"": ""card/cash/wallet"",
//       ""cardId"": ""efe33434dd11/null""
//     }
// ""driverDetails"": {
//     ""driverName"": ""drivers name"",
//     ""avatar"": ""driverprofile pic"",
//     ""phone"": ""0809988009"",
//     ""lon"": ""driver_longitude"",
//     ""lat"": ""driver_latitude""
//     ""vehicleDetails"": {
//           ""make"": ""toyota"",
//           ""model"": ""corolla"",
//           ""year"": ""2015"",
//           ""color"": ""blue"",
//           ""numberPlate"": ""aa-234-fst""
//      }
//   }
// }