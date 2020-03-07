import 'package:bytebank/model/contact.dart';

class AppDAO {

  static List<Contact> _contatos = new List<Contact>();

  //AppDAO(this._contatos);

  static void save(Contact newContato) {
    _contatos.add(newContato);
  }
  
  static Future<List<Contact>> findAll() {
    return Future.value(_contatos);
  }
}