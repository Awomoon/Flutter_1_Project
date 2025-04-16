import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_store/widgets/modals/products_model.dart';

class CartScreen extends StatefulWidget {
  final List<ProductModel> cartItems;
  final Function(int) onRemoveItem;
  final Function(int, int) onUpdateQuantity;

  const CartScreen({
    super.key,
    required this.cartItems,
    required this.onRemoveItem,
    required this.onUpdateQuantity,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double calculateTotalPrice() {
    return widget.cartItems.fold(0, (total, product) {
      return total + (product.price * (product.quantity));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: widget.cartItems.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Your cart is empty!',
                            style: GoogleFonts.lexend(fontSize: 18),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: widget.cartItems.length,
                      itemBuilder: (context, index) {
                        final product = widget.cartItems[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: ListTile(
                            leading: Image.network(
                              product.image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              product.title,
                              style: GoogleFonts.lexend(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\$${(product.price * (product.quantity)).toStringAsFixed(2)}',
                                  style: GoogleFonts.lexend(),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        setState(() {
                                          if ((product.quantity) > 1) {
                                            widget.onUpdateQuantity(
                                              index,
                                              (product.quantity) - 1,
                                            );
                                          }
                                        });
                                      },
                                    ),
                                    Text(
                                      '${product.quantity}',
                                      style: GoogleFonts.lexend(),
                                    ),
                                    IconButton(
                                      icon: const Icon(CupertinoIcons.add),
                                      onPressed: () {
                                        setState(() {
                                          widget.onUpdateQuantity(
                                            index,
                                            (product.quantity) + 1,
                                          );
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => widget.onRemoveItem(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            if (widget.cartItems.isNotEmpty)
              Column(
                children: [
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: GoogleFonts.lexend(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${calculateTotalPrice().toStringAsFixed(2)}',
                          style: GoogleFonts.lexend(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: const Color.fromRGBO(123, 97, 255, 1),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                        CupertinoIcons.check_mark_circled,
                                        color: Color.fromRGBO(123, 97, 255, 1)),
                                    const SizedBox(width: 10),
                                    Text('Confirm Checkout',
                                        style:
                                            GoogleFonts.lexend(fontSize: 18)),
                                  ],
                                ),
                              ],
                            ),
                            content: Text(
                                'Are you sure you want to Check Out Product of Amount: \$${calculateTotalPrice().toStringAsFixed(2)}?'),
                            contentTextStyle: GoogleFonts.lexend(
                                fontSize: 20, color: Colors.black),
                            actionsAlignment: MainAxisAlignment.spaceBetween,
                            icon: const Icon(Icons.question_answer),
                            actions: [
                              TextButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(Colors.green)),
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    duration: Duration(seconds: 5),
                                    content: Text(
                                      'Products Of Amount \$${calculateTotalPrice().toStringAsFixed(2)} Checked Out!',
                                      style: GoogleFonts.lexend(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    backgroundColor:
                                        Color.fromRGBO(123, 97, 255, 1),
                                  ));
                                  setState(() {
                                    widget.cartItems.clear();
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Yes',
                                  style:
                                      GoogleFonts.lexend(color: Colors.white),
                                ),
                              ),
                              TextButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(Colors.red)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'No',
                                  style:
                                      GoogleFonts.lexend(color: Colors.white),
                                ),
                              ),
                            ],
                            elevation: 20,
                          );
                        },
                      );
                    },
                    child: Text(
                      "Checkout",
                      style: GoogleFonts.lexend(fontSize: 16),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
