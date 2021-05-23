import 'package:custom_drawer/src/widgets/slide_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SlideShowPage extends StatelessWidget {
  const SlideShowPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlideShowTop(),
    );
  }

  Widget SlideShowTop() {
    return Center(
      child: SlideShow(
        primaryBullet: 12,
        dotsOnTop: false,
        secondaryDotsColor: Colors.green[100],
        primaryDotsColor: Colors.purple,
        slides: [
          SvgPicture.asset('lib/src/assets/svgs/slide-1.svg'),
          SvgPicture.asset('lib/src/assets/svgs/slide-2.svg'),
          SvgPicture.asset('lib/src/assets/svgs/slide-3.svg'),
          SvgPicture.asset('lib/src/assets/svgs/slide-4.svg'),
          SvgPicture.asset('lib/src/assets/svgs/slide-5.svg')
        ],
      ),
    );
  }
}
