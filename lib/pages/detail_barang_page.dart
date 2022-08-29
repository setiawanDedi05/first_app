import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/barang.dart';

class DetailBarang extends StatelessWidget {
  static const routeName = "/detail-player";

  @override
  Widget build(BuildContext context) {
    final barang = Provider.of<Barangs>(context, listen: false);
    final barangId = ModalRoute.of(context).settings.arguments as String;
    final selectPLayer = barang.selectById(barangId);
    final TextEditingController kategoriController =
        TextEditingController(text: selectPLayer.kategori);
    final TextEditingController namaBarangController =
        TextEditingController(text: selectPLayer.nama_barang);
    final TextEditingController hargaController =
        TextEditingController(text: selectPLayer.harga_barang.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("DETAIL BARANG"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(kategoriController.text),
                    ),
                  ),
                ),
              ),
              TextFormField(
                autocorrect: false,
                autofocus: true,
                decoration: InputDecoration(labelText: "Nama Barang"),
                textInputAction: TextInputAction.next,
                controller: namaBarangController,
              ),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Harga Barang"),
                textInputAction: TextInputAction.next,
                controller: hargaController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "Kategori"),
                textInputAction: TextInputAction.done,
                controller: kategoriController,
                onEditingComplete: () {
                  barang
                      .editBarang(
                    barangId,
                    namaBarangController.text,
                    hargaController.text,
                    double.parse(kategoriController.text),
                  )
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Berhasil diubah"),
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
                child: OutlinedButton(
                  onPressed: () {
                    barang
                        .editBarang(
                      barangId,
                      namaBarangController.text,
                      hargaController.text,
                      double.parse(kategoriController.text),
                    )
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Berhasil diubah"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    "Edit",
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
