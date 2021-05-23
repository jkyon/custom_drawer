import 'package:custom_drawer/src/models/slider_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SliderModel(),
      child: Scaffold(
        body: Center(
            child: Column(
          children: <Widget>[
            Expanded(child: _Slides()),
            _Dots(),
          ],
        )),
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  const _Slides({Key key}) : super(key: key);

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageController = PageController();

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      Provider.of<SliderModel>(context, listen: false).currentPage =
          pageController.page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageController,
        children: [
          _Slide(svgPath: 'lib/src/assets/svgs/slide-1.svg'),
          _Slide(svgPath: 'lib/src/assets/svgs/slide-2.svg'),
          _Slide(svgPath: 'lib/src/assets/svgs/slide-3.svg'),
        ],
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
  const _Dots({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Dot(index: 0),
          _Dot(index: 1),
          _Dot(index: 2),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  const _Dot({
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final pageViewIndex = Provider.of<SliderModel>(context).currentPage;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: 10,
      height: 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: (pageViewIndex >= this.index - 0.5 &&
                  pageViewIndex < this.index + 0.5)
              ? Colors.blue
              : Colors.grey,
          shape: BoxShape.circle),
    );
  }
}

class _Slide extends StatelessWidget {
  final String svgPath;
  _Slide({
    Key key,
    this.svgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(30),
        child: SvgPicture.asset(svgPath));
  }
}
