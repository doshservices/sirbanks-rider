import 'dart:convert';

import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_socket_io/flutter_socket_io.dart';

class SocketUtils {
  static String _serverIP = 'https://sirbanks.herokuapp.com/';
  // static const int SERVER_PORT = 8080;
  String token, id;
  // Event
  static const String UPDATE_LOCATION = 'UPDATE_LOCATION';
  static const String UPDATE_AVAILABILITY = 'UPDATE_AVAILABILITY';
  static const String REJECT_REQUEST = 'REJECT_REQUEST';
  static const String RIDER_LOCATION_UPDATED = 'RIDER_LOCATION_UPDATED';
  static const String RIDE_REQUEST = 'RIDE_REQUEST';
  static const String ACCEPT_REQUEST = 'ACCEPT_REQUEST';
  static const String REQUEST_ACCEPTED = 'REQUEST_ACCEPTED';
  static const String CANCEL_TRIP = 'CANCEL_TRIP';
  static const String TRIP_CANCELED = 'TRIP_CANCELED';
  static const String UPDATE_DESTINATION = 'UPDATE_DESTINATION';
  static const String DESTINATION_UPDATED = 'DESTINATION_UPDATED';
  static const String SUCCESS = 'SUCCESS';
  static const String ERROR = 'ERROR';
  static const String START_TRIP = 'START_TRIP';
  static const String TRIP_ENDED = 'TRIP_ENDED';
  static const String ARRIVING_PICKUP = 'ARRIVING_PICKUP';
  static const String ARRIVED_PICKUP = 'ARRIVED_PICKUP';
  static const String ARRIVING_DESTINATION = 'ARRIVING_DESTINATION';
  static const String ARRIVED_DESTINATION = 'ARRIVED_DESTINATION';
  static const String PRIVATE_MESSAGE = 'PRIVATE_MESSAGE';
  static const String NEW_MESSAGE = 'NEW_MESSAGE';
  static const String TIMEOUT = 'TIMEOUT';

  // init connect
  IO.Socket socket;
  SocketIO socketIO;

  initSocket(String token, String id) async {
    print('Connecting user: ' + token);
    this.token = token;
    this.id = id;
    await _init();
  }

  _init() async {
    print("Token :  " + token.toString());
    // String tokenvalue = 'Bearer $token';
    socketIO = SocketIOManager().createSocketIO(
        'https://sirbanks.herokuapp.com', '/',
        query: 'authorization=Bearer $token',
        socketStatusCallback: _socketConnect);

    socketIO.init();

    // socketIO.subscribe("SUCCESS", _socketConnect);

    // socketIO.subscribe("ERROR", _socketError);

    //  var jsonData = jsonEncode({
    //    "id": "$id",
    //    "pickUpLat": "3.123455",
    //    "pickUpLon": "3.123455",
    //    "dropOffLat": "3.123455",
    //    "dropOffLon": "3.123455"
    //   });
    //  socketIO.sendMessage("GET_TRIP_DETAILS", jsonData, _socketConnect);
  }

  _socketConnect(dynamic data) {
    print("*******Socket status: " + data.toString());
    // return data;
  }

  _socketError(dynamic data) {
    print("Socket status: " + data);
    return data;
  }

  connectToSocket() {
    if (null == socketIO) {
      print("Socket is Null");
      return;
    }
    print("Connecting to socket...");
    socketIO.connect();
    // socket.connect();
  }

  setConnectListener(Function onConnect) {
    onConnect(_socketConnect);
    // socket.onConnect((data) {
    //   onConnect(data);
    // });
  }

  setOnConnectionErrorListener(Function onConnectError) {
    onConnectError(_socketError);
    // socket.onConnectError((data) {
    //   onConnectError(data);
    // });
  }

  // setOnConnectionErrorTimeOutListener(Function onConnectTimeout) {
  //   socket.onConnectTimeout((data) {
  //     onConnectTimeout(data);
  //   });
  // }

  // setOnErrorListener(Function onError) {
  //   socket.on('ERROR', (data) => print(data));
  //   socket.onError((error) {
  //     onError(error);
  //   });
  // }

  setOnDisconnectListener(Function onDisconnect) {
    // socket.onDisconnect((data) {
    //   print("onDisconnect $data");
    //   onDisconnect(data);
    // });
  }

  emitGetTripDetails(String id, pickUpLat, pickUpLon, dropOffLat, dropOffLon) {
    print('sending out new video bc $id');
    if (null == socketIO) {
      print("Socket is Null, Cannot send message");
      return;
    }
    if (socketIO != null) {
      socketIO.connect();
      var jsonData = jsonEncode({
        "id": "$id",
        "pickUpLat": pickUpLat.toString(),
        "pickUpLon": pickUpLon.toString(),
        "dropOffLat": dropOffLat.toString(),
        "dropOffLon": dropOffLon.toString()
      });
      print(jsonData);
      socketIO.sendMessage("GET_TRIP_DETAILS", jsonData, _socketConnect);
      // socketIO.subscribe("SUCCESS", _onReceiveChatMessage);
    }
  }

  emitCancelTrip(Map<String, dynamic> data) {
    print('sending out new video bc $id');
    if (null == socketIO) {
      print("Socket is Null, Cannot send message");
      return;
    }
    if (socketIO != null) {
      socketIO.connect();
      var jsonData = jsonEncode({
        "id": id,
        "role": "rider",
        "tripId": data["tripId"].toString()
      });
      print(jsonData);
      socketIO.sendMessage("CANCEL_TRIP", jsonData, _socketConnect);
      // socketIO.subscribe("SUCCESS", _onReceiveChatMessage);
    }
  }

  emitRequestRide(Map datavalue, Map data) {
    print('sending out new video bc $id');
    print(data);
    if (null == socketIO) {
      print("Socket is Null, Cannot send message");
      return;
    }
    if (socketIO != null) {
      socketIO.connect();
      var jsonData = jsonEncode({
        "id": "$id",
        "pickUp": data['startloc'],
        "pickUpLon": data['pickUpLon'],
        "pickUpLat": data['pickUpLat'],
        "dropOff": data['endloc'],
        "dropOffLon": data['dropOffLon'],
        "dropOffLat": data['dropOffLat'],
        "payment": {"method": "cash", "cardId": "null"}
      });
      print(jsonData);
      socketIO.sendMessage("REQUEST_RIDE", jsonData, _socketConnect);
    }
  }

  // {"tripId":"61790fe2b92a3d001dd685c8","driverId":"6126464b4fa00f001d025c09","pickUp":"3 Idera St, Onipanu 102215, Lagos, Nigeria",
  // "pickUpLon":"3.3611656","pickUpLat":"6.5361457","dropOff":"Oshodi, Lagos, Nigeria","dropOffLon":"3.308677799999998",
  // "dropOffLat":"6.535498","distance":"18.6 km","duration":"46 mins","estimatedFare":{"lowerEstimate":1800,"higherEstimate":1900},
  // "distanceToRider":"92 m","durationToRider":"1 min","driverDetails":{"driverName":"Chris","phone":"+2348141240575",
  // "avatar":"https://res.cloudinary.com/viola/image/upload/v1629898479/drivers/avatars/PB-C855127EA1854DC5B6E1FFA503498AFF.jpg",
  // "lon":"3.3606927","lat":"6.5359265",
  // "vehicleDetails":{"make":"AC","model":"428 Fastback","year":2010,"color":"RED","numberPlate":"JAJD52882"}}}


  _onReceiveChatMessage(dynamic data) {
    print(
        " ****** OnTrip Detail ********* Message from UFO: " + data.toString());
    // onTripDetailSRecieved;
  }

  listenTRIPDETAILS(Function onTripDetailSRecieved) {
    if (socketIO != null) {
      socketIO.subscribe("TRIP_DETAILS", onTripDetailSRecieved);
    }

    // _socket.on(NEW_CARE).listen((data) {
    //   onNewCareRecieved(data);
    // });
  }
  // listenONDriverAvailiable() {
  //   if (socketIO != null) {
  //     socketIO.subscribe("NO_DRIVER_FOUND", _onReceiveChatMessage);
  //   }
  // }

  listenError() {
    if (socketIO != null) {
      socketIO.subscribe("ERROR", _onReceiveChatMessage);
    }
  }

  listenDriverFound(Function onDRIVERFOUND) {
    if (socketIO != null) {
      socketIO.subscribe("DRIVER_FOUND", onDRIVERFOUND);
    }
  }
  listenTripEnded(Function onDRIVERFOUND) {
    if (socketIO != null) {
      socketIO.subscribe("END_TRIP", onDRIVERFOUND);
    }
  }

  listenNoDriverFound(Function onNoDRIVERFOUND) {
    if (socketIO != null) {
      socketIO.subscribe("NO_DRIVER_FOUND", onNoDRIVERFOUND);
    }
  }

  listenCancelTrip(Function onNoDRIVERFOUND) {
    if (socketIO != null) {
      socketIO.subscribe("TRIP_CANCELED", onNoDRIVERFOUND);
    }
  }
}
