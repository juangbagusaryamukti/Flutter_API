import 'package:flutter/material.dart';
import '../widgets/buttom_nav.dart';

class PesanView extends StatefulWidget {
  const PesanView({super.key});

  @override
  State<PesanView> createState() => _PesanViewState();
}

class _PesanViewState extends State<PesanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesan"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(child: Text("Pesan")),
      bottomNavigationBar: BottomNav(1),
    );
  }
}
