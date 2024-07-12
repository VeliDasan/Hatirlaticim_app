import 'package:flutter/material.dart';
import 'package:ilacini_unutma/renkler.dart';

class AcilisSayfa extends StatefulWidget {
  const AcilisSayfa({Key? key}) : super(key: key);

  @override
  State<AcilisSayfa> createState() => _AcilisSayfaState();
}

class _AcilisSayfaState extends State<AcilisSayfa> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: anaRenk,
        centerTitle: true,
        title: Text(
          "Hatırlatıcı",
          style: TextStyle(fontSize: 40, fontFamily: "Bold", color: yaziRenk3),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.menu, // Hamburger icon
            color: Colors.white, // Icon rengini buradan değiştirin
          ),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: anaRenk, // İstediğiniz arka plan rengini burada belirleyin
              ),
              child: Text('Drawer Header'),
            ),
            const ListTile(
              leading: Icon(Icons.home, color: Colors.blue), // Örnek icon renk ayarı
              title: Text('Anasayfa', style: TextStyle(color: Colors.black)),
            ),
            const ListTile(
              leading: Icon(Icons.settings, color: Colors.blue), // Örnek icon renk ayarı
              title: Text('Ayarlar', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
