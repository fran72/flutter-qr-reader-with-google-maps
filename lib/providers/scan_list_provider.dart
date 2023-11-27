import 'package:flutter/material.dart';
import 'package:flutter_app_cap9/models/models.dart';
import 'package:flutter_app_cap9/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = 'http';

  Future<ScanModel> newScan(String value) async {
    final newScan = ScanModel(value: value);

    final id = await DBProvider.db.newScan(newScan);

    newScan.id = id;

    if (selectedType == newScan.type) {
      scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  loadAllScans() async {
    final scans = await DBProvider.db.getAllScans();
    if (scans != null) this.scans = [...scans];
    notifyListeners();
  }

  loadScansByType(String type) async {
    final scans = await DBProvider.db.getScansByType(type);
    if (scans != null) this.scans = [...scans];
    notifyListeners();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScanById(id);
    // another option is to call loadScanByType again...
    // ...this.loadScanByType( this.selectedType );
    final scanToDelete = scans.firstWhere((element) => element.id == id);
    scans.remove(scanToDelete);

    notifyListeners();
  }
}
