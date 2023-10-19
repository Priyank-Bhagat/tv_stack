
import 'dart:math';

double _doubleInRange(Random source, num start, num end) => source.nextDouble() * (end - start) + start;
final random = Random();


final tvs = List.generate(_names.length, (index)
=> TvModel(
    name: _names[index],
    image: 'Assets/coffee/${index + 1}.png',
    price: _doubleInRange(random, 3, 7)
)
);

class TvModel{
  final String name;
  final String image;
  final double price;


  TvModel({required this.name,required this.image, required this.price});
}



final _names = [
  'Samsung S90C',
  ' TCL QM8 Class',
  'Samsung QN95C',
  'Samsung S95C',
  'Sony X90K',
  'LG G2',
  'LG C3 OLED',
  'Sony A80K OLED Series',
  'Hisense U8H',
  'LG B2',
  'TCL 6-Series Roku TV ',
];