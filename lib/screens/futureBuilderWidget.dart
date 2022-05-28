import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FutureBuilderWidget extends StatelessWidget {
  const FutureBuilderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection("name").snapshots(),
        builder: (ctx, data) {
          if (data.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.data!.docs.length,
            itemBuilder: (ctx, i) => Text(data.data!.docs[i]["name"]),
          );
        },
      ),
    );
  }
}
