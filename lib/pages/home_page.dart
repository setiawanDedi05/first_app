import 'package:flutter/material.dart';
import 'package:myproject/pages/searching_page.dart';
import 'package:provider/provider.dart';

import 'detail_barang_page.dart';
import 'add_barang_page.dart';

import '../providers/barang.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Barangs>(context).initialData();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final allPlayerProvider = Provider.of<Barangs>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Semua Barang"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddBarang.routeName);
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, SearchingPage.routeName);
            },
          ),
        ],
      ),
      body: (allPlayerProvider.jumlahBarang == 0)
          ? Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No Data",
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AddBarang.routeName);
                    },
                    child: Text(
                      "Add Player",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: allPlayerProvider.jumlahBarang,
              itemBuilder: (context, index) {
                var id = allPlayerProvider.allBarang[index].id;
                return Dismissible(
                  background: Container(
                    color: Colors.red,
                  ),
                  onDismissed: ((direction) {
                    allPlayerProvider.deleteBarang(id).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Berhasil dihapus"),
                          duration: Duration(milliseconds: 500),
                        ),
                      );
                    });
                  }),
                  confirmDismiss: (data) {
                    return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: Text("Confirmation!"),
                              content: Text("Are You Sure Delete This Item?"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text("No")),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Text("Yes")),
                              ]);
                        });
                  },
                  key: Key(id),
                  direction: DismissDirection.endToStart,
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailBarang.routeName,
                        arguments: id,
                      );
                    },
                    leading: CircleAvatar(
                      child: Image.asset("assets/images/logo_kecil_putih.png"),
                    ),
                    title: Text(
                      allPlayerProvider.allBarang[index].nama_barang,
                    ),
                    subtitle: Text(allPlayerProvider
                        .allBarang[index].harga_barang
                        .toString()),
                    trailing: IconButton(
                      onPressed: () {
                        allPlayerProvider.deleteBarang(id).then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Berhasil dihapus"),
                              duration: Duration(milliseconds: 500),
                            ),
                          );
                        });
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
