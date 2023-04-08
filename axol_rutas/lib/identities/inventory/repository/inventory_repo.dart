// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProductRepo {
  final String TABLE = 'inventory';
  final String STOCK = 'stock';
  final String MANAGER = 'retail_manager';
  final String USER = 'user_name';
  final String CODE = 'code';
  final String NAME = 'name';
  final String SHOPPINGCART = 'shoppingcart';
}

class DatabaseInventory extends ProductRepo {
  final supabase = Supabase.instance.client;

  Future<Map<String, String>> readInventoryProducts() async {
    Map<String, String> productsMap = {};
    Map<String, dynamic> element;
    final List inventoryList = await readInventory();

    if (inventoryList.isNotEmpty) {
      for (element in inventoryList) {
        productsMap[element[CODE].toString()] = element[STOCK].toString();
      }
    } else {}
    return productsMap;
  }

  Future<Map<String, dynamic>> readInventoryDetails() async {
    Map<String, dynamic> inventoryDetails;
    final List inventoryList = await readInventory();

    if (inventoryList.isNotEmpty) {
      inventoryDetails = {
        NAME: inventoryList.first[NAME],
        MANAGER: inventoryList.first[MANAGER],
      };
    } else {
      inventoryDetails = {};
    }
    return inventoryDetails;
  }

  Future<List<String>> readInventoryCodes() async {
    List<String> codes = [];
    Map<String, dynamic> element;
    final List inventoryList = await readInventory();

    if (inventoryList.isNotEmpty) {
      for (element in inventoryList) {
        codes.add(element[CODE].toString());
      }
    }
    return codes;
  }

  Future<List> readInventory() async {
    List<Map<String, dynamic>> productsList = [];
    final String userName;
    List inventoryList = [];

    final pref = await SharedPreferences.getInstance();
    userName = pref.getString(USER)!;
    inventoryList = await supabase
        .from(TABLE)
        .select<List<Map<String, dynamic>>>()
        .eq(NAME, userName);
        //.like(CODE, '%50%');
    return inventoryList;
  }
}

class LocalShoppingcart extends ProductRepo {
  Future<List> readShoppingCart() async {
    List<String> listProducts;
    List<Map<String, String>> shoppingCart = [];

    final pref = await SharedPreferences.getInstance();
    listProducts = pref.getStringList(SHOPPINGCART)!;
    //separar lista de string para hacer lista de maps.

    return shoppingCart;
  }

  void writeShoppingCart() async {}
}
