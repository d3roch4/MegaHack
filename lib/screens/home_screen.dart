import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invest_flix/models/titulo_model.dart';
import 'package:invest_flix/screens/acao_screen.dart';
import 'package:invest_flix/screens/home_ctrl.dart';
import 'package:invest_flix/screens/home_ctrl.dart';
import 'package:invest_flix/widgets/content_scroll.dart';
import 'package:invest_flix/widgets/imagem.dart';

class HomeScreen extends StatelessWidget {
  PageController _pageController;
  final HomeCtrl controller = Get.put(HomeCtrl());

  HomeScreen(){
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  _movieSelector(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 270.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () => Navigator.push(
          Get.context,
          MaterialPageRoute(
            builder: (_) => AcaoScreen(acao: destaques[index]),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Hero(
                    tag: destaques[index].image,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        image: destaques[index].image.startsWith('http') ?
                        NetworkImage(destaques[index].image) :
                        AssetImage(destaques[index].image),
                        height: 220.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30.0,
              bottom: 40.0,
              child: Container(
                width: 250.0,
                child: Text(
                  destaques[index].name.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.white,
      appBar: AppBar(
//        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text('InvestFlix'),
        leading: IconButton(
          padding: EdgeInsets.only(left: 30.0),
          onPressed: () => print('Menu'),
          icon: Icon(Icons.menu),
          iconSize: 30.0,
//          color: Colors.black,
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 30.0),
            onPressed: () => print('Search'),
            icon: Icon(Icons.search),
            iconSize: 30.0,
//            color: Colors.black,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          Container(
            height: 280.0,
            width: 500,
            child: PageView.builder(
              controller: _pageController,
              itemCount: destaques.length,
              itemBuilder: (BuildContext context, int index) {
                return _movieSelector(index);
              },
            ),
          ),
          Container(
            height: 90.0,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              scrollDirection: Axis.horizontal,
              itemCount: labels.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(10.0),
                  width: 160.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFD45253),
                        Color(0xFF9E1F28),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF9E1F28),
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      labels[index].toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.8,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20.0),
          ContentScroll(
            images: myList,
            title: 'Minha Carteira',
            imageHeight: 250.0,
            imageWidth: 150.0,
          ),
          SizedBox(height: 10.0),
          gridOpcoes()
        ],
      ),
    );
  }

  Widget gridOpcoes(){
    return StreamBuilder<List<Titulo>>(
      stream: controller.titulos,
      builder: (ctx, titulos){
        if(titulos.hasError)
          return Text(titulos.error.toString());
        else if(titulos.data == null)
          return Center(child: CircularProgressIndicator());

        return GridView.count(
//          childAspectRatio: 3/4,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: Get.width > 680 ? 2 : 1,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(titulos.data.length, (i) {
            var titulo = titulos.data[i];

            return Card(
              elevation: 16,
              child: GridTile(
                child: Image(image: getImagem(titulo.image)),
                header: Text(titulo.name, style: Get.theme.textTheme.headline5),
                footer: Column(children: [
                  Row(
                    children: [Text('Preço Venda: ${titulo.sale_price}, Preço de compra: ${titulo.purchase_price}')],
                  ),
                  Row(
                    children: [Text('Risco: ${titulo.beta}, Liquides: ${titulo.liquids}')],
                  ),
                  Text('Retorno: ${titulo.return_rate}')
                ]),
              )
            );
          }),
        );
      },
    );
  }
}
