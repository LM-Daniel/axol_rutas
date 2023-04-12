// ignore_for_file: non_constant_identifier_names

import 'package:axol_rutas/identities/product/model/product.dart';
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
  final String DESCRIPTION = 'description';
  final String WEIGHT = 'weight';
  final String PRICE = 'price';
  final String QUANTITY = 'quantity';
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
    return inventoryList;
  }
}

class LocalShoppingcart extends ProductRepo {
  Future<List<Map<String, dynamic>>> readShoppingCart() async {
    List<String>? products;
    List<String> picesProduct;
    String product;
    List<Map<String, String>> shoppingCart = [];
    Map<String, String> productMap;

    final pref = await SharedPreferences.getInstance();
    products = pref.getStringList(SHOPPINGCART);
    if (products != null) {
      for (product in products) {
        picesProduct = product.split('/d/');
        productMap = {
          CODE: picesProduct.elementAt(0),
          DESCRIPTION: picesProduct.elementAt(1),
          WEIGHT: picesProduct.elementAt(2),
          QUANTITY: picesProduct.elementAt(3),
          PRICE: picesProduct.elementAt(4)
        };
        shoppingCart.add(productMap);
      }
    }

    return shoppingCart;
  }

  void writeShoppingCart(ProductModel productModel, double quantity,
      double price, double weight) async {
    List<String>? products;
    String newProduct;

    final pref = await SharedPreferences.getInstance();
    products = pref.getStringList(SHOPPINGCART);
    products ??= [];
    newProduct =
        '${productModel.code}/d/${productModel.description}/d/$weight/d/$quantity/d/$price';
    products.add(newProduct);
    pref.setStringList(SHOPPINGCART, products);
  }

  void clearShoppingCart() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(SHOPPINGCART);
  }

  Future<bool> isStartingShoppingCart() async {
    List<String>? verifyList;
    bool isStarting;

    final pref = await SharedPreferences.getInstance();
    verifyList = pref.getStringList(SHOPPINGCART);
    if (verifyList == null) {
      isStarting = true;
    } else {
      isStarting = false;
    }

    return isStarting;
  }
}
