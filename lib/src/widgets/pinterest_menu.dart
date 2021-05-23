import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestMenuButton {
  final Function onPressed;
  final IconData icon;

  PinterestMenuButton({@required this.onPressed, @required this.icon});
}

class PinterestMenu extends StatelessWidget {
  final List<PinterestMenuButton> items = [
    PinterestMenuButton(
        icon: Icons.pie_chart,
        onPressed: () {
          print('Icon pie_chart');
        }),
    PinterestMenuButton(
        icon: Icons.search,
        onPressed: () {
          print('Icon search');
        }),
    PinterestMenuButton(
        icon: Icons.notifications,
        onPressed: () {
          print('Icon notifications');
        }),
    PinterestMenuButton(
        icon: Icons.supervised_user_circle,
        onPressed: () {
          print('Icon supervised_user_circle');
        })
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: _PinterestMenuBackground(_MenuItems(this.items)),
    );
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  final Widget child;
  _PinterestMenuBackground(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: this.child,
      width: 250,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(100)),
          boxShadow: [
            BoxShadow(
              color: Colors.black38, 
              blurRadius: 10, 
              spreadRadius: -5
            )
          ]),
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<PinterestMenuButton> items;
  _MenuItems(this.items);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(items.length,
          (index) => _PinterestMenuButton(
            button: items[index], 
            index: index
          )
      ),
    );
  }
}

class _PinterestMenuButton extends StatelessWidget {
  final PinterestMenuButton button;
  final int index;
  _PinterestMenuButton({
    @required this.button,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final itemSelected = Provider.of<_MenuModel>(context).selectedIndex;
    return GestureDetector(
      onTap: () {
        Provider.of<_MenuModel>(context, listen: false).selectedIndex =
            this.index;
        this.button.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Icon(
          button.icon,
          size: itemSelected == this.index ? 35 : 25,
          color:
              itemSelected == this.index ? Colors.redAccent : Colors.blueGrey,
        ),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => this._selectedIndex;

  set selectedIndex(int value) {
    this._selectedIndex = value;
    notifyListeners();
  }
}
