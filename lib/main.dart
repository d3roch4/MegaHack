import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invest_flix/screens/home_screen.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'contantes.dart';

import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_preprocessing/ml_preprocessing.dart';

void main() async {
  return runApp(MyApp());
}

Future<void> classificar() async {
  final targetColumnName = 'col_8';
  final splits = splitData(dados, [0.7]);
  final validationData = splits[0];
  final testData = splits[1];
  final validator = CrossValidator.kFold(validationData, numberOfFolds: 5);
  final createClassifier = (DataFrame trailData) =>
      LogisticRegressor(
        trailData,
        targetColumnName,
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
  final classifier = createClassifier(testSplits[0]);

  print('Calculando final score...');
  final finalScore = classifier.assess(testSplits[1], MetricType.accuracy);

  print('Final Socre: '+finalScore.toStringAsFixed(2));

  print(classifier.toJson());
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
        primarySwatch: Colors.red,
        buttonTheme: buttonTheme,
    );
    return GetMaterialApp(
      theme: temaClaro,
      title: 'InvesFlix',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
