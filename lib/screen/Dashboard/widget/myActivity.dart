import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirbank_rider/provider/auth.dart';
import 'package:sirbank_rider/utils/shared/rounded_raisedbutton.dart';
// import '../../theme/style.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class MyActivity extends StatelessWidget {
  final String userImage;
  final String userName;
  final String level;
  final String totalEarned;
  final double hoursOnline;
  final String totalDistance;
  final int totalJob;

  const MyActivity({
    Key key,
    this.userImage,
    this.userName,
    this.level,
    this.totalEarned,
    this.hoursOnline,
    this.totalDistance,
    this.totalJob,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<Auth>(context, listen: true).user;
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
      height: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        color: Colors.white.withOpacity(0.8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Icon(Icons.person)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Visa Card",
                          style: TextStyle(
                              color: Color(0xffC8C8C8),
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          " ",
                          style: TextStyle(
                              color: Color(0xffFB5448),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "N43,000",
                          style: TextStyle(
                              color: Color(0xff24414D),
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '2.2KM',
                          style: TextStyle(
                              color: Color(0xffFC8C8C8),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 1,
              color: Color(0xff24414D)),
          Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(10.0),
              //   color: Color(0xff24414D),
              // ),
              child: ListTile(
                leading: Image.asset(
                  'assets/icons/nav.png',
                  height: 30,
                ),
                title: Text('7, Conventry way, Ogba\n bus stop'),
                trailing: Text('        '),
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 1,
              color: Color(0xff24414D)),
          SizedBox(
            height: 10
          ),
          Container(
            margin: EdgeInsets.all(10),
            height: 55,
            width: double.infinity,
            child: RoundedRaisedButton(
              // circleborderRadius: 10,
              title: "Book ride",
              titleColor: Colors.white,
              buttonColor: Color(0xff24414D),
              onPress: () {
                // Navigator.of(context).pushNamed(kLoginScreen);
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //     kDashbord, (route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
