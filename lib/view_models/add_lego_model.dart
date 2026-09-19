import 'package:flutter/foundation.dart';
import 'package:legos/models/lego_model.dart';
import 'package:legos/services/lego_service.dart';

class AddLegoViewModel extends ChangeNotifier {
  bool isSaving = false;

  Future<bool> addLego(LegoModel lego) async {
    isSaving = true;
    notifyListeners();

    bool success;
    try {
      await LegoService().createLego(lego);
      success = true;
    } catch (e) {
      success = false;
    }

    isSaving = false;
    notifyListeners();
    return success;
  }
}