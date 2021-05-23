import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideShow extends StatelessWidget {
  final List<Widget> slides;
  final bool dotsOnTop;
  final Color primaryDotsColor;
  final Color secondaryDotsColor;
  final double primaryBullet;
  final double secondaryBullet;
  const SlideShow(
      {Key key,
      @required this.slides,
      this.dotsOnTop = false,
      this.primaryDotsColor = Colors.blue,
      this.secondaryDotsColor = Colors.grey,
      this.primaryBullet = 10,
      this.secondaryBullet = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SliderModel(),
      child: SafeArea(
        child: Center(child: Builder(builder: (BuildContext context) {
          Provider.of<_SliderModel>(context).primaryColor =
              this.primaryDotsColor;
          Provider.of<_SliderModel>(context).secondayColor =
              this.secondaryDotsColor;
          Provider.of<_SliderModel>(context).secondayBullet =
              this.secondaryBullet;
          Provider.of<_SliderModel>(context).primaryBullet = this.primaryBullet;
          return Column(
            children: <Widget>[
              if (this.dotsOnTop) _Dots(this.slides.length),
              Expanded(
                //TODO: add dimensions to the slides.
                child: _Slides(this.slides),
              ),
              if (!this.dotsOnTop) _Dots(this.slides.length),
            ],
          );
        })),
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;
  const _Slides(this.slides);

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageController = PageController();

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      Provider.of<_SliderModel>(context, listen: false).currentPage =
          pageController.page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageController,
        children: widget.slides.map((slide) => _Slide(slide)).toList(),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

class _Dots extends StatelessWidget {
  final int totalDots;
  const _Dots(this.totalDots);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(this.totalDots, (index) => _Dot(index))),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  const _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    final ssModel = Provider.of<_SliderModel>(context);

    var isPrimary = (ssModel.currentPage >= this.index - 0.5 &&
        ssModel.currentPage < this.index + 0.5);

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: isPrimary ? ssModel.primaryBullet : ssModel.secondayBullet,
      height: isPrimary ? ssModel.primaryBullet : ssModel.secondayBullet,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: isPrimary ? ssModel.primaryColor : ssModel.secondayColor,
          shape: BoxShape.circle),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;
  _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(30),
        child: this.slide);
  }
}

class _SliderModel with ChangeNotifier {
  double _currentPage = 0;
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.grey;
  double _primaryBullet = 10;
  double _secondaryBullet = 10;

  double get currentPage => this._currentPage;

  set currentPage(double value) {
    this._currentPage = value;
    notifyListeners();
  }

  Color get primaryColor => this._primaryColor;

  set primaryColor(Color value) {
    this._primaryColor = value;
  }

  Color get secondayColor => this._secondaryColor;

  set secondayColor(Color value) {
    this._secondaryColor = value;
  }

  double get primaryBullet => this._primaryBullet;

  set primaryBullet(double value) {
    this._primaryBullet = value;
  }

  double get secondayBullet => this._secondaryBullet;

  set secondayBullet(double value) {
    this._secondaryBullet = value;
  }
}
