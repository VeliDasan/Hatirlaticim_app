import 'package:flutter/material.dart';
import 'package:ilacini_unutma/renkler.dart';
import 'package:ilacini_unutma/ui/views/acilis_sayfa.dart';
import 'package:ilacini_unutma/ui/views/anasayfa.dart';
import 'package:ilacini_unutma/ui/views/su_sayfa.dart';

class GirisSayfa extends StatefulWidget {
  const GirisSayfa({super.key});

  @override
  State<GirisSayfa> createState() => _GirisSayfaState();
}

class _GirisSayfaState extends State<GirisSayfa> {
  int _currentIndex = 0; // Başlangıç indeksi 0 olarak değiştirildi
  late final List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _initializeChildren();
  }

  void _initializeChildren() {
    _children = [
      AcilisSayfa(),
      SuSayfa(),
      Anasayfa(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // _currentIndex'in _children listesinin sınırları içinde olduğundan emin olun
    assert(_currentIndex >= 0 && _currentIndex < _children.length);

    return Scaffold(

      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: anaRenk,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 40, color: yaziRenk2),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink, color: yaziRenk2, size: 40),
            label: 'Su Takibi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined, color: yaziRenk2, size: 40),
            label: 'İlaçlarım',
          ),
        ],
        selectedLabelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        selectedItemColor: yaziRenk3,
        unselectedLabelStyle: TextStyle(
          fontSize: 15,
          color: anaRenk,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
