import 'dart:convert';

import 'package:bytebank/model/contact.dart';
import 'package:bytebank/services/http/interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

Future<List<Contact>> findAll() async {

  //Cria um client com um interceptor associado. Nese exemplo usado para gerar logs
  Client client = HttpClientWithInterceptor.build(interceptors: [ LoggingInterceptor() ]);

  //Realiza Get em forma asyncrona
  //Fundamental usar timeout para ter uma reposta caso o servidor da api esteja fora
  final Response response = await client.get('url_webapi').timeout(Duration(seconds: 5));


  //Realiza o decode para Json, deve ser usado dynamic no tipo da lista de objetos retornados.
  final List<dynamic> decodedJson = jsonDecode(response.body);

  //Lista de contatatos retoranda pelo findAll
  List<Contact> contatos = List();

  //Itera nos elementos retornados, usado uma Map de chave,valor
  //as chaves dependem inteiramente do retorno da api chamada
  for (Map<String,dynamic> element in decodedJson) {
    final contato = Contact.fromJson(element);
    contatos.add(contato);
  }

  return contatos;
}


Future<Contact> save(Contact contato) async {

  //Cria um client com um interceptor associado. Nese exemplo usado para gerar logs
  Client client = HttpClientWithInterceptor.build(interceptors: [ LoggingInterceptor() ]);

  //Objeto para Json
  //1:Converter a instancia contato para um map
  final Map<String, dynamic> contatoMap = {
    'nome': contato.nome,
    'conta': contato.conta,
  };
  //2:Converter o Mpa para um json
  final String contatoJson = jsonEncode(contatoMap);


  Response response = await client.post(
    'webapi_endpoint', 
    headers: { //cria um map sem declarar, usando {} e :
      'Content-type' : 'application/json',
       'password' : '1000',
    },
    body: contatoJson,
  );

  //Tratar response da webapi
  //Quando faço um decode obtenho como retorno um Mpa<String, dynamic>
  Map<String, dynamic> mapResponse = jsonDecode(response.body);
  //Agora contruir objeto Contact usando o map
  return Contact.fromJson(mapResponse);

}