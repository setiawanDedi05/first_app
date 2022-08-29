import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/barang.dart';
import 'package:http/http.dart' as http;

class Barangs with ChangeNotifier {
  List<Barang> _allBarang = [];
  List<Barang> _foundBarang = [];

  List<Barang> get allBarang => _allBarang;
  List<Barang> get foundBarang => _foundBarang;

  int get jumlahBarang => _allBarang.length;

  Barang selectById(String id) =>
      _allBarang.firstWhere((element) => element.id == id);

  Future<void> addBarang(
      String nama_barang, String kategori, double harga, BuildContext context) {
    Uri url = Uri.parse(
        "https://learningflutter-48b1f-default-rtdb.firebaseio.com/warung.json");
    return http
        .post(url,
            body: json.encode(
              {
                "nama_barang": nama_barang,
                "harga_barang": harga,
                "kategori": kategori
              },
            ))
        .then((response) {
      _allBarang.add(
        Barang(
          id: jsonDecode(response.body)["name"].toString(),
          nama_barang: nama_barang,
          kategori: kategori,
          harga_barang: harga,
        ),
      );
      notifyListeners();
    });
  }

  Future<void> editBarang(
      String id, String nama_barang, String kategori, double harga) {
    Uri url = Uri.parse(
        "https://learningflutter-48b1f-default-rtdb.firebaseio.com/warung/$id.json");
    DateTime datetimeNow = DateTime.now();
    return http
        .patch(url,
            body: json.encode(
              {
                "nama_barang": nama_barang,
                "harga_barang": harga,
                "kategory": kategori
              },
            ))
        .then((response) {
      Barang selectBarang =
          _allBarang.firstWhere((element) => element.id == id);
      selectBarang.nama_barang = nama_barang;
      selectBarang.kategori = kategori;
      selectBarang.harga_barang = harga;
      notifyListeners();
    });
  }

  Future<void> deleteBarang(String id) {
    Uri url = Uri.parse(
        "https://learningflutter-48b1f-default-rtdb.firebaseio.com/warung/$id.json");
    return http.delete(url).then((response) {
      _allBarang.removeWhere((element) => element.id == id);
      notifyListeners();
    });
  }

  runFilter(String inputKeyword) {
    List<Barang> results = [];
    if (inputKeyword.isEmpty) {
      results = allBarang;
    } else {
      results = allBarang.where((item) {
        return item.nama_barang
            .toString()
            .toLowerCase()
            .contains(inputKeyword.toLowerCase());
      }).toList();
      _foundBarang = results;
      notifyListeners();
    }
  }

  initialData() async {
    Uri url = Uri.parse(
        "https://learningflutter-48b1f-default-rtdb.firebaseio.com/warung.json");
    await http.get(url).then((value) {
      var data = json.decode(value.body) as Map<String, dynamic>;
      if (!data.isEmpty) {
        data.forEach(((key, value) {
          _allBarang.add(Barang(
              id: key,
              nama_barang: value["nama_barang"],
              kategori: value["kategori"],
              harga_barang: value["harga_barang"]));
          _foundBarang.add(Barang(
              id: key,
              nama_barang: value["nama_barang"],
              kategori: value["kategori"],
              harga_barang: value["harga_barang"]));
        }));
        notifyListeners();
      }
    });
  }
}
