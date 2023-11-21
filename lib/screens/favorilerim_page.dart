import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motivapp/constants/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavorilerimPage extends StatefulWidget {
  List<String> favoriSozler;

  FavorilerimPage(this.favoriSozler, {Key? key}) : super(key: key);

  @override
  _FavorilerimPageState createState() => _FavorilerimPageState();
}

class _FavorilerimPageState extends State<FavorilerimPage> {
  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (!_dataLoaded) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        widget.favoriSozler = prefs.getStringList('favoriSozler') ?? [];
        _dataLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(deviceColor),
      appBar: AppBar(
        backgroundColor: HexColor(darkblue),
        title: const Text(
          'Favorilərim',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: widget.favoriSozler.isEmpty
          ? const Center(
              child: Text(
                'Favoriləriniz yoxdur.',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: widget.favoriSozler.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8),
                  color: HexColor('#3498db'),
                  child: ListTile(
                    title: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.favorite, color: Colors.red),
                            IconButton(
                              icon:
                                  const Icon(Icons.delete, color: Colors.white),
                              onPressed: () {
                                _deleteSoz(index);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.favoriSozler[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context); // Geri qayıtmaq üçün
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }

  void _deleteSoz(int index) async {
    setState(() {
      widget.favoriSozler.removeAt(index);
    });

    await _saveData();
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriSozler', widget.favoriSozler);
  }
}
