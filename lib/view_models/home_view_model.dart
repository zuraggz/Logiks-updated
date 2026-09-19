import 'package:flutter/material.dart';
import 'package:legos/models/lego_model.dart';
import 'package:legos/services/lego_service.dart';

class HomeViewModel extends ChangeNotifier{
  bool isLoading = false;
  bool hasError = false;

  List<LegoModel> allLegosList = [];

  Future<void> fetchAllLegos() async {
    isLoading = true;
    hasError = false;
    notifyListeners();

    try {
      allLegosList = await LegoService().fetchAll();
    } catch (e) {
      hasError = true;
    }

    isLoading = false;
    notifyListeners();
}
}