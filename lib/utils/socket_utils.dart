import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_socket_io/flutter_socket_io.dart';

class SocketUtils {
  static String _serverIP = 'https://sirbanks.herokuapp.com/';
  // static const int SERVER_PORT = 8080;
  String token;
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

  initSocket(String token) async {
    print('Connecting user: ' + token);
    this.token = token;
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

    socketIO.subscribe("SUCCESS", _socketConnect);

    socketIO.subscribe("ERROR", _socketError);
  }

  _socketConnect(dynamic data) {
    print("Socket status: " + data);
    return data;
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

  void emitGetTripDetails(
    String id,
  ) {
    print('sending out new video bc $id');
    if (null == socketIO) {
      print("Socket is Null, Cannot send message");
      return;
    }
    if (socketIO != null) {
      print('****** About to connect *******');
      // String jsonData = '{"id": "$id","pickUpLat": "3.123455","pickUpLon": "3.123455","dropOffUpLat": "3.123455","dropOffLon": "3.123455",}';
      // socketIO.sendMessage("TRIP_DETAILS", jsonData, _socketConnect);
    }
  }

  // void _onReceiveChatMessage(dynamic message) {
  //   print("Message from UFO: " + message);
  //   onTripDetailSRecieved(data);
  // }

  listenForNewCare(Function onTripDetailSRecieved) {
    _onReceiveChatMessage(dynamic data) {
      print("Message from UFO: " + data);
      onTripDetailSRecieved(data);
    }

    if (socketIO != null) {
      socketIO.subscribe("TRIP_DETAILS", _onReceiveChatMessage);
    }

    // _socket.on(NEW_CARE).listen((data) {
    //   onNewCareRecieved(data);
    // });
  }
}
