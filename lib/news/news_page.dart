import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yapindo_test/news/news_bloc/news_bloc.dart';
import 'package:yapindo_test/news/news_bloc/news_event.dart';
import 'package:yapindo_test/news/news_bloc/news_state.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Map<String, dynamic>> newsList = [];
  double sizeboxHeight = 10;
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NewsBloc>().add(NewsStart());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewsBloc, NewsState>(
      listener: (context, state) {
        if (state is NewsInitial) {
          AlertDialog(
            content: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is NewsFinished) {
          setState(() {
            newsList = state.news.map((e) => e.toMap()).toList();
          });
        }
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 182, 255, 98),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 182, 255, 98),
          leading: Icon(Icons.list_alt),
          title: TextFormField(
            controller: search,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
              labelText: "Search",
            ),
          ),
          actions: [Icon(Icons.notification_add)],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Temukan Beritamu",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(
                    height: sizeboxHeight,
                  ),
                  Text(
                    "Dapatkan Akses Ekslusif untuk jurnal kesehatan terbaru dan terlengkap dari sumber terpercaya",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: sizeboxHeight,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            child: Card(
                              color: Colors.orange,
                              child: Center(
                                  child: Text("${newsList[index]['author']}")),
                            ),
                          ),
                          SizedBox(
                            height: sizeboxHeight,
                          ),
                          Text("${newsList[index]['title']}"),
                          SizedBox(
                            height: sizeboxHeight,
                          ),
                          Container(
                            child: Card(
                              color: Colors.blue,
                              child: Center(
                                child: Column(
                                  children: [
                                    Text("Source"),
                                    Text(
                                        "${newsList[index]['source']['name']}"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
