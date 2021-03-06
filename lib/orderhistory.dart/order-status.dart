import 'package:flutter/material.dart';
import 'package:toppers_pakistan/models/order-item_model.dart';
import 'package:toppers_pakistan/models/order_model.dart';
import 'package:toppers_pakistan/models/product_model.dart';
import 'package:toppers_pakistan/orderhistory.dart/reorder.dart';
import 'package:date_format/date_format.dart';
import 'package:toppers_pakistan/services/order-item_service.dart';
import 'package:toppers_pakistan/services/product_service.dart';
import 'package:toppers_pakistan/simple-future-builder.dart';

class OrderStatus extends StatefulWidget {
  final OrderModel orderModel;

  OrderStatus({this.orderModel});

  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus>
    with TickerProviderStateMixin {
  TabController _tabController;

  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Status"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 10)),
          new Container(
            decoration: new BoxDecoration(
              color: Color(0xffbc282b),
            ),
            child: new TabBar(
              indicator: BoxDecoration(
                color: Color(0xffCE862A),
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              indicatorColor: Colors.pink,
              controller: _tabController,
              tabs: [
                new Tab(
                  child: Text(
                    'Shopping Cart',
                    // textScaleFactor: 1.2,
                  ),
                ),
                new Tab(
                  child: Text(
                    'Order Completed',
                    // textScaleFactor: 1.2,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Order1(orderModel: widget.orderModel),
                Status(orderModel: widget.orderModel),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Order1 extends StatefulWidget {
  final OrderModel orderModel;

  Order1({this.orderModel});
  @override
  _Order1State createState() => _Order1State();
}

class _Order1State extends State<Order1> {
  _parseDate(DateTime date) {
    return formatDate(date, [d, '-', MM, '-', yyyy, '|', HH, ':', nn, am])
        .toString();
  }

  int deliveryCharges = 80;
  int taxCharges = 0;
  int subTotal;
  int totalPrice;

  List<OrderItemModel> orderItems;

  final _service = OrderItemService();
  final _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Text(
                      "ORDER ID # " + widget.orderModel.id.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      "Good",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Text(
                      "Payment Status",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )),
                Expanded(
                  flex: 1,
                  child: Text(
                    widget.orderModel.status,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 30,
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Timing",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                _parseDate(DateTime.parse(
                                    widget.orderModel.timeCreated)),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 35,
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              flex: 2,
                              child: Text(
                                "ITEMS",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                "QTY",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
                          Expanded(
                              flex: 0,
                              child: Text(
                                "PRICE",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 270,
                    child: SimpleFutureBuilder.simpler(
                      future: _service
                          .fetchAllOrderItemsByOrder(widget.orderModel.id),
                      context: context,
                      builder: (AsyncSnapshot<List<OrderItemModel>> snapshot) {
                        orderItems = snapshot.data;
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return SimpleFutureBuilder.simpler(
                                future: _productService.fetchAllProductsByItem(
                                    snapshot.data[i].id),
                                context: context,
                                builder:
                                    (AsyncSnapshot<ProductModel> snapshot1) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 0, 5),
                                          child: Text(
                                            snapshot1.data.name,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Text(snapshot.data[i].quantity
                                              .toString())),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 5, 5),
                                          child: Text(
                                              (snapshot.data[i].quantity *
                                                      int.parse(snapshot1
                                                          .data.unitPrice))
                                                  .toString(),
                                              style: TextStyle(fontSize: 16)),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                        );
                      },
                    ),
                  ),
                  Divider(
                    color: Colors.black45,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(80, 20, 8, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Sub Total",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        Text(
                            (widget.orderModel.totatlPrice -
                                    deliveryCharges -
                                    taxCharges)
                                .toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black45,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(80, 20, 8, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Tax",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        Text(taxCharges.toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black45,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(80, 20, 8, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Delivery Charges",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        Text(deliveryCharges.toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black45,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(80, 20, 8, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        Text(widget.orderModel.totatlPrice.toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height / 22,
              child: RaisedButton(
                color: Color(0xffCE862A),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReOrder(
                              order: widget.orderModel,
                              orderItems: orderItems)));
                },
                child: Text("Re-Order",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Status extends StatefulWidget {
  final OrderModel orderModel;

  Status({this.orderModel});
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  _parseDate(DateTime date) {
    return formatDate(date, [d, '-', MM, '-', yyyy, '|', HH, ':', nn, am])
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      children: <Widget>[
        ListTile(
          leading: Text(
            "Where is my Order?",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(
          height: 0,
          color: Colors.black45,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
          child: Row(
            children: <Widget>[
              Text(
                "Order Placed",
                style: TextStyle(fontSize: 16),
              ),
              widget.orderModel.status == "Placed"
                  ? Icon(Icons.check)
                  : Text(''),
              // }
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Divider(
            color: Colors.black45,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
          child: Row(
            children: <Widget>[
              Text(
                "Order Pending",
                style: TextStyle(fontSize: 16),
              ),
              widget.orderModel.status == "Pending"
                  ? Icon(Icons.check)
                  : Text(''),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Divider(
            color: Colors.black45,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
          child: Row(
            children: <Widget>[
              Text(
                "Order Rejected",
                style: TextStyle(fontSize: 16),
              ),
              widget.orderModel.status == "Rejected"
                  ? Icon(Icons.check)
                  : Text(''),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Divider(
            color: Colors.black45,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
          child: Row(
            children: <Widget>[
              Text(
                "Order Delivered",
                style: TextStyle(fontSize: 16),
              ),
              widget.orderModel.status == "Complete"
                  ? Icon(Icons.check)
                  : Text(''),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Divider(
            color: Colors.black45,
          ),
        ),
      ],
    );
  }
}
