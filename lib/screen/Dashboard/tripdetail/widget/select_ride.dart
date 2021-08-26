import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirbank_rider/provider/auth.dart';
import 'package:sirbank_rider/provider/socket_controller.dart';
import 'package:sirbank_rider/utils/shared/rounded_raisedbutton.dart';

class SelectRide extends StatefulWidget {
  Map data;
  Map value;
  SelectRide({this.data, this.value, Key key}) : super(key: key);

  @override
  _SelectRideState createState() => _SelectRideState();
}

class _SelectRideState extends State<SelectRide> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
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
                    border: Border.all(color: Color(0xff24414D), width: 1),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/icons/motor.png',
                              width: 60,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "${widget.value['durationToRider'].toString()} / ${widget.value['distanceToRider'].toString()}",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "N${widget.value['estimatedFare']['lowerEstimate'].toString()} - N${widget.value['estimatedFare']['higherEstimate'].toString()}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff24414D), width: 1),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/icons/cash.png', width: 25),
                                SizedBox(width: 5,),
                                Text(
                                  'Cash',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black),
                                )
                              ],
                            ),
                            Text(
                              'Change  method ',
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xff86E44C)),
                            )
                          ],
                        ),
                      )
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.my_location_outlined,
                      //       color: Color(0xffFB5448),
                      //     ),
                      //     SizedBox(width: 10),
                      //     Text(
                      //       widget.data['startloc'].toString(),
                      //       style: TextStyle(
                      //         fontSize: 15,
                      //       ),
                      //       maxLines: 2,
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 20),
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.location_on_rounded,
                      //       color: Color(0xff24414D),
                      //     ),
                      //     SizedBox(width: 10),
                      //     Text(
                      //       widget.data['endloc'].toString(),
                      //       style: TextStyle(fontSize: 15),
                      //       maxLines: 2,
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              height: 55,
              width: double.infinity,
              child: RoundedRaisedButton(
                title: "Select ride",
                titleColor: Colors.white,
                buttonColor: Color(0xff24414D),
                onPress: () async {
                  await Auth.socketUtils.emitRequestRide();
                  // Function onTripDetailSRecieved = Provider.of<SocketController>(context, listen: false).onTripDetailSRecieved;
                  // await Auth.socketUtils
                  //         .listenTRIPDETAILS(onTripDetailSRecieved);
                  //     await Auth.socketUtils.listenError();
                })),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(5),
              //             color: Color(0xff4CE4B1)),
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(
              //               vertical: 10, horizontal: 5),
              //           child: Column(children: [
              //             Image.asset('assets/icons/call.png'),
              //             SizedBox(
              //               height: 10,
              //             ),
              //             Text(
              //               'Call',
              //               style: TextStyle(color: Colors.white),
              //             )
              //           ]),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Expanded(
              //       child: Container(
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(5),
              //             color: Color(0xff4252FF)),
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(
              //               vertical: 10, horizontal: 5),
              //           child: Column(children: [
              //             Image.asset('assets/icons/chart.png'),
              //             SizedBox(
              //               height: 10,
              //             ),
              //             Text(
              //               'Call',
              //               style: TextStyle(color: Colors.white),
              //             )
              //           ]),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Expanded(
              //       child: Container(
              //         // height: 100,
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(5),
              //             color: Color(0xffBEC2CE)),
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(
              //               vertical: 10, horizontal: 5),
              //           child: Column(children: [
              //             Image.asset('assets/icons/cancel.png'),
              //             SizedBox(
              //               height: 10,
              //             ),
              //             Text(
              //               'Call',
              //               style: TextStyle(color: Colors.white),
              //             )
              //           ]),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
