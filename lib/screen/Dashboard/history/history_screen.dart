import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime _selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
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
            // _scaffoldKey.currentState.openDrawer();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
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
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'History',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 82,
              child: DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                deactivatedColor: Colors.black,
                selectionColor: Colors.black,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    _selectedValue = date;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Today',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff24414D),
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      'COMPLETED',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff11E026),
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: Wrap(
                                  spacing: 20,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: [
                                    Wrap(
                                      direction: Axis.vertical,
                                      spacing: 5,
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '10:10',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xffBDBDBD),
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(height: 25),
                                        Text(
                                          '10:10',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xffBDBDBD),
                                              fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      direction: Axis.vertical,
                                      spacing: 5,
                                      children: [
                                        Image.asset(
                                          'assets/icons/nav.png',
                                          height: 25,
                                          width: 25,
                                        ),
                                        SizedBox(height: 20),
                                        Image.asset(
                                          'assets/icons/nav.png',
                                          height: 25,
                                          width: 25,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '7, Conventry way, Ogba \nbus stop',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xffBDBDBD),
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          height: 2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          color: Color(0xff24414D),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'dallington close, epe',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xffBDBDBD),
                                              fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20)
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
