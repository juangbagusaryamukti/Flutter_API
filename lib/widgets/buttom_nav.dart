import 'package:flutter/material.dart';
import '../models/user_login.dart';

class BottomNav extends StatefulWidget {
  final int activePage;
  BottomNav(this.activePage, {super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  UserLogin userLogin = UserLogin();
  String? role;

  getDataLogin() async {
    var user = await userLogin.getUserLogin();
    if (user != null && user.status != false) {
      setState(() {
        role = user.role;
      });
    } else {
      Navigator.popAndPushNamed(context, '/login');
    }
  }

  @override
  void initState() {
    super.initState();
    getDataLogin();
  }

  void getLink(index) {
    if (role == "admin") {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/movie');
      }
    } else if (role == "kasir") {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/pesan');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return role == "admin"
        ? BottomNavigationBar(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            currentIndex: widget.activePage,
            onTap: (index) => getLink(index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                label: 'Movie',
              ),
            ],
          )
        : role == "kasir"
            ? BottomNavigationBar(
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                currentIndex: widget.activePage,
                onTap: (index) => getLink(index),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.message),
                    label: 'Pesan',
                  ),
                ],
              )
            : const SizedBox();
  }
}
