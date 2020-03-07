import 'package:bytebank/components/mensagens.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/model/contact.dart';
import 'package:bytebank/persist/dao.dart';
import 'package:bytebank/ui/contact_form.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Titulo da tela Contatos'),
      ),
      body: getFuturedContactList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ContactForm(Contact("",0))));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getFuturedContactList() {
    
    return FutureBuilder<List<Contact>> (
        //Para efeitos de teste, pode ser usado um delay na chamda do findAll no future
        //future: Future.delayed(Duration(seconds: 3)).then( (value) => AppDAO.findAll() ),
        future: AppDAO.findAll(), // O que deve ser excutado
        builder: (context, snapshot) { //funcao de callback apos o future ser executado. Nao garante sincronismo
           //Fundamental para realizar o tratamento asyncrono
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              //Dado disponivel porem o future nao foi finalizado
              break;
            case ConnectionState.done:
              // Future finalizado, dado disponivel
              return getWidgetForStatusDone(snapshot);
              break;
          }
          return Text(
              "Status desconhecido"
          ); //nunca deveria ser executado este return 
        },
      );
  }

  Widget getWidgetForStatusDone(AsyncSnapshot snapshot) {
    final List<Contact> contacts = snapshot.data;

    //Pode ser exibiada uma tela caso nao tenha nenhum contato no retorno
    if ( !snapshot.hasData ) //Trata situação: retorno vazio, endpoint com nome errado, servidor fora
      return MensagemUtil(
        "Nenhum contato retornado", 
        icon: Icons.warning,
      );

    //Se chegar aqui é pq teve retorno de contatos, irá retornar a lista
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final Contact contact = contacts[index];
        debugPrint(contact.toString());
        return ListTile(
          title: Text(contact.nome),
          subtitle: Text(contact.conta.toString()),
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ContactForm(contacts[index]))),
        );
      },
    );
  }
}
