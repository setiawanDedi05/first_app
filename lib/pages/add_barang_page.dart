import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/barang.dart';

class AddBarang extends StatelessWidget {
  static const routeName = "/add-player";
  final TextEditingController namaBarangController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final barang = Provider.of<Barangs>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD PLAYER"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              barang
                  .addBarang(
                namaBarangController.text,
                kategoriController.text,
                double.parse(hargaController.text),
                context,
              )
                  .then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Berhasil ditambahkan"),
                    duration: Duration(seconds: 2),
                  ),
                );
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                autofocus: true,
                decoration: InputDecoration(labelText: "Nama Barang"),
                textInputAction: TextInputAction.next,
                controller: namaBarangController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "Kategori"),
                textInputAction: TextInputAction.next,
                controller: kategoriController,
              ),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Harga"),
                textInputAction: TextInputAction.done,
                controller: hargaController,
                onEditingComplete: () {
                  barang
                      .addBarang(
                    namaBarangController.text,
                    kategoriController.text,
                    double.parse(hargaController.text),
                    context,
                  )
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Berhasil ditambahkan"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Navigator.pop(context);
                  });
                },
              ),
              SizedBox(height: 50),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    barang
                        .addBarang(
                      namaBarangController.text,
                      kategoriController.text,
                      double.parse(hargaController.text),
                      context,
                    )
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Berhasil ditambahkan"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
