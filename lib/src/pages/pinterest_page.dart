import 'package:custom_drawer/src/widgets/pinterest_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class PinterestPage extends StatelessWidget {
  const PinterestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: Scaffold(
        //body: PinterestMenu(),
        body: Stack(
          children: [PinterestGrid(), _PitenterestMenuPositioned()],
        ),
      ),
    );
  }
}

class _PitenterestMenuPositioned extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final show = Provider.of<_MenuModel>(context).show;
    return Positioned(
        bottom: 30,
        child: Container(
          width: screenWidth,
          child: Align(
            child: PinterestMenu(
              show: show,
            ),
          ),
        ));
  }
}

class PinterestGrid extends StatefulWidget {
  PinterestGrid({Key key}) : super(key: key);

  @override
  _PinterestGridState createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  final List items = List.generate(200, (index) => index);

  ScrollController controller = ScrollController();
  double scrollBefore = 0;

  @override
  void initState() {
    this.controller
      ..addListener(() {
        if (controller.offset > scrollBefore) {
          Provider.of<_MenuModel>(context, listen: false).show = false;
        } else {
          Provider.of<_MenuModel>(context, listen: false).show = true;
        }

        scrollBefore = controller.offset;
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      controller: this.controller,
      crossAxisCount: 4,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => _PinterestItem(
        index: index,
      ),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 3),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }
}

class _PinterestItem extends StatelessWidget {
  final int index;
  const _PinterestItem({
    this.index,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: new Center(
          child: new CircleAvatar(
            backgroundColor: Colors.white,
            child: new Text('$index'),
          ),
        ));
  }
}

class _MenuModel with ChangeNotifier {
  bool _show = true;

  bool get show => this._show;

  set show(bool value) {
    this._show = value;
    notifyListeners();
  }
}
