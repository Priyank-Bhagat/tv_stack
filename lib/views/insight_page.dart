import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tv_stack/model/tv_model.dart';
import 'package:google_fonts/google_fonts.dart';

class InsightPage extends StatelessWidget {
  InsightPage({Key? key, required this.tvModel}) : super(key: key);
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  final TvModel tvModel;
  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: device.width * 0.2),
            child: Hero(
              tag: 'text_${tvModel.name}',
              child: Material(
                color: Colors.transparent,
                child: Text(tvModel.name,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont('Inter',
                        fontSize: 25, fontWeight: FontWeight.w700)),
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: device.height * 0.4,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                    tag: tvModel.name,
                    child: Image.asset(tvModel.image, fit: BoxFit.fitHeight),
                  ),
                ),
                Positioned(
                  left: device.width * 0.05,
                  bottom: 0,
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 610),
                    tween: Tween(begin: 1.0, end: 0.0),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(-100 * value, 240 * value),
                        child: child,
                      );
                    },
                    child: Text(
                      '₹${myFormat.format(tvModel.price)}',
                      style: GoogleFonts.getFont('Inter',
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                          shadows: [
                            const BoxShadow(
                                color: Colors.black45,
                                blurRadius: 10,
                                spreadRadius: 20)
                          ]),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: device.width * 0.04),
              child: Text(
                'Quisque porttitor, odio non varius blandit, lorem purus lacinia justo, eget rutrum sem nulla sit amet tortor. Maecenas ut odio imperdiet, eleifend ligula euismod, mollis neque. Proin elementum, velit ac fringilla ornare, ante velit imperdiet erat, placerat eleifend tellus sem eu dui. Aliquam erat volutpat. Donec non blandit massa.',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
