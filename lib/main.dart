import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sirbank_rider/provider/auth.dart';
import 'package:sirbank_rider/provider/socket_controller.dart';
import 'package:sirbank_rider/screen/Dashboard/contactus/contact_us.dart';
import 'package:sirbank_rider/screen/Dashboard/dashboard.dart';
import 'package:sirbank_rider/screen/Dashboard/history/history_screen.dart';
import 'package:sirbank_rider/screen/Dashboard/invite/invite_friend.dart';
import 'package:sirbank_rider/screen/Dashboard/language/language_screen.dart';
import 'package:sirbank_rider/screen/Dashboard/notification/notification.dart';
import 'package:sirbank_rider/screen/Dashboard/profile/profile_screen.dart';
import 'package:sirbank_rider/screen/Dashboard/review/review_screen.dart';
import 'package:sirbank_rider/screen/Dashboard/search/search_screen.dart';
import 'package:sirbank_rider/screen/Dashboard/settings/settings.dart';
import 'package:sirbank_rider/screen/Dashboard/termandcondiction/termandcondiction.dart';
import 'package:sirbank_rider/screen/Dashboard/tripdetail/trip_details.dart';
import 'package:sirbank_rider/screen/Dashboard/wallet/addcard_payment.dart';
import 'package:sirbank_rider/screen/Dashboard/wallet/card_payment_screen.dart';
import 'package:sirbank_rider/screen/Dashboard/wallet/payment_method.dart';
import 'package:sirbank_rider/screen/Dashboard/wallet/wallet_screen.dart';
import 'package:sirbank_rider/screen/authentication.dart/login.dart';
import 'package:sirbank_rider/screen/authentication.dart/otp_screen.dart';
import 'package:sirbank_rider/screen/authentication.dart/signup.dart';
import 'package:sirbank_rider/screen/walkthrough/walkthough.dart';
import 'package:sirbank_rider/splashscreen.dart';

import 'constants.dart';
import 'screen/authentication.dart/enable_location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) {
            return Auth();
          },
        ),
        ChangeNotifierProvider(
          create: (ctx) {
            return SocketController();
          },
        ),
      ],
      child: Consumer<Auth>(builder: (ctx, auth, _) {
            print(auth.isAuth);
            return 
      GetMaterialApp(
          title: 'Sirbanks Driver',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          debugShowCheckedModeBanner: false,
                home: 
                auth.isAuth == true
                    ? DashboardScreen()
                    : FutureBuilder(
                        future: auth.tryAutoLogin(),
                        builder: (ctx, authResultSnapShot) =>
                            authResultSnapShot.connectionState ==
                                    ConnectionState.waiting
                                ? SplashScreen()
                                : WalkThrough()),
          routes: {
            kSplashscreen: (ctx) => SplashScreen(),
            kWalkthrough: (ctx) => WalkThrough(),
            KEnableLocationScreen: (ctx) => EnableLocationScreen(),
            kSignupScreen: (ctx) => SignupScreen(),
            kLoginScreen: (ctx) => LoginScreen(),
            kDashboard: (ctx) => DashboardScreen(),
            KWalletScreen: (ctx) => WalletScreen(),
            KHistoryScreen: (ctx) => HistoryScreen(),
            KNotificationScreen: (ctx) => NotificationScreen(),
            KSettingScreen: (ctx) => SettingScreen(),
            KProfileScreen: (ctx) => ProfileScreen(),
            KReviewScreen: (ctx) => ReviewScreen(),
            KLanguageScreen: (ctx) => LanguageScreen(),
            KTermandCondition: (ctx) => TermandCondition(),
            KContactUs: (ctx) => ContactUs(),
            KInviteFriendScreen: (ctx) => InviteFriendScreen(),
            KOtpScreen: (ctx) => OtpScreen(),
            KPaymentMethod : (ctx) => PaymentMethod(),
            KCardPayment : (ctx) => CardPayment(),
            KAddCardPayment : (ctx) => AddCardPayment(),
            KSearchScreen : (ctx) => SearchScreen(),
            KTripDetails : (ctx) => TripDetails(),
          });})
    );
  }
}
