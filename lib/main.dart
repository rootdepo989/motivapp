import 'dart:async';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'constants/color.dart';
import 'data/motivasiya_sozleri.dart';
import 'screens/favorilerim_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MotivasiyaApp(),
    );
  }
}

class MotivasiyaApp extends StatefulWidget {
  const MotivasiyaApp({Key? key}) : super(key: key);

  @override
  _MotivasiyaAppState createState() => _MotivasiyaAppState();
}

class _MotivasiyaAppState extends State<MotivasiyaApp> {
  List<String> favoriSozler = [];
  int currentMotivasiyaIndex = 0;
  bool beyenildi = false;
  bool loading = true;
  double loadingOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _prepareMotivasiya();
    _loadData();
  }

  void _prepareMotivasiya() async {
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        loading = false;
        loadingOpacity = 0.0;
      });
    });
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriSozler = prefs.getStringList('favoriSozler') ?? [];
      currentMotivasiyaIndex = prefs.getInt('currentMotivasiyaIndex') ?? 0;
      beyenildi =
          favoriSozler.contains(motivasiyaSozleri[currentMotivasiyaIndex]);
    });
  }

  String currentMotivasiyaSozu() {
    return motivasiyaSozleri[currentMotivasiyaIndex];
  }

  void like() async {
    setState(() {
      beyenildi = !beyenildi;
      if (beyenildi) {
        favoriSozler.add(currentMotivasiyaSozu());
      } else {
        favoriSozler.remove(currentMotivasiyaSozu());
      }
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favoriSozler', favoriSozler);
  }

  void _shareMotivasiyaSozu() {
    final String motivasiyaSozu = currentMotivasiyaSozu();

    Share.share(motivasiyaSozu).then((value) {
      // print('Paylaşmağa nail oldunuz.');
    }).catchError((error) {
      // print('Paylaşmağa nail olunmadı. Xəta: $error');
    });
  }

  void nextSoz() async {
    setState(() {
      currentMotivasiyaIndex++;
      if (currentMotivasiyaIndex >= motivasiyaSozleri.length) {
        currentMotivasiyaIndex = 0;
      }
      beyenildi =
          favoriSozler.contains(motivasiyaSozleri[currentMotivasiyaIndex]);
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentMotivasiyaIndex', currentMotivasiyaIndex);
  }

  void showFavorilerimPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavorilerimPage(favoriSozler),
      ),
    );

    // Favorilər səhifəsindən qayıtdıqdan sonra yeniləmək üçün
    _loadData();
  }

  Widget _buildLoadingScreen() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'MOTİVASİYA',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(3.0, 3.0),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          SpinKitFadingCube(
            color: Colors.white,
            size: 50.0,
          ),
          SizedBox(height: 10),
          Text(
            'Yüklənir...',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(3.0, 3.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(deviceColor),
      appBar: AppBar(
        backgroundColor: HexColor(darkblue),
        title: const Text(
          'Motivasiya',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundImage: AssetImage("lib/images/android.png"),
            ),
            onPressed: () {
              // Profil iconuna tıklandığında icra olunacaq əməliyyatlar
              // print('Profil iconuna tıklandı');
            },
          ),
        ],
      ),
      body: loading
          ? _buildLoadingScreen()
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor(dark),
                    ),
                    child: Text(
                      currentMotivasiyaSozu(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: beyenildi ? Colors.red : Colors.white,
                        ),
                        onPressed: like,
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () {
                          _shareMotivasiyaSozu();
                        },
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: nextSoz,
                    style: ElevatedButton.styleFrom(
                      primary: HexColor(dark),
                    ),
                    child: const Text('Yeni söz',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        color: HexColor(darkblue),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.white),
              onPressed: showFavorilerimPage,
            ),
          ],
        ),
      ),
    );
  }
}
