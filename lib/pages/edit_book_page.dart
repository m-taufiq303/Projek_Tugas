import 'dart:io';
import 'package:flutter/material.dart';
import '../models/book.dart';
import 'package:image_picker/image_picker.dart';

class EditBookPage extends StatefulWidget {
  final Book book;

  const EditBookPage({super.key, required this.book});

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  late TextEditingController titleController;
  late TextEditingController descController;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.book.title);
    descController = TextEditingController(text: widget.book.description);
    imagePath = widget.book.imagePath;
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imagePath = picked.path;
      });
    }
  }

  void saveEdit() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Edit Data Buku'),
        content: Text('Apakah Anda yakin ingin menyimpan perubahan?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Tidak'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Ya'),
          ),
        ],
      ),
    );

    if (confirm == true) {
    setState(() {
      widget.book.title = titleController.text;
      widget.book.description = descController.text;
      widget.book.imagePath = imagePath ?? widget.book.imagePath;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data Buku Berhasil Diperbarui'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context); // kembali ke halaman detail
    Navigator.pop(context); // kembali ke home
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Buku'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: imagePath != null
                  ? (imagePath!.startsWith('assets/')
                      ? Image.asset(imagePath!, height: 200, fit: BoxFit.cover)
                      : Image.file(File(imagePath!), height: 200, fit: BoxFit.cover))
                  : Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: Icon(Icons.add_a_photo, size: 50),
                    ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Judul Buku'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descController,
              maxLines: 4,
              decoration: InputDecoration(labelText: 'Deskripsi Buku'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: saveEdit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: Text('SIMPAN PERUBAHAN'),
            ),
          ],
        ),
      ),
    );
  }
}
