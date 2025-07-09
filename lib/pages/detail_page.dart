import 'dart:io';

import 'package:flutter/material.dart';
import '../models/book.dart';
import 'read_page.dart';
import '../data/book_data.dart';
import 'edit_book_page.dart';


class DetailPage extends StatefulWidget {
  final Book book;

  const DetailPage({Key? key, required this.book}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Buku'),
        content: Text('Yakin ingin menghapus buku ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              bookList.remove(widget.book);
              Navigator.pop(context); // tutup dialog
              Navigator.pop(context); // kembali ke home

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Buku Berhasil Dihapus'),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
            ),
          );
        },
            child: Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        backgroundColor: Colors.teal,
        actions: [
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
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            padding: EdgeInsets.zero,
            onSelected: (value) {
              if (value == 'edit') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditBookPage(book: book),
                  ),
                ).then((_) {
                  setState(() {});
                });
                
              } else if (value == 'delete') {
                _showDeleteDialog();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(value: 'delete', child: Text('Hapus')),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: book.imagePath.startsWith('assets/')
                ? Image.asset(book.imagePath, height: 250, fit: BoxFit.cover)
                : Image.file(File(book.imagePath), height: 250, fit: BoxFit.cover),
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
