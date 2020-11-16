import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invest_flix/models/titulo_model.dart';
import 'package:invest_flix/screens/classifier_screen.dart';
import 'package:invest_flix/screens/titulos_ctrl.dart';
import 'package:invest_flix/screens/home_screen.dart';

void main() async {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var buttonTheme = ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        textTheme: ButtonTextTheme.primary
    );

    ThemeData temaClaro = ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        buttonTheme: buttonTheme,
    );
    return GetMaterialApp(
      theme: temaClaro,
      title: 'InvesFlix',
      debugShowCheckedModeBanner: false,
      home: FirstUse(),
    );
  }
}

class FirstUse extends StatelessWidget{
  final TitulosCtrl controller = Get.put(TitulosCtrl());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Titulo>>(
      stream: controller.titulos,
      builder: (ctx, titulos){
        if(titulos.hasError)
          return Text(titulos.error.toString());
        else if(titulos.data == null)
          return Center(child: CircularProgressIndicator());
        int qtdFavoite=0;
        for(var titulo in titulos.data)
          qtdFavoite += titulo.favorite==true? 1 : 0;
        if(qtdFavoite>0)
          return HomeScreen();
        else
          return ClassifierSreen();
      }
    );
  }
  
}
