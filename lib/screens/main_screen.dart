import 'package:flutter/material.dart';
import 'package:shop_example/screens/cart_screen.dart';
import 'package:shop_example/screens/home_screen.dart';
import 'package:shop_example/screens/Signup.dart'; // Importez la page de connexion

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 2;
  List<Widget> screens = [
    Scaffold(),
    Scaffold(),
    HomeScreen(),
    CartScreen(),
    Scaffold(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentTab = 2;
          });
        },
        shape: CircleBorder(),
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.home,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        height: 70,
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => setState(() {
                currentTab = 0;
              }),
              icon: Icon(
                Icons.grid_view,
                color: currentTab == 0 ? Colors.orange : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () => setState(() {
                currentTab = 1;
              }),
              icon: Icon(
                Icons.favorite,
                color: currentTab == 1 ? Colors.orange : Colors.grey.shade400,
              ),
            ),
            SizedBox(), // Ajoutez un SizedBox pour compenser l'espace du FloatingActionButton
            IconButton(
              onPressed: () => setState(() {
                currentTab = 3;
              }),
              icon: Icon(
                Icons.shopping_cart,
                color: currentTab == 3 ? Colors.orange : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () {
                // Naviguer vers la page de connexion lorsque le bouton est pressé
                Navigator.push(
                  context,
                    MaterialPageRoute(builder: (context) => CreateAccountForm())
                  // Utilisez LoginScreen au lieu de LoginPage
                );
              },
              icon: Icon(
                Icons.person,
                color: currentTab == 4 ? Colors.orange : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
      body: screens[currentTab],
    );
  }
}

