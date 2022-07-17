import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();

  static Future setPassword({required String value}) async {
    await getStorage.write("setPassword", value);
  }

  static getPassword() {
    return getStorage.read("setPassword");
  }

  static Future setPassOn({required bool value}) async {
    await getStorage.write("setPassOn", value);
  }

  static getPassON() {
    return getStorage.read("setPassOn");
  }

  static Future setGrid({required int value}) async {
    await getStorage.write("setGrid", value);
  }

  static getGrid() {
    return getStorage.read("setGrid");
  }

  static allClearPreferenceManager() {
    return getStorage.erase();
  }

  /// photo
  static Future setLikePhoto({required List value}) async {
    await getStorage.write("setLikePhoto", value);
  }

  static getLikePhoto() {
    return getStorage.read("setLikePhoto");
  }
}
