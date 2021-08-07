import 'package:flutter/material.dart';

import 'auth.dart';

class SocketController with ChangeNotifier {
  // static SocketUtils socketUtils;
  // List<CareBroadcast> incomingCares = [];
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
    Auth.socketUtils.listenForNewCare(onTripDetailSRecieved);
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

  onTripDetailSRecieved(data) {
    print("new video arrived");
    print(data);
    // incomingCares.add(
    //   CareBroadcast(
    //     patientId: data["patientId"],
    //     initiateCare: data["initiateCare"],
    //     videoUrl: data["videoUrl"],
    //     patientName: data["patientName"],
    //     description: data["description"],
    //     videoTime: data["videoTime"],
    //   ),
    // );
    notifyListeners();
  }
}