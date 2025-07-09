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
  
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam orci tellus, venenatis eu risus nec, cursus tincidunt nibh.
  ''';

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
        ),
        title: Text(
          book.title,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
          ),
        ),
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
