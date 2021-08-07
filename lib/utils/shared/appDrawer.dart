import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirbank_rider/provider/auth.dart';

import '../../constants.dart';

class MenuItems {
  String name;
  IconData icon;
  MenuItems({
    this.icon,
    this.name,
  });
}

class MenuScreens extends StatefulWidget {
  final String activeScreenName;
  // final String userImage;

  MenuScreens({
    this.activeScreenName,
  });

  @override
  _MenuScreensState createState() => _MenuScreensState();
}

class _MenuScreensState extends State<MenuScreens> {
  navigatorRemoveUntil(BuildContext context, String router) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/$router', (Route<dynamic> route) => false);
  }

  String firstname, phone, lastname, avatar;
  String token, userId;

  // @override
  // void initState() {
  //   if (mounted) {
  //     _userName();
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final user = Provider.of<Auth>(context, listen: true).user;
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 0.0),
            color: Color(0xff24414D),
            height: 140,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(50.0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: new ClipRRect(
                                borderRadius: new BorderRadius.circular(100.0),
                                child: new Container(
                                    height: 50.0,
                                    width: 50.0,
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Color(0xff24414D),
                                    ))),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                user.firstName + "  " + user.lastName,
                                // 'Balogun Rasheed',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 5),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 4.0,
                                    right: 4.0,
                                    top: 2.0,
                                    bottom: 2.0),
                                decoration: BoxDecoration(
                                  // color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  "Edit Info",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffFB5448),
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          new MediaQuery.removePadding(
            context: context,
            // DrawerHeader consumes top MediaQuery padding.
            removeTop: true,
            child: new Expanded(
              child: new ListView(
                //padding: const EdgeInsets.only(top: 8.0),
                children: <Widget>[
                  new Stack(
                    children: <Widget>[
                      // The initial contents of the drawer.
                      new Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              navigatorRemoveUntil(context, 'home');
                            },
                            child: new Container(
                              height: 60.0,
                              // color: ,
                              child: new Row(
                                children: <Widget>[
                                  new Expanded(
                                    flex: 1,
                                    child: Image.asset(
                                        'assets/icons/Vectorhome.png'),
                                  ),
                                  new Expanded(
                                    flex: 3,
                                    child: new Text(
                                      'Home',
                                      style: TextStyle(
                                          fontSize: 16,
                                          // color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // new GestureDetector(
                          //   onTap: () {
                          //     Navigator.pop(context);
                          //     // Navigator.of(context).pushNamed(KReviewScreen);
                          //   },
                          //   child: new Container(
                          //     height: 60.0,
                          //     child: new Row(
                          //       children: <Widget>[
                          //         new Expanded(
                          //           flex: 1,
                          //           child: Image.asset(
                          //               'assets/icons/Vectorrequest.png'),
                          //         ),
                          //         new Expanded(
                          //           flex: 3,
                          //           child: new Text(
                          //             'Request',
                          //             style: TextStyle(
                          //                 fontSize: 16,
                          //                 // color: Colors.white,
                          //                 fontWeight: FontWeight.w400),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).pushNamed(KWalletScreen);
                            },
                            child: new Container(
                              height: 60.0,
                              // color: Color(0xffBDBDBD),
                              child: new Row(
                                children: <Widget>[
                                  new Expanded(
                                    flex: 1,
                                    child: Icon(
                                      Icons.account_balance_wallet,
                                      size: 25,
                                      color: Color(0xffBDBDBD),
                                    ),
                                  ),
                                  new Expanded(
                                    flex: 3,
                                    child: new Text(
                                      'My Wallet',
                                      style: TextStyle(
                                          fontSize: 16,
                                          // color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).pushNamed(KHistoryScreen);
                            },
                            child: new Container(
                              height: 60.0,
                              // color: Color(0xffBDBDBD),
                              child: new Row(
                                children: <Widget>[
                                  new Expanded(
                                    flex: 1,
                                    child:
                                        Image.asset('assets/icons/clock.png'),
                                  ),
                                  new Expanded(
                                    flex: 3,
                                    child: new Text(
                                      'History',
                                      style: TextStyle(
                                          fontSize: 16,
                                          // color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context)
                                  .pushNamed(KNotificationScreen);
                            },
                            child: new Container(
                              height: 60.0,
                              // color: Color(0xffBDBDBD),
                              child: new Row(
                                children: <Widget>[
                                  new Expanded(
                                    flex: 1,
                                    child: Image.asset('assets/icons/noti.png'),
                                  ),
                                  new Expanded(
                                    flex: 3,
                                    child: new Text(
                                      'Notifications',
                                      style: TextStyle(
                                          fontSize: 16,
                                          // color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context)
                                  .pushNamed(KInviteFriendScreen);
                            },
                            child: new Container(
                              height: 60.0,
                              // color: Color(0xffBDBDBD),
                              child: new Row(
                                children: <Widget>[
                                  new Expanded(
                                    flex: 1,
                                    child: Image.asset(
                                        'assets/icons/Vectorinvite.png'),
                                  ),
                                  new Expanded(
                                    flex: 3,
                                    child: new Text(
                                      'Invite friends',
                                      style: TextStyle(
                                          fontSize: 16,
                                          // color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).pushNamed(KSettingScreen);
                            },
                            child: new Container(
                              height: 60.0,
                              // color: Color(0xffBDBDBD),
                              child: new Row(
                                children: <Widget>[
                                  new Expanded(
                                    flex: 1,
                                    child: Image.asset(
                                        'assets/icons/rsettings.png'),
                                  ),
                                  new Expanded(
                                    flex: 3,
                                    child: new Text(
                                      'Settings',
                                      style: TextStyle(
                                          fontSize: 16,
                                          // color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              auth.logout();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  kLoginScreen, (route) => false);
                            },
                            child: new Container(
                              height: 60.0,
                              // color: whiteColor,
                              child: new Row(
                                children: <Widget>[
                                  new Expanded(
                                    flex: 1,
                                    child:
                                        Image.asset('assets/icons/logout.png'),
                                  ),
                                  new Expanded(
                                    flex: 3,
                                    child: new Text(
                                      'Logout',
                                      style: TextStyle(
                                          fontSize: 16,
                                          // color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // The drawer's "details" view.
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
