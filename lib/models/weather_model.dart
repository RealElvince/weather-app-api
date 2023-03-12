class WeatherModel {
  final String name;
  var main;
  var wind;
  var weather;

  WeatherModel(
      {required this.name,
      required this.main,
      required this.weather,
      required this.wind});

  // getting data
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        name: json['name'],
        main: json['main'],
        weather: json['weather'],
        wind: json['wind']);
  }
}
