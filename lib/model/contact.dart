class Contact {
  
  final String _nome;
  final int _conta;

  //Create constructor from final fields
  Contact(
    this._nome, 
    this._conta
  );


  //Getters
  String get nome => this._nome;
  int get conta => this._conta;

  //Instancia a partir de  Json
  factory Contact.fromJson(Map<String, dynamic> map) => new Contact(
    map['nome'],
    map['conta'],
  );

  //Instancia para Json
  Map<String, dynamic> toJson() => {
    "nome": this._nome,
    "conta": this._conta,
  };

  @override
  String toString() {
      return 'Contato: {nome: $_nome, conta: $_conta}';
  }

}