import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:sirbank_rider/config.dart' as config;
import 'package:sirbank_rider/provider/auth.dart';
import 'package:sirbank_rider/utils/shared/rounded_raisedbutton.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({ Key key }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String pickUpLat, pickUpLon, dropOffLat, dropOffLon; 
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  // final _key = GlobalKey<GoogleMapStateBase>();

  _showShackBar(errorMessage) {
    final snackBar = new SnackBar(
      content: Text(
        errorMessage.toString(),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red[400],
    );

    _scaffoldkey.currentState.showSnackBar(snackBar);
  } 

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context, listen: true).user;
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Color(0xff24414D),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Icon(Icons.my_location_outlined, color: Colors.white,),
                      SizedBox(
                        width: 30
                      ),
                      Text(
                        'Search address',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Icon(Icons.my_location_outlined, color: Color(0xffFB5448),),
                    SizedBox(width: 10),
                    Container(
                      width: MediaQuery.of(context).size.width - 60,
                      child: SearchMapPlaceWidget(
                        apiKey: config.googleMapKep,
                        onSelected: (place) async {
                          final geolocation = await place.geolocation;
                          print(geolocation.coordinates.toString());
                          var geoCord = geolocation.coordinates.toString().split(',');
                          print(geoCord[0].split("(")[1].toString());
                          print(geoCord[1].split(")")[0].toString());
                          setState(() {
                            pickUpLat = geoCord[0].split("(")[1].toString();
                            pickUpLon = geoCord[1].split(")")[0].toString();
                          });
                          // Longitude = geoCord[1].split(")")[0].toString();
                          // print(Latitude.toString());
                          // print(Longitude.toString());
                          // getNearbylocations();
                          // final bounds = GeoCoord(
                          //   double.parse(Latitude),
                          //   double.parse(Longitude),
                          // );
                          // GoogleMap.of(_key).moveCamera(bounds, animated: true, zoom: 16);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Icon(Icons.location_on_rounded, color: Color(0xff24414D),),
                    SizedBox(width: 10),
                    Container(
                      width: MediaQuery.of(context).size.width - 60,
                      child: SearchMapPlaceWidget(
                        apiKey: config.googleMapKep,
                        onSelected: (place) async {
                          final geolocation = await place.geolocation;
                          print(geolocation.coordinates.toString());
                          var geoCord = geolocation.coordinates.toString().split(',');
                          print(geoCord[0].split("(")[1].toString());
                          print(geoCord[1].split(")")[0].toString());
                          setState(() {
                            dropOffLat = geoCord[0].split("(")[1].toString();
                            dropOffLon = geoCord[1].split(")")[0].toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50
              ),
              Container(
              margin: EdgeInsets.all(30),
              height: 55,
              width: double.infinity,
              child: RoundedRaisedButton(
                title: "Proceed",
                titleColor: Colors.white,
                buttonColor: Color(0xff24414D),
                onPress: () async{
                if(pickUpLat != null && pickUpLon != null && dropOffLat != null && dropOffLon != null){
                  try{
                  setState(() {
                    // _isloading = true;
                  });
                  await Auth.socketUtils.emitGetTripDetails(user.id, pickUpLat, pickUpLon, dropOffLat, dropOffLon);
                  await Auth.socketUtils.listenTRIPDETAILS();
                  await Auth.socketUtils.listenError();
                  setState(() {
                    // _isloading = false;
                  });
                  }catch(e){
                    setState(() {
                      // _isloading = false;
                    });
                    print(e.toString() + "rider");
                  }
                }
                else{
                  _showShackBar("Enter ride Location to continue with ride");
                }
              },
              ),
            ),
            ]
          ),
        ),
      ),
    );
  }
}