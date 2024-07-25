import 'package:fl_chart/fl_chart.dart';

abstract class BaseRecorderCubit<T> {
  //T is data recorder model eg. WeightRecorderModel

  void record(T newRecord);

  void clear();
  
  double getScore({List<T>? records});

  List<T> getDailyReport();
  
  List<T> getWeeklyReport();

  List<T> getMontlyReport();

  List<T> getPastReport(DateTime from, DateTime to);
  
  T? getPastReportSingle(DateTime date);


  List<FlSpot> generateChartData(List<T> data);
}