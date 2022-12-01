import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reklama_app/add_product/page/add_product_page.dart';
import 'package:reklama_app/model/product_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Stream<QuerySnapshot> readProduct() {
    final db = FirebaseFirestore.instance;
    return db.collection('products').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ЖАРНАМАЛАР', textAlign: TextAlign.center),
      ),
      body: StreamBuilder(
        stream: readProduct(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error!.toString()));
          } else if (snapshot.hasData) {
            final List<Product> products = snapshot.data!.docs
                .map((d) => Product.fromMap(d.data() as Map<String, dynamic>))
                .toList();
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];
                return Card(
                    child: Column(
                  children: [
                    product.images != null
                        ? SizedBox(
                            height: 200,
                            child: PageView.builder(
                              itemCount: product.images!.length,
                              itemBuilder: (context, index) {
                                final image = product.images![index];
                                return Image.network(image);
                              },
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 30),
                    const Divider(
                      height: 30,
                      thickness: 2,
                      color: Colors.blue,
                      indent: 50,
                      endIndent: 50,
                    ),
                    ListTile(
                      title: Text(product.userName),
                      leading: Text(product.title),
                      subtitle: Text(product.description),
                      trailing: Text(product.price ?? ''),
                    )
                  ],
                ));
              },
            );
          } else {
            return const Center(child: Text('Some Error'));
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductPage(),
            ),
          );
        },
      ),
    );
  }
}
