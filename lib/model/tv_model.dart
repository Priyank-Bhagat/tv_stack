import 'dart:math';

double _doubleInRange(Random source, num start, num end) =>
    source.nextDouble() * (end - start) + start;
final random = Random();

final tvs = List.generate(
    _names.length,
    (index) => TvModel(
        name: _names[index],
        image: 'Assets/tvs/${index + 1}.png',
        price: _prices[index]));

class TvModel {
  final String name;
  final String image;
  final double price;

  TvModel({required this.name, required this.image, required this.price});
}

final _names = [
  'Samsung S90C',
  'TCL QM8 Class',
  'Samsung QN95C',
  'Samsung S95C',
  'Sony X90K',
  'LG G2',
  'LG C3 OLED',
  'Sony A80K OLED Series',
  'Hisense U8H',
  'LG B2',
  'TCL 6-Series Roku TV',
];

get names => _names;

final _prices = [
  149990.00,
  818999.00,
  252490.00,
  179990.00,
  379900.00,
  399990.00,
  814990.00,
  699900.00,
  88353.00,
  112990.00,
  219526.00,
];
