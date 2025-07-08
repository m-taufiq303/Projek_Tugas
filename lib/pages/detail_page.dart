import 'dart:ffi';

import 'package:flutter/material.dart';
import '../models/book.dart';
import 'read_page.dart';
import 'dart:io';
import '../data/book_data.dart';

class DetailPage extends StatefulWidget {
  final Book book;

  const DetailPage({Key? key, required this.book}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final book = widget.book;
  void _showDeleteDialog() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Hapus Buku'),
      content: Text('Yakin ingin menghapus buku ini?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // batal
          child: Text('Batal'),
        ),
        TextButton(
          onPressed: () {
            // Hapus buku dari list
            bookList.remove(widget.book);
            Navigator.pop(context); // tutup dialog
            Navigator.pop(context); // kembali ke halaman utama
          },
          child: Text('Hapus', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        backgroundColor: Colors.teal,
        actions: [
          // Tombol Bookmark
          IconButton(
            icon: Icon(
              book.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                book.isBookmarked = !book.isBookmarked;
              });
            },
          ),
          SizedBox(width: 4),

          // Menu Titik 3
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            padding: EdgeInsets.zero,
            onSelected: (value) {
              if (value == 'edit') {
                // Tambahkan logika untuk mengedit buku
              } else if (value == 'delete') {
                _showDeleteDialog();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(value: 'delete', child: Text('Hapus')),
            ],
          ),

          SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: book.imagePath.startsWith('assets/')
                    ? Image.asset(book.imagePath, height: 250, fit: BoxFit.cover)
                    : Image.file(File(book.imagePath), height: 250, fit: BoxFit.cover)
,
          ),
          SizedBox(height: 16),
          Text(
            book.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(book.description),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReadPage(book: book),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
            ),
            child: Text('BACA'),
          ),
        ],
      ),
    );
  }
}
