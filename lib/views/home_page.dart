import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tv_stack/model/tv_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tv_stack/views/insight_page.dart';

const duration = Duration(milliseconds: 300);
const _initialPage = 8.0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  final _pageController =
      PageController(viewportFraction: 0.35, initialPage: _initialPage.toInt());
  final _pageTextController = PageController(initialPage: _initialPage.toInt());

  double _currentPage = _initialPage;
  double _textPage = _initialPage;

  void _tvsScrollerListener() {
    setState(() {
      _currentPage = _pageController.page!;
    });
  }

  void _textScrollerListener() {
    setState(() {
      _textPage = _pageTextController.page!;
    });
  }

  @override
  void initState() {
    _pageController.addListener((_tvsScrollerListener));
    _pageTextController.addListener((_textScrollerListener));
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener((_tvsScrollerListener));
    _pageTextController.removeListener((_textScrollerListener));
    _pageController.dispose();
    _pageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            left: 22,
            right: 20,
            bottom: -size.height * 0.3,
            top: size.height * 0.3,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.teal, blurRadius: 90, spreadRadius: 45)
                ],
              ),
            ),
          ),
          Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemCount: names.length,
              onPageChanged: (value) {
                if (value < tvs.length) {
                  _pageTextController.animateToPage(value,
                      duration: duration, curve: Curves.easeOut);
                }
              },
              itemBuilder: (context, index) {
                if (index == 0) return const SizedBox.shrink();

                final tVs = tvs[index - 1];
                final result = _currentPage - index + 1;
                final value = -0.4 * result + 1;
                final opacity = value.clamp(0.0, 1.0);
                // print(result);

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 650),
                        pageBuilder: (_, animation, __) => FadeTransition(
                          opacity: animation,
                          child: InsightPage(
                            tvModel: tVs,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..translate(
                              0.0, size.height / 2.6 * (1 - value).abs())
                          ..scale(value),
                        child: Opacity(
                            opacity: opacity,
                            child: Hero(
                                tag: tVs.name,
                                child: Image.asset(
                                  tVs.image,
                                  fit: BoxFit.fitHeight,
                                )))),
                  ),
                );
              },
            ),
          ),
          Positioned(
              left: 0,
              top: 0,
              right: 0,
              height: 100,
              child: TweenAnimationBuilder<double>(
                duration: duration,
                tween: Tween(begin: 1.0, end: 0.0),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0.0, -100 * value),
                    child: child,
                  );
                },
                child: Column(
                  children: [
                    Expanded(
                        child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageTextController,
                      itemCount: names.length,
                      itemBuilder: (context, index) {
                        final opacity =
                            (1 - (index - _textPage).abs()).clamp(0.0, 1.0);
                        return Opacity(
                          opacity: opacity,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.2),
                            child: Hero(
                              tag: 'text_${tvs[index].name}',
                              child: Material(
                                color: Colors.transparent,
                                child: Text(tvs[index].name,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.getFont('Inter',
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                    AnimatedSwitcher(
                        key: Key(tvs[_currentPage.toInt()].name),
                        duration: duration,
                        child: Text(
                          '₹${myFormat.format(tvs[_currentPage.toInt()].price)}',
                          style: GoogleFonts.getFont('Inter',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.green),
                        ))
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
