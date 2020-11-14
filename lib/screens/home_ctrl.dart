import 'package:get/get.dart';
import 'package:invest_flix/models/titulo_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeCtrl {
  BehaviorSubject<List<Titulo>> titulosStream;

  get titulos {
    if(titulosStream?.isClosed ?? true){
      titulosStream = BehaviorSubject(onCancel: ()=>titulosStream.close());
//      getTitulosApi();
      insertJson(null);
    }
    return titulosStream.stream;
  }

  void insertJson(dynamic dados){
    if(dados == null){
      dados = json.decode('[{"code":"abc","beta":"1.47","sale_price":"32.45","purchase_price":"33.87","liquids":"33.88","return_rate":"4.96","name":"","image":""},{"code":"asd","beta":"1.42","sale_price":"12.67","purchase_price":"14.54","liquids":"14.55","return_rate":"5.32","name":"","image":""},{"code":"ewt","beta":"1.37","sale_price":"32.46","purchase_price":"33.88","liquids":"1.20","return_rate":"4.97","name":"","image":""},{"code":"hhh","beta":"1.32","sale_price":"12.68","purchase_price":"14.55","liquids":"1.14","return_rate":"5.33","name":"","image":""},{"code":"ert","beta":"1.27","sale_price":"32.47","purchase_price":"33.89","liquids":"1.08","return_rate":"4.98","name":"","image":""},{"code":"vbc","beta":"1.22","sale_price":"12.69","purchase_price":"14.56","liquids":"1.02","return_rate":"5.34","name":"","image":""},{"code":"sehb","beta":"1.17","sale_price":"32.48","purchase_price":"33.90","liquids":"1.04","return_rate":"4.99","name":"","image":""},{"code":"ghd","beta":"1.12","sale_price":"12.70","purchase_price":"14.57","liquids":"1.10","return_rate":"5.35","name":"","image":""},{"code":"sdfw","beta":"1.07","sale_price":"32.49","purchase_price":"33.91","liquids":"1.16","return_rate":"4.100","name":"","image":""},{"code":"xcbe","beta":"1.02","sale_price":"12.71","purchase_price":"14.58","liquids":"1.22","return_rate":"5.36","name":"","image":""},{"code":"sne","beta":"1.03","sale_price":"32.50","purchase_price":"33.92","liquids":"1.28","return_rate":"4.101","name":"","image":""},{"code":"w4tg","beta":"1.08","sale_price":"12.72","purchase_price":"14.59","liquids":"1.34","return_rate":"5.37","name":"","image":""},{"code":"dgsr","beta":"1.13","sale_price":"32.51","purchase_price":"33.93","liquids":"1.40","return_rate":"4.102","name":"","image":""},{"code":"xfg4","beta":"1.18","sale_price":"12.73","purchase_price":"14.60","liquids":"1.46","return_rate":"5.38","name":"","image":""},{"code":"aw1","beta":"1.23","sale_price":"32.52","purchase_price":"33.94","liquids":"1.52","return_rate":"4.103","name":"","image":""},{"code":"k86g","beta":"1.28","sale_price":"12.74","purchase_price":"14.61","liquids":"1.58","return_rate":"5.39","name":"","image":""},{"code":"xxvb","beta":"1.33","sale_price":"32.53","purchase_price":"33.95","liquids":"1.64","return_rate":"4.104","name":"","image":""},{"code":"hbt","beta":"1.38","sale_price":"12.75","purchase_price":"14.62","liquids":"1.70","return_rate":"5.40","name":"","image":""},{"code":"uie4","beta":"1.43","sale_price":"32.54","purchase_price":"33.96","liquids":"1.76","return_rate":"4.105","name":"","image":""},{"code":"dh","beta":"1.44","sale_price":"32.55","purchase_price":"33.96","liquids":"1.82","return_rate":"5.41","name":"","image":""},{"code":"as4","beta":"1.45","sale_price":"32.56","purchase_price":"14.63","liquids":"1.88","return_rate":"4.106","name":"","image":""},{"code":"uog","beta":"1.46","sale_price":"32.57","purchase_price":"33.97","liquids":"1.94","return_rate":"5.42","name":"","image":""},{"code":"q3w5","beta":"1.47","sale_price":"32.58","purchase_price":"33.97","liquids":"1.100","return_rate":"4.107","name":"","image":""},{"code":"cvbdrr","beta":"1.48","sale_price":"32.59","purchase_price":"14.64","liquids":"1.106","return_rate":"5.43","name":"","image":""},{"code":"w4tg","beta":"1.49","sale_price":"32.60","purchase_price":"33.98","liquids":"1.112","return_rate":"4.108","name":"","image":""},{"code":"qw46","beta":"1.50","sale_price":"32.61","purchase_price":"33.98","liquids":"1.118","return_rate":"5.44","name":"","image":""},{"code":"iltgx","beta":"1.51","sale_price":"32.62","purchase_price":"14.65","liquids":"1.124","return_rate":"4.109","name":"","image":""},{"code":"zxd4","beta":"1.52","sale_price":"32.63","purchase_price":"33.99","liquids":"1.130","return_rate":"5.45","name":"","image":""},{"code":"ni8e","beta":"1.53","sale_price":"32.64","purchase_price":"33.99","liquids":"1.136","return_rate":"4.110","name":"","image":""},{"code":"ser","beta":"1.54","sale_price":"32.65","purchase_price":"14.66","liquids":"1.142","return_rate":"5.46","name":"","image":""},{"code":"23rfnu","beta":"1.55","sale_price":"32.66","purchase_price":"33.100","liquids":"1.148","return_rate":"4.111","name":"","image":""},{"code":"nmer","beta":"1.56","sale_price":"32.67","purchase_price":"33.100","liquids":"1.154","return_rate":"5.47","name":"","image":""},{"code":"r6jxr","beta":"1.57","sale_price":"32.68","purchase_price":"14.67","liquids":"1.160","return_rate":"4.112","name":"","image":""},{"code":"io6d","beta":"1.58","sale_price":"32.69","purchase_price":"33.101","liquids":"1.166","return_rate":"5.48","name":"","image":""},{"code":"sety6","beta":"1.59","sale_price":"32.70","purchase_price":"33.101","liquids":"1.172","return_rate":"4.113","name":"","image":""},{"code":"hjujk6","beta":"1.60","sale_price":"32.71","purchase_price":"14.68","liquids":"1.178","return_rate":"5.49","name":"","image":""},{"code":"xh6","beta":"1.61","sale_price":"32.72","purchase_price":"33.102","liquids":"1.184","return_rate":"4.114","name":"","image":""}]');
    }

    var list = List<Titulo>();
    for(var item in dados){
      list.add(Titulo(
        code: item['code'],
        beta: double.parse(item['beta']),
        sale_price: double.parse(item['sale_price']),
        purchase_price: double.parse(item['purchase_price']),
        liquids: double.parse(item['liquids']),
        return_rate: double.parse(item['return_rate']),
        name: item['name'].length==0 ? item['code'] : item['name'],
        image: 'https://seuguiadeinvestimentos.com.br/wp-content/uploads/2015/09/Como-investir-em-long-short-de-a%C3%A7%C3%B5es-Seu-Guia-de-Investimentos-1.jpg'//  item['image'],
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
}