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
  String title = '';
  String description = '';
  String category = '';
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

  void saveBook() {
    if (_formKey.currentState!.validate()) {
      bookList.add(
        Book(
          title: title,
          description: description,
          imagePath: imageFile?.path ?? 'assets/images/default.jpg', // fallback
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Buku'), backgroundColor: Colors.teal),
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
                          child: Text('Tap untuk pilih gambar',
                              style: TextStyle(color: Colors.grey)),
                        )
                      : null,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Judul Buku'),
                validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
                onChanged: (val) => title = val,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Deskripsi'),
                maxLines: 3,
                validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
                onChanged: (val) => description = val,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveBook,
                child: Text('SIMPAN'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
