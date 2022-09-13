import 'package:butcherbox/butch_widgets/count.dart';
import 'package:butcherbox/logic/StoreLogic.dart';
import 'package:butcherbox/models/products.dart';
import 'package:butcherbox/screens/account_screen.dart';
import 'package:butcherbox/screens/accountinformation.dart';
import 'package:butcherbox/screens/home.dart';
import 'package:butcherbox/screens/landing_page.dart';
import 'package:butcherbox/screens/locations.dart';
import 'package:butcherbox/screens/orders.dart';
import 'package:butcherbox/screens/orders2.dart';
import 'package:butcherbox/screens/sign_in_page.dart';
import 'package:butcherbox/screens/signing_in.dart';
import 'package:butcherbox/screens/store_screen.dart';
import 'package:butcherbox/screens/thecart.dart';
import 'package:butcherbox/screens/theshop.dart';
import 'package:butcherbox/services/auth.dart';
import 'package:butcherbox/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*void main() {
  runApp(MainApp());
}*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final auth = Provider.of<AuthBase>(context, listen: false);
    List<Products> _cart = [];
    int sum;
    final auth = Auth();
    User user = auth.currentUser;

    return MultiProvider(
      providers: [
        Provider<AuthBase>(create: (context) => Auth()),
        Provider<Database>(create: (_) => FireStoreDatabase(uid: user.uid)),
        ChangeNotifierProvider<Count>(create: (context) => Count()),
        ChangeNotifierProvider<StoreLogic>(
            create: (_) => StoreLogic(), child: TheShop()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Butcher Box',
        initialRoute: '/',
        routes: {
          '/sign': (context) => SignInPage(),
          '/': (context) => LandingPage(),
          '/store': (context) => StoreScreen(),
          '/cart': (context) => Cart(_cart, sum),
          '/account': (context) => AccountScreen(),
          '/orders': (context) => Orders(),
          '/orders2': (context) => Orders2(),
          '/accountinfo': (context) => AccountInfo(),
          '/locations': (context) => Locations(),
        },
        /*home: SignInPage(
              //  auth: Auth(),
              ),*/
      ),
    );
  }
}
