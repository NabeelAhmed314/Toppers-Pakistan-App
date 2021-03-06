import 'package:flutter/material.dart';
import 'package:toppers_pakistan/cart/selectDeliveryAddress.dart';
import 'package:toppers_pakistan/cart_list.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  TextEditingController instructionController = new TextEditingController();

  void selectDelivery() {
    CartList.instruction = instructionController.text;
    CartList.totalPrice = calcTotal();

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SelectDeliveryAddress()));
  }

  int calcTotal() {
    int total = 0;
    for (var orderItem in CartList.orderItems) {
      total += orderItem.quantity * int.parse(orderItem.unitPrice);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("CART"),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              height: 50,
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
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "QTY",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        "PRICE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                return Dismissible(
                  onDismissed: (direction) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content:
                            Text("${CartList.orderItems[i].name} Dissmised")));
                    setState(() {
                      CartList.orderItems.removeAt(i);
                      if(CartList.orderItems.length == 0 ){
                        Navigator.pop(context);
                      }
                    });
                  },
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[Icon(Icons.delete), Text("Delete")],
                      ),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: ListTile(
                                subtitle: Text(
                                  "(" +
                                      CartList.orderItems[i].weight +
                                      " " +
                                      CartList.orderItems[i].unit +
                                      " " +
                                      CartList.orderItems[i].unitPrice +
                                      ")",
                                ),
                                title: Text(
                                  CartList.orderItems[i].name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                    icon:
                                        Icon(Icons.remove, color: Colors.black),
                                    onPressed: () {
                                      if (CartList.orderItems[i].quantity > 0) {
                                        setState(() {
                                          CartList.orderItems[i].quantity--;
                                        });
                                      }
                                    }),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  child: Text(CartList.orderItems[i].quantity
                                      .toString()),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add, color: Colors.black),
                                  onPressed: () {
                                    setState(() {
                                      CartList.orderItems[i].quantity++;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(30, 5, 5, 5),
                              child: Text(
                                  (int.parse(CartList.orderItems[i].unitPrice) *
                                          CartList.orderItems[i].quantity)
                                      .toString(),
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 0,
                      )
                    ],
                  ),
                );
              },
              childCount: CartList.orderItems.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Total",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  trailing: Text(
                    calcTotal().toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Container(
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextField(
                      controller: instructionController,
                      decoration: InputDecoration(
                        hintText: "Addtional Instructions",
                        border: InputBorder.none,
                      ),
                      maxLines: 5,
                    ),
                  ),
                ),
                Divider(
                  height: 5,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 15,
                    child: RaisedButton(
                      color: Color(0xffcdaa44),
                      onPressed: selectDelivery,
                      child: Text(
                        "Select Delivery Address",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
