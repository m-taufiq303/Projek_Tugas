import 'package:flutter/material.dart';
import '../models/book.dart';
import 'detail_page.dart';

class BookmarkPage extends StatelessWidget {
  final List<Book> bookmarkedBooks;

  const BookmarkPage({Key? key, required this.bookmarkedBooks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (bookmarkedBooks.isEmpty) {
      return Center(
        child: Text('Belum ada buku yang dibookmark'),
      );
    }

    return ListView.builder(
      itemCount: bookmarkedBooks.length,
      itemBuilder: (context, index) {
        final book = bookmarkedBooks[index];

        return ListTile(
          leading: Image.asset(book.imagePath, width: 50, height: 70, fit: BoxFit.cover),
          title: Text(book.title),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailPage(book: book),
              ),
            );
          },
        );
      },
    );
  }
}

