import 'dart:convert';

import 'package:toppers_pakistan/models/local-data.dart';
import 'package:toppers_pakistan/models/order_model.dart';
import 'package:toppers_pakistan/services/_services.dart';
import 'package:http/http.dart' as http;

class OrderService extends Service<OrderModel> {
  @override
  OrderModel parse(Map<String, dynamic> json) {
    return OrderModel.fromJson(json);
  }

  Future<List<OrderModel>> fetchAllOrderByCustomerId() async {
    var response = await http.get(
        Uri.encodeFull(
            "$apiUrl/customer-order/" + LocalData.currentCustomer.id.toString()),
        headers: {"Accept": "application/json"});
    var data = jsonDecode(response.body) as List;
    return data.map((item) => parse(item)).toList();
  }

  String get route => "order";
}
