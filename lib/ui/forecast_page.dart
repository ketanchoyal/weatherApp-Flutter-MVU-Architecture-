import 'package:flutter/material.dart';
import '../io/darksky.dart' as darksky;
import 'package:weather_app/model/forecast_model.dart';

class ForecastPage extends StatefulWidget {
  ForecastPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  ForecastModel model = ForecastModel(0, false);

  void updateModel(double forecast, bool loading) => setState(() {
        model = ForecastModel(forecast, loading);
      });

  void _updateTemperature(Future<double> getForecast()) async {
    updateModel(0, true);

    var forecast = await getForecast();

    updateModel(forecast, false);
  }

  @override
  Widget build(BuildContext context) {
    return ForecastPageUI.buildUI(
        context,
        widget.title,
        () => _updateTemperature(
            darksky.getForecastData),
        model);
  }
}

class ForecastPageUI {
  static buildUI(BuildContext context, String title, Function update, ForecastModel model) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: model.loading
              ? (<Widget>[CircularProgressIndicator()])
              : (<Widget>[
                  Text(
                    'The current temperature is:',
                  ),
                  Text(
                    '${model.temperature} °F',
                    style: Theme.of(context).textTheme.display1,
                  ),
                ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: update,
        tooltip: 'Update',
        child: Icon(Icons.update),
      ),
    );
  }
}
