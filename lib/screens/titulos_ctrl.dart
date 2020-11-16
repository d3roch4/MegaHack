import 'package:get/get.dart';
import 'package:invest_flix/models/titulo_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';

import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_preprocessing/ml_preprocessing.dart';

import '../contantes.dart';

class TitulosCtrl {
  BehaviorSubject<List<Titulo>> titulosStream;
  BehaviorSubject<List<Titulo>> titulosPurchasedStream;
  LogisticRegressor classifier;

  get titulosPurchased {
    if(titulosPurchasedStream?.isClosed ?? true){
      titulosPurchasedStream = BehaviorSubject(onCancel: ()=>titulosPurchasedStream.close());
    }
    return titulosPurchasedStream.stream;
  }

  get titulos {
    if(titulosStream?.isClosed ?? true){
      titulosStream = BehaviorSubject(onCancel: ()=>titulosStream.close());
//      getTitulosApi();
      insertJson(null);
    }
    return titulosStream.stream;
  }

  double toDouble(dynamic value){
    return value is String
        ? value.isEmpty ? 0 : double.parse(value.replaceAll(',', '.'))
        : value.toDouble();
  }

  void insertJson(dynamic dados){
    if(dados == null){
      dados = json.decode('[{"code":"PETR3","beta":5,"sale_price":22.65,"purchase_price":22.63,"liquids":0.99,"return_rate":"-14.3","tipo":1,"aposentadoria":"1","consumo":"1","especular":"1","patrimonio":"1","reserva":"0","name":"Petrobrás","image":"https://pbs.twimg.com/profile_images/799597328730558464/ks3kVnp-_400x400.jpg"},{"code":"MGLU3","beta":2,"sale_price":25.1,"purchase_price":25,"liquids":2,"return_rate":"5.68","tipo":1,"aposentadoria":"0","consumo":"1","especular":"1","patrimonio":"0","reserva":"0","name":"Magazine Luisa","image":"https://media-exp1.licdn.com/dms/image/C4E0BAQH1l0leqQU13g/company-logo_200_200/0?e=2159024400&v=beta&t=BWY_PAE4CPM-f1yLOK_bUWitafXbemCgDzh_G5cg_jE"},{"code":"VALE3","beta":1.9,"sale_price":63.26,"purchase_price":63.25,"liquids":4,"return_rate":"5.71","tipo":1,"aposentadoria":"1","consumo":"1","especular":"1","patrimonio":"0","reserva":"0","name":"","image":""},{"code":"GOOGL","beta":1.03,"sale_price":9688.78,"purchase_price":9672.46,"liquids":5,"return_rate":"4.98","tipo":1,"aposentadoria":"0","consumo":"0","especular":"1","patrimonio":"1","reserva":"1","name":"","image":""},{"code":"FundoImobiliario","beta":10,"sale_price":12,"purchase_price":7,"liquids":6,"return_rate":"5.34","tipo":1,"aposentadoria":"0","consumo":"0","especular":"1","patrimonio":"1","reserva":"1","name":"","image":""},{"code":"FundoMineracao","beta":4,"sale_price":"32.48","purchase_price":"33.90","liquids":"1.04","return_rate":"4.99","tipo":1,"aposentadoria":"1","consumo":"1","especular":"1","patrimonio":"0","reserva":"0","name":"","image":""},{"code":"tesouroSelic2025","beta":"","sale_price":"","purchase_price":106.37,"liquids":1,"return_rate":0.2119,"tipo":2,"aposentadoria":"","consumo":"","especular":"","patrimonio":"","reserva":"","name":"","image":""},{"code":"tesouroIPCA2026","beta":"","sale_price":"","purchase_price":57.05,"liquids":"","return_rate":2.94,"tipo":2,"aposentadoria":"","consumo":"","especular":"","patrimonio":"","reserva":"","name":"","image":""},{"code":"BBVJ11","beta":"","sale_price":"","purchase_price":62.99,"liquids":"","return_rate":"","tipo":"","aposentadoria":"","consumo":"","especular":"","patrimonio":"","reserva":"","name":"FII Cidade Continental Tower","image":""},{"code":"BRCR11","beta":"","sale_price":"","purchase_price":88.19,"liquids":"","return_rate":"","tipo":"","aposentadoria":"","consumo":"","especular":"","patrimonio":"","reserva":"","name":"FII BTG Pactual Corp Office fund","image":""},{"code":"ghd","beta":8,"sale_price":"12.70","purchase_price":14.57,"liquids":"1.10","return_rate":"5.35","tipo":1,"aposentadoria":"1","consumo":"1","especular":"1","patrimonio":"1","reserva":"0","name":"","image":""},{"code":"sdfw","beta":1,"sale_price":"32.49","purchase_price":"33.91","liquids":"1.16","return_rate":0.04,"tipo":1,"aposentadoria":"1","consumo":"0","especular":"1","patrimonio":"0","reserva":"0","name":"","image":""},{"code":"xcbe","beta":5,"sale_price":"12.71","purchase_price":"14.58","liquids":"1.22","return_rate":0.05,"tipo":1,"aposentadoria":"0","consumo":"0","especular":"1","patrimonio":"0","reserva":"0","name":"","image":""},{"code":"sne","beta":58,"sale_price":"32.50","purchase_price":"33.92","liquids":"1.28","return_rate":0.06,"tipo":1,"aposentadoria":"0","consumo":"1","especular":"1","patrimonio":"0","reserva":"0","name":"","image":""},{"code":"w4tg","beta":5,"sale_price":"12.72","purchase_price":"14.59","liquids":"1.34","return_rate":"5.37","tipo":1,"aposentadoria":"1","consumo":"1","especular":"1","patrimonio":"1","reserva":"0","name":"","image":""},{"code":"dgsr","beta":"1.13","sale_price":"32.51","purchase_price":"33.93","liquids":"1.40","return_rate":0.06,"tipo":1,"aposentadoria":"0","consumo":"1","especular":"1","patrimonio":"1","reserva":"1","name":"","image":""},{"code":"xfg4","beta":"1.18","sale_price":"12.73","purchase_price":"14.60","liquids":"1.46","return_rate":"5.38","tipo":1,"aposentadoria":"0","consumo":"1","especular":"1","patrimonio":"0","reserva":"1","name":"","image":""},{"code":"aw1","beta":"1.23","sale_price":"32.52","purchase_price":"33.94","liquids":"1.52","return_rate":0.07,"tipo":1,"aposentadoria":"1","consumo":"0","especular":"1","patrimonio":"1","reserva":"0","name":"","image":""},{"code":"k86g","beta":"1.28","sale_price":"12.74","purchase_price":"14.61","liquids":"1.58","return_rate":"5.39","tipo":1,"aposentadoria":"1","consumo":"0","especular":"1","patrimonio":"0","reserva":"0","name":"","image":""},{"code":"xxvb","beta":"1.33","sale_price":"32.53","purchase_price":"33.95","liquids":"1.64","return_rate":0.02,"tipo":1,"aposentadoria":"1","consumo":"1","especular":"1","patrimonio":"0","reserva":"0","name":"","image":""},{"code":"hbt","beta":"1.38","sale_price":"12.75","purchase_price":"14.62","liquids":"1.70","return_rate":"5.40","tipo":1,"aposentadoria":"1","consumo":"1","especular":"1","patrimonio":"0","reserva":"0","name":"","image":""},{"code":"uie4","beta":"1.43","sale_price":"32.54","purchase_price":"33.96","liquids":"1.76","return_rate":0.02,"tipo":1,"aposentadoria":"0","consumo":"0","especular":"1","patrimonio":"1","reserva":"0","name":"","image":""},{"code":"dh","beta":"1.44","sale_price":"32.55","purchase_price":"33.96","liquids":"1.82","return_rate":"5.41","tipo":1,"aposentadoria":"0","consumo":"0","especular":"1","patrimonio":"1","reserva":"0","name":"","image":""},{"code":"as4","beta":"1.45","sale_price":"32.56","purchase_price":"14.63","liquids":"1.88","return_rate":0.01,"tipo":1,"aposentadoria":"1","consumo":"1","especular":"1","patrimonio":"0","reserva":"1","name":"","image":""},{"code":"uog","beta":"1.46","sale_price":"32.57","purchase_price":"33.97","liquids":"1.94","return_rate":"5.42","tipo":1,"aposentadoria":"0","consumo":"1","especular":"1","patrimonio":"1","reserva":"1","name":"","image":""},{"code":"q3w5","beta":"1.47","sale_price":"32.58","purchase_price":"33.97","liquids":"1.100","return_rate":0.02,"tipo":1,"aposentadoria":"0","consumo":"1","especular":"1","patrimonio":"0","reserva":"0","name":"","image":""},{"code":"cvbdrr","beta":"1.48","sale_price":"32.59","purchase_price":"14.64","liquids":"1.106","return_rate":"5.43","tipo":1,"aposentadoria":"1","consumo":"1","especular":"1","patrimonio":"0","reserva":"0","name":"","image":""},{"code":"w4tg","beta":"1.49","sale_price":"32.60","purchase_price":"33.98","liquids":"1.112","return_rate":0.03,"tipo":1,"aposentadoria":"1","consumo":"0","especular":"1","patrimonio":"0","reserva":"0","name":"","image":""},{"code":"qw46","beta":"1.50","sale_price":"32.61","purchase_price":"33.98","liquids":"1.118","return_rate":"5.44","tipo":1,"aposentadoria":"1","consumo":"0","especular":"1","patrimonio":"1","reserva":"0","name":"","image":""},{"code":"iltgx","beta":"1.51","sale_price":"32.62","purchase_price":"14.65","liquids":"1.124","return_rate":4109,"tipo":1,"aposentadoria":"0","consumo":"1","especular":"1","patrimonio":"1","reserva":"0","name":"","image":""},{"code":"zxd4","beta":"1.52","sale_price":"32.63","purchase_price":"33.99","liquids":"1.130","return_rate":"5.45","tipo":1,"aposentadoria":"0","consumo":"1","especular":"1","patrimonio":"0","reserva":"0","name":"","image":""},{"code":"ni8e","beta":"1.53","sale_price":"32.64","purchase_price":"33.99","liquids":"1.136","return_rate":4110,"tipo":1,"aposentadoria":"1","consumo":"0","especular":"1","patrimonio":"1","reserva":"1","name":"","image":""},{"code":"ser","beta":"1.54","sale_price":"32.65","purchase_price":"14.66","liquids":"1.142","return_rate":"5.46","tipo":1,"aposentadoria":"0","consumo":"0","especular":"1","patrimonio":"0","reserva":"1","name":"","image":""},{"code":"23rfnu","beta":"1.55","sale_price":"32.66","purchase_price":33100,"liquids":"1.148","return_rate":4111,"tipo":1,"aposentadoria":"1","consumo":"1","especular":"1","patrimonio":"0","reserva":"0","name":"","image":""},{"code":"nmer","beta":"1.56","sale_price":"32.67","purchase_price":33100,"liquids":"1.154","return_rate":"5.47","tipo":1,"aposentadoria":"0","consumo":"1","especular":"1","patrimonio":"0","reserva":"0","name":"","image":""},{"code":"r6jxr","beta":"1.57","sale_price":"32.68","purchase_price":"14.67","liquids":"1.160","return_rate":4112,"tipo":1,"aposentadoria":"0","consumo":"1","especular":"1","patrimonio":"1","reserva":"0","name":"","image":""},{"code":"io6d","beta":"1.58","sale_price":"32.69","purchase_price":33101,"liquids":"1.166","return_rate":"5.48","tipo":1,"aposentadoria":"1","consumo":"1","especular":"1","patrimonio":"1","reserva":"0","name":"","image":""},{"code":"sety6","beta":"1.59","sale_price":"32.70","purchase_price":33101,"liquids":"1.172","return_rate":4113,"tipo":1,"aposentadoria":"0","consumo":"0","especular":"1","patrimonio":"0","reserva":"0","name":"","image":""},{"code":"hjujk6","beta":"1.60","sale_price":"32.71","purchase_price":"14.68","liquids":"1.178","return_rate":"5.49","tipo":1,"aposentadoria":"0","consumo":"0","especular":"1","patrimonio":"1","reserva":"0","name":"","image":""},{"code":"xh6","beta":"1.61","sale_price":"32.72","purchase_price":33102,"liquids":"1.184","return_rate":4114,"tipo":1,"aposentadoria":"1","consumo":"1","especular":"1","patrimonio":"0","reserva":"1","name":"","image":""}]');
    }

    var list = List<Titulo>();
    for(var item in dados){
      int objetivos = 0;
      if(item['aposentadoria'] == '1')
        objetivos += 0x000001;
      if(item['consumo'] == '1')
        objetivos += 0x000010;
      if(item['especular'] == '1')
        objetivos += 0x000100;
      if(item['patrimonio'] == '1')
        objetivos += 0x001000;
      if(item['reserva'] == '1')
        objetivos += 0x010000;

      list.add(Titulo(
        code: item['code'],
        beta: toDouble(item['beta']),
        sale_price: toDouble(item['sale_price']),
        purchase_price: toDouble(item['purchase_price']),
        liquids: toDouble(item['liquids']),
        return_rate: toDouble(item['return_rate']),
        objetivos: objetivos,
        name: item['name'].length==0 ? item['code'] : item['name'],
        image: item['image'].length!=0 ? item['image'] : 'https://seuguiadeinvestimentos.com.br/wp-content/uploads/2015/09/Como-investir-em-long-short-de-a%C3%A7%C3%B5es-Seu-Guia-de-Investimentos-1.jpg'//  item['image'],
      ));
    }
    titulosStream.add(list);
  }

  Future<void> getTitulosApi([String url='https://cors-anywhere.herokuapp.com/https://script.google.com/macros/s/AKfycbyjJDaTLP7bbBDlrXdpAr3cazdg5brVlsfuwRAmsQ/exec']) async {
    http.Response result = await http.get(url, headers: {'Origin': 'http://localhost:54393'});
    if(result.statusCode == 302){
      return getTitulosApi(result.headers['location']);
    }
    else if(result.statusCode == 200){
      print(result.body);
      var array = json.decode(result.body);
      insertJson(array);
    }
  }

  favorite(Titulo titulo) {
    titulo.favorite = !(titulo.favorite ?? false);
    for(var i=0; i<titulosStream.value.length; i++){
      if(titulosStream.value[i].code == titulo.code){
        titulosStream.value[i].favorite = titulo.favorite;
      }
    }
  }

  DataFrame titulos2DtaFrame(List<Titulo> titulos){
    print('Convertendo DataFrame');

    var dados = List<List<num>>();
    for(var titulo in titulos){
      dados.add([
        titulo.favorite==true ? 1 : 0,
        titulo.quantity_purchased,
        titulo.return_rate,
        titulo.liquids,
        titulo.beta,
        titulo.purchase_price,
        titulo.sale_price,
        titulo.objetivos,
      ]);
    }

    return DataFrame(dados, headerExists: false);
  }

  void treinarAi() async {
    var titulos = titulosStream.value;
    titulosStream.sink.add(null);

    final splits = splitData(titulos2DtaFrame(titulos), [0.7]);
    final validationData = splits[0];
    final testData = splits[1];
    final validator = CrossValidator.kFold(validationData, numberOfFolds: 4);

    final createClassifier = (DataFrame trailData) =>
        LogisticRegressor(
          trailData,
          'col_0',
          optimizerType: LinearOptimizerType.gradient,
          iterationsLimit: 90,
          learningRateType: LearningRateType.decreasingAdaptive,
          batchSize: trailData.rows.length,
          probabilityThreshold: 0.7,
        );
    
    final scores = await validator.evaluate(createClassifier, MetricType.accuracy);
    final accuracy = scores.mean();

    print('accuracy on k fold validation: ${accuracy.toStringAsFixed(2)}');

    final testSplits = splitData(testData, [0.8]);
    classifier = createClassifier(testSplits[0]);

    print('Calculando final score...');
    final finalScore = classifier.assess(testSplits[1], MetricType.accuracy);

    print('Final Socre: '+finalScore.toStringAsFixed(2));

    print(classifier.toJson());
    
    classificar(titulos);
  }

  void classificar(List<Titulo> titulos) {
    for(var titulo in titulos){
      titulo.classification = classifier.assess(DataFrame(<Iterable<num>>[[
        titulo.favorite==true ? 1 : 0,
        titulo.quantity_purchased,
        titulo.return_rate,
        titulo.liquids,
        titulo.beta,
        titulo.purchase_price,
        titulo.sale_price,
        titulo.objetivos,
      ]], headerExists: false), MetricType.accuracy);
    }

    titulos.sort((a, b){
      return a.classification.compareTo(b.classification);
    });

    titulosStream.sink.add(titulos);
  }

}