import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SliderModel with ChangeNotifier {
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
    notifyListeners();
  }

  Color get secondayColor => this._secondaryColor;

  set secondayColor(Color value) {
    this._secondaryColor = value;
    notifyListeners();
  }

  double get primaryBullet => this._primaryBullet;

  set primaryBullet(double value) {
    this._primaryBullet = value;
    notifyListeners();
  }

  double get secondayBullet => this._secondaryBullet;

  set secondayBullet(double value) {
    this._secondaryBullet = value;
    notifyListeners();
  }
}
