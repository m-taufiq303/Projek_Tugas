import 'package:flutter/material.dart';
import '../models/book.dart';

class ReadPage extends StatefulWidget {
  final Book book;

  const ReadPage({super.key, required this.book});

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  double fontSize = 16.0;
  bool isDarkMode = false;

  String get sampleText => '''
  Ini adalah isi simulasi dari buku berjudul "${widget.book.title}". 
  Anda bisa membaca konten ini, mengubah ukuran font, dan mengaktifkan mode malam untuk kenyamanan.
  
  Contoh paragraf kedua:
  Flutter adalah framework open-source dari Google untuk membangun aplikasi lintas platform.

  (Konten buku asli dapat disesuaikan dengan kebutuhan.)
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(widget.book.title),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.teal,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.wb_sunny : Icons.dark_mode,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Kontrol Font Size
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove, color: isDarkMode ? Colors.white : Colors.black),
                  onPressed: () {
                    setState(() {
                      if (fontSize > 12) fontSize -= 2;
                    });
                  },
                ),
                Text('Ukuran Font', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
                IconButton(
                  icon: Icon(Icons.add, color: isDarkMode ? Colors.white : Colors.black),
                  onPressed: () {
                    setState(() {
                      if (fontSize < 32) fontSize += 2;
                    });
                  },
                ),
              ],
            ),
          ),

          // Isi Buku
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Text(
                sampleText,
                style: TextStyle(
                  fontSize: fontSize,
                  color: isDarkMode ? Colors.white : Colors.black,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
