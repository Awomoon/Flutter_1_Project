import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moon_store/widgets/modals/hive_modal.dart';
import 'package:moon_store/routes/pages/cart.dart';
import 'package:moon_store/routes/pages/home.dart';
import 'package:moon_store/routes/auth/login.dart';
import 'package:moon_store/routes/auth/signup.dart';
import 'package:moon_store/routes/pages/wel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());

  try {
    await Hive.openBox<User>('userBox');
  } catch (e) {
    // print('Hive initialization error: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moon-Store',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/': (context) => const Welcome(),
        '/login': (context) => const Login(),
        '/signup': (context) => const Signup(),
        '/home': (context) => const HomePage(),
        '/cart': (context) => CartScreen(
              cartItems: [], onRemoveItem: (int index) {}, onUpdateQuantity: (int itemId, int quantity) {},
            ),
      },
    );
  }
} 