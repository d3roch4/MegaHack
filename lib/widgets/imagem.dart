import 'package:flutter/material.dart';

ImageProvider getImagem(String url){
  return url.startsWith('http') ?
  NetworkImage(url) :
  AssetImage(url);
}