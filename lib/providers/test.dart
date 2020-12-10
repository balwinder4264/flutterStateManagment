import 'package:flutter/foundation.dart';

class Test_Provider with ChangeNotifier {
  var _items = {"id": "20345"};
  get items {
    return {..._items};
  }
}
