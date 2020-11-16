import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invest_flix/models/titulo_model.dart';
import 'package:invest_flix/widgets/imagem.dart';

import 'titulos_ctrl.dart';

class ClassifierSreen extends StatelessWidget{
  final TitulosCtrl controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Classifique')),
      body: StreamBuilder<List<Titulo>>(
        stream: controller.titulos,
        builder: (ctx, titulos){
          if(titulos.hasError)
            return Text(titulos.error.toString());
          else if(titulos.data == null)
            return Center(child: CircularProgressIndicator());

          return GridView.count(
//          childAspectRatio: 3/4,
            crossAxisCount: Get.width > 680 ? 3 : 2,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(titulos.data.length, (i) {
              var titulo = titulos.data[i];
              return CardTitulo(titulo);
            }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Treinar'),
        icon: Icon(Icons.send),
        onPressed: controller.treinarAi,
      ),
    );
  }
}

class CardTitulo extends StatefulWidget{
  Titulo titulo;

  CardTitulo(this.titulo);

  @override
  _CardTituloState createState() => _CardTituloState();
}

class _CardTituloState extends State<CardTitulo> {
  TitulosCtrl ctrl = Get.find();
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 16,
        child: GridTile(
          child: Image(image: getImagem(widget.titulo.image)),
          header: Row(children: [
            Expanded(child: Text(widget.titulo.name, style: Get.theme.textTheme.headline5)),
            IconButton(
                icon: Icon(widget.titulo.favorite==true ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                onPressed: ()=>setState(()=>ctrl.favorite(widget.titulo))
            )
          ]),
          footer: Column(children: [
            Row(
              children: [Text('Preço Venda: ${widget.titulo.sale_price}, Preço de compra: ${widget.titulo.purchase_price}')],
            ),
            Row(
              children: [Text('Risco: ${widget.titulo.beta}, Liquides: ${widget.titulo.liquids}')],
            ),
            Text('Retorno: ${widget.titulo.return_rate}')
          ]),
        )
    );
  }
}