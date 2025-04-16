import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:moon_store/routes/pages/cart.dart';
import 'package:moon_store/routes/screens/store.dart';
import 'package:moon_store/widgets/modals/hive_modal.dart';
import 'package:moon_store/routes/screens/categories.dart';
import 'package:moon_store/routes/screens/profile.dart';
import 'package:moon_store/routes/screens/search.dart';
import 'package:moon_store/widgets/modals/products_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;
  final Box<User> userBox = Hive.box<User>('userBox');
  List<ProductModel> cartItems = [];
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _initializePages();
  }

  void _initializePages() {
    _pages = [
      CartScreen(
        cartItems: cartItems,
        onRemoveItem: removeFromCart,
        onUpdateQuantity: updateQuantity,
      ),
      SearchScreen(),
      HomeScreen(
        cartItems: cartItems,
        addToCart: addToCart,
      ),
      CategoriesScreen(),
      ProfileScreen(),
    ];
  }

  void addToCart(ProductModel product) {
    setState(() {
      final existingIndex =
          cartItems.indexWhere((item) => item.id == product.id);
      if (existingIndex >= 0) {
        cartItems[existingIndex].quantity =
            (cartItems[existingIndex].quantity) + 1;
      } else {
        cartItems.add(product.copyWith(quantity: 1));
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} added to cart!'),
        duration: const Duration(seconds: 2),
        backgroundColor: Color.fromRGBO(123, 97, 255, 1),
      ),
    );
  }

  void removeFromCart(dynamic productId) {
    setState(() {
      cartItems.removeWhere((item) => item.id == productId);
    });
  }

  void updateQuantity(int index, int newQuantity) {
    setState(() {
      cartItems[index].quantity = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = userBox.get('user');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appBarTitles[_selectedIndex],
          style: GoogleFonts.lexend(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(123, 97, 255, 1),
        primary: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(123, 97, 255, 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/avater.jpg'),
                    radius: 30.0,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user != null ? 'Welcome ${user.username}' : 'Welcome Guest',
                    style: GoogleFonts.lexend(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.profile_circled,
                  color: Colors.white),
              title: Text('Profile Details.',
                  style: GoogleFonts.lexend(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 4;
                });
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.cart, color: Colors.white),
              title:
                  Text('Cart', style: GoogleFonts.lexend(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(CupertinoIcons.square_arrow_right,
                  color: Colors.white),
              title: Text('Logout',
                  style: GoogleFonts.lexend(color: Colors.white)),
              onTap: () => _showLogoutDialog(context),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        color: const Color.fromRGBO(123, 97, 255, 1),
        buttonBackgroundColor: const Color.fromRGBO(123, 97, 255, 1),
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 600),
        index: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <Widget>[
          Icon(CupertinoIcons.cart, size: 30, color: Colors.white),
          Icon(CupertinoIcons.search, size: 30, color: Colors.white),
          Icon(CupertinoIcons.home, size: 30, color: Colors.white),
          Icon(CupertinoIcons.bag, size: 30, color: Colors.white),
          Icon(CupertinoIcons.profile_circled, size: 30, color: Colors.white),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.warning, color: Colors.amber),
                  const SizedBox(width: 10),
                  Text('Confirm Logout',
                      style: GoogleFonts.lexend(fontSize: 18)),
                ],
              ),
            ],
          ),
          content: const Text('Are you sure you want to Logout?'),
          contentTextStyle:
              GoogleFonts.lexend(fontSize: 20, color: Colors.black),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          icon: const Icon(Icons.question_answer),
          actions: [
            TextButton(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red)),
              onPressed: () {
                userBox.clear();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text(
                'Yes',
                style: GoogleFonts.lexend(color: Colors.white),
              ),
            ),
            TextButton(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: GoogleFonts.lexend(color: Colors.white),
              ),
            ),
          ],
          elevation: 20,
        );
      },
    );
  }

  final List<String> _appBarTitles = [
    'Cart',
    'Search',
    'Home',
    'Categories',
    'Profile',
  ];
}
