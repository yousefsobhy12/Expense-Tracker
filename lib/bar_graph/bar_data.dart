import 'package:expense_tracker/bar_graph/individual_bar.dart';

class BarData {
  final double satAmount;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;

  BarData({
    required this.satAmount,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
  });

  List<IndividualBar> dataBar = [];

  void initializeDataBar() {
    dataBar = [
      // Sat
      IndividualBar(x: 0, y: satAmount),
      // Sun
      IndividualBar(x: 1, y: sunAmount),
      // Mon
      IndividualBar(x: 2, y: monAmount),
      // Tue
      IndividualBar(x: 3, y: tueAmount),
      // Wed
      IndividualBar(x: 4, y: wedAmount),
      // Thu
      IndividualBar(x: 5, y: thurAmount),
      // Fri
      IndividualBar(x: 6, y: friAmount),
    ];
  }
}
