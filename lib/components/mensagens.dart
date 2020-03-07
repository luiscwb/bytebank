import 'package:flutter/material.dart';

class MensagemUtil extends StatelessWidget {
  final String mensagem;
  final IconData icon;
  final double iconSize;
  final double fontSize;

  MensagemUtil(this.mensagem,
      {this.icon, this.iconSize = 64, this.fontSize = 24});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Visibility( //Usado para mostrar o icon caso seja especificado no construtor
            child: Icon(
              icon,
              size: iconSize,
            ),
            visible: icon != null, //parametro adicional
          ),
          Padding(
           //padding: const EdgeInsets.all(value),
          ),
        ],
      ),
    );
  }
}
