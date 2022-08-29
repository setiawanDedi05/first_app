import 'package:flutter/material.dart';
import 'package:myproject/providers/barang.dart';
import 'package:provider/provider.dart';

class SearchingPage extends StatefulWidget {
  static const routeName = "/search-barang";

  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  bool isInit = true;
  @override
  Widget build(BuildContext context) {
    final allBarangProvider = Provider.of<Barangs>(context);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) => allBarangProvider.runFilter(value),
          decoration: InputDecoration(
            labelText: "Search",
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: Container(
          child: allBarangProvider.foundBarang.isNotEmpty
              ? ListView.builder(
                  itemCount: allBarangProvider.foundBarang.length,
                  itemBuilder: (context, index) {
                    return Card(
                      key: Key(allBarangProvider.foundBarang[index].id),
                      color: Colors.amber,
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: CircleAvatar(
                          child:
                              Image.asset("assets/images/logo_kecil_putih.png"),
                        ),
                        title: Text(
                            allBarangProvider.foundBarang[index].nama_barang),
                        subtitle: Text(allBarangProvider
                            .foundBarang[index].harga_barang
                            .toString()),
                      ),
                    );
                  })
              : Center(
                  child: Text(
                    "Tidak Ada Data",
                    style: TextStyle(fontSize: 24),
                  ),
                )),
    );
  }
}
