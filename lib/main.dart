import 'package:flutter/material.dart';
import 'data/book_data.dart';
import 'models/book.dart';
import 'pages/detail_page.dart';
import 'pages/bookmark_page.dart';
import 'pages/add_book_page.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan Digital',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu_book_rounded, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text(
              'Perpustakaan Digital',
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                textStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: Text('MASUK'),
            ),
          ],
        ),
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final bookmarked = bookList.where((book) => book.isBookmarked).toList();

    final pages = [
      buildGridView(), // halaman koleksi
      BookmarkPage(bookmarkedBooks: bookmarked), // halaman bookmark
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(currentIndex == 0 ? 'Koleksi Buku' : 'Bookmark'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          if (currentIndex == 0) buildSearchBar(),
          Expanded(child: pages[currentIndex]),
        ],
      ),
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            searchQuery = '';
            searchController.clear();
          });
        },
        selectedItemColor: Colors.teal,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Koleksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
        ],
      ),
      floatingActionButton: currentIndex == 0
             ? FloatingActionButton(
                backgroundColor: Colors.teal,
                child: Icon(Icons.add),
                onPressed: () async {
                  final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddBookPage()),
                );

                if (result == true) {
                  print('snackbar tampil');
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Buku berhasil ditambahkan'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
             )
            : null,
    );
  }

 Widget buildGridView() {
  final filteredBooks = bookList.where((book) {
    final titleLower = book.title.toLowerCase();
    return titleLower.contains(searchQuery);
  }).toList();

  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: GridView.builder(
      itemCount: filteredBooks.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final book = filteredBooks[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailPage(book: book),
              ),
            ).then((_) {
              setState(() {});
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    child: book.imagePath.startsWith('assets/')
                        ? Image.asset(
                            book.imagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          )
                        : Image.file(
                            File(book.imagePath),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    book.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget buildSearchBar() {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: 'Cari judul buku...',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onChanged: (value) {
        setState(() {
          searchQuery = value.toLowerCase();
        });
      },
    ),
  );
}


}