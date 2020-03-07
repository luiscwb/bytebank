import 'package:flutter/material.dart';

import 'contacts_list.dart';

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getImagemPrincipal(),
              getBotaoContatos(context),
            ]));
  }

  Padding getBotaoContatos(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
              color: Theme.of(context).primaryColor,
              child: InkWell(
          //Para tratar eventos num widget que nao permite, envolver com InkWell
          //Tambem usado Material para dar uma aperiencia de botao do material
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ContactList()));
          },
          child: Container(
              padding: EdgeInsets.all(8),
              height: 100,
              width: 100,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.people,
                      color: Colors.white,
                      size: 24,
                    ),
                    Text('Contacts',
                        style: TextStyle(color: Colors.white, fontSize: 16.0)),
                  ])),
        ),
      ),
    );
  }

  Padding getImagemPrincipal() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset('assets/capa.jpeg'),
    );
  }
}
