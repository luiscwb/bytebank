import 'package:bytebank/model/contact.dart';
import 'package:bytebank/persist/dao.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {

  //Para inicializar esta widget deve ser passado um contato. (caso update estará populado)
  final Contact contato;
  ContactForm(this.contato);

  //Cuando usar controller, deve ser usada StateFullWidget, fazer a transformacao
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {

  TextEditingController _nomeController;

  TextEditingController _contaController;

  @override
  void initState() {
    //Inicializa campos, caso edit
    _nomeController  = TextEditingController(text: widget.contato.nome);
    _contaController = TextEditingController(text: widget.contato.conta.toString());
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Novo Contato'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: <Widget>[
            getInputNome(),
            getInputConta(),
            getButtonCriar(),
          ]),
        ));
  }

  Padding getButtonCriar() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: SizedBox( //SizedBox permite definir um width para o button, para poder aumentar ele
        width: double.maxFinite, //o maximo possivel, ocupara tudo o width do Column
        child: RaisedButton(
          child: Text('Salvar'),
          onPressed: () {
            final String nome  = _nomeController.text; //recupera nome digitado no textbox
            final int conta = int.tryParse(_contaController.text); //recupera conta digitada
            final Contact newContact = Contact(nome, conta); //construtor da classe model/Contact
            AppDAO.save(newContact);
            Navigator.pop(context);
            //Navigator.pop(context, newContact);
          },
        ),
      ),
    );
  }

  Widget getInputConta() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        controller: _contaController, //link com o contralador do campo, permite obter o valor
        decoration: InputDecoration(
          labelText: 'Numero da conta',
        ),
        style: TextStyle(
          fontSize: 24,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget getInputNome() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        controller: _nomeController, //link com o controller 
        decoration: InputDecoration(
          labelText: 'Nome completo',
        ),
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}
