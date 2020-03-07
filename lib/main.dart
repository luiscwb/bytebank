// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:bytebank/components/navigation.dart';
import 'package:bytebank/ui/dashboard.dart';

import 'model/contact.dart';
import 'persist/dao.dart';

//void main() => runApp(MyApp());
//void main() => runApp(MySimpleApp());
//void main() => runApp(HorizontalListView());

void main() {
  runApp(ByteBankApp());
  AppDAO.save(new Contact('Luis Maini', 1000));
  AppDAO.save(new Contact('João Silva', 2000));
  AppDAO.findAll().then( (contact) => debugPrint(contact.toString()) );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: _createAppBar(),
        body: _createBody(context),
        bottomNavigationBar: MainBottonNavigationBar(),
      ),
    );
  }

  Widget _createBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
                color: Colors.yellow,
                child: Text(
                  'dont f** with cats dont f** with catas dont f** with cats',
                )),
          ),
          Expanded(
            flex: 6,
            child: Container(
              child: _createListView(context),
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  AppBar _createAppBar() {
    return AppBar(
      title: Text('Titulo principal do aplicativo'),
    );
  }

  Widget _createListView(BuildContext context) {
    return ListView(
      children: <Widget>[
        _createListViewItem('assets/imagem1.jpg', 'Texto principal opção 1',
            'Texto secuandrio'),
        _createListViewItem('assets/imagem2.jpg', 'Texto principal opção 2',
            'Texto secuandrio'),
        _createListViewItem('assets/imagem3.jpg', 'Texto principal opção 3',
            'Texto secuandrio'),
      ],
    );
  }

  Widget _createListViewItem(String imagem, String texto1, String texto2) {
    return Card(
      child: ListTile(
          leading: _createListTile(imagem),
          title: Text(texto1),
          subtitle: Text(texto2),
          onTap: () {
            print('Tap!!!');
          }),
    );
  }

  ConstrainedBox _createListTile(String imagem) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 44,
        minHeight: 44,
        maxWidth: 64,
        maxHeight: 64,
      ),
      child: Image.asset(imagem, fit: BoxFit.cover),
    );
  }
}

class MySimpleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        Expanded(
          flex: 7,
          child: Column(
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.green,
                  child: Image.asset('assets/capa.jpeg', fit: BoxFit.scaleDown),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.yellow,
          ),
        ),
      ],
    );
  }
}

class HorizontalListView extends StatelessWidget {
  final List<String> _alphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Horizontal ListView Example'),
        ),
        body: Center(
          child: ListView(
            padding: EdgeInsets.all(10.0),
            scrollDirection: Axis.horizontal,
            children: _alphabets
                .map((data) => CircleAvatar(
                      minRadius: 50.0,
                      backgroundColor: Colors.red,
                      child: Text(data,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19.0,
                          )),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
