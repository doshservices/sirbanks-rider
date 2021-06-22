import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sirbank_rider/utils/shared/rounded_raisedbutton.dart';

class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Color(0xff24414D),
                  borderRadius: BorderRadius.circular(10)),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Reviews',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '  - see your riders ',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'feedback ',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xffFB5448),
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/map.png',
                      ),
                      fit: BoxFit.fill)),
              child: Container(
                height: 120,
                width: 120,
                child: Center(
                  child: Image.asset(
                    'assets/images/per3.png',
                    fit: BoxFit.fill,
                    height: 120,
                  ),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Text(
            'Driver  : Balogun Sam',
            style: TextStyle(
                fontSize: 16,
                color: Color(0xff24414D),
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Reg No.  : #23345',
            style: TextStyle(
                fontSize: 16,
                color: Color(0xff24414D),
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Vehicle No.  : Toyota TxLmn-346',
            style: TextStyle(
                fontSize: 16,
                color: Color(0xff24414D),
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Center(
            child: RatingBar.builder(
              initialRating: 3.0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 4,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemSize: 25,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Color(0xffFB5448),
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ),
          SizedBox(
            height: 10,
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
                  children: [
                    Image.asset(
                      'assets/icons/nav.png',
                      height: 25,
                      width: 25,
                    ),
                    SizedBox(height: 10),
                    Image.asset(
                      'assets/icons/nav.png',
                      height: 25,
                      width: 25,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '7, Conventry way, Ogba bus stop',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffBDBDBD),
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width * 0.6,
                      color: Color(0xff24414D),
                    ),
                    SizedBox(height: 15),
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
          ),
          Text(
            'your feedback will help improve driving ex perience',
            style: TextStyle(
                fontSize: 15,
                color: Color(0xffBDBDBD),
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 2, color: Colors.black)),
            ),
          ),
          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.all(10),
            height: 55,
            width: double.infinity,
            child: RoundedRaisedButton(
              // circleborderRadius: 10,
              title: "Submit review",
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
