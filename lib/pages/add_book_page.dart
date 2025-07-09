import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/book.dart';
import '../data/book_data.dart';

class AddBookPage extends StatefulWidget {
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  File? imageFile;
  final picker = ImagePicker();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Buku'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    image: imageFile != null
                        ? DecorationImage(
                            image: FileImage(imageFile!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: imageFile == null
                      ? Center(
                          child: Text(
                            'Tap untuk pilih gambar',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : null,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Judul Buku'),
                validator: (val) => val!.isEmpty ? 'Judul wajib diisi' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: descController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
                maxLines: 3,
                validator: (val) => val!.isEmpty ? 'Deskripsi wajib diisi' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Tambah Buku Baru?'),
                      content: Text('Apakah Anda yakin ingin menambahkan buku ini ke koleksi?'),
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
                    bookList.add(Book(
                      title: titleController.text,
                      description: descController.text,
                      imagePath: imageFile?.path ?? 'assets/images/default.jpg',
                      isBookmarked: false,
                    ));

                    Navigator.pop(context, true);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Buku berhasil ditambahkan'),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
                child: Text('SIMPAN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
