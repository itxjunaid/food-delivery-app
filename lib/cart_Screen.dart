import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final CartItem? selectedItem;

  const CartScreen({Key? key, this.selectedItem}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _promoController = TextEditingController();
  late List<CartItem> _cartItems;

  @override
  void initState() {
    super.initState();

    // Initialize cart items list with the selected item if provided
    if (widget.selectedItem != null) {
      _cartItems = [widget.selectedItem!];
    } else {
      // Fallback to default items if no item was passed
      _cartItems = [];
    }
  }

  int get _totalItems => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get _subtotal =>
      _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

  double get _discount => _cartItems.isEmpty ? 0 : 10900;

  double get _total => _subtotal - _discount;

  @override
  Widget build(BuildContext context) {
    // Get the screen dimensions
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;

    // Define responsive values based on screen size
    final double fontSize =
        width < 360
            ? 14.0
            : width < 600
            ? 16.0
            : 18.0;
    final double smallFontSize =
        width < 360
            ? 12.0
            : width < 600
            ? 14.0
            : 16.0;
    final double titleFontSize =
        width < 360
            ? 16.0
            : width < 600
            ? 18.0
            : 20.0;
    final double iconSize =
        width < 360
            ? 18.0
            : width < 600
            ? 20.0
            : 24.0;
    final double padding =
        width < 360
            ? 8.0
            : width < 600
            ? 16.0
            : 24.0;
    final double imageSize =
        width < 360
            ? 50.0
            : width < 600
            ? 70.0
            : 90.0;
    final double buttonHeight =
        width < 360
            ? 40.0
            : width < 600
            ? 50.0
            : 60.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: iconSize * 0.8,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: titleFontSize,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.black, size: iconSize),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Location Section
            Text(
              'Delivery Location',
              style: TextStyle(color: Colors.grey, fontSize: smallFontSize),
            ),
            SizedBox(height: height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Home',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.orange),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: padding,
                      vertical: width < 360 ? 4.0 : 8.0,
                    ),
                  ),
                  child: Text(
                    'Change Location',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: smallFontSize,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),

            // Promo Code Section
            Container(
              height: buttonHeight,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  SizedBox(width: width * 0.02),
                  CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: width < 360 ? 10 : 12,
                    child: Icon(
                      Icons.percent,
                      color: Colors.white,
                      size: width < 360 ? 12 : 14,
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  Expanded(
                    child: TextField(
                      controller: _promoController,
                      style: TextStyle(fontSize: smallFontSize),
                      decoration: InputDecoration(
                        hintText: 'Promo Code...',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: smallFontSize,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: width < 360 ? 8.0 : 10.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: buttonHeight,
                    width: width * 0.25,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Apply',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: smallFontSize,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),

            // Cart Items List
            Expanded(
              child:
                  _cartItems.isEmpty
                      ? Center(
                        child: Text(
                          'Your cart is empty',
                          style: TextStyle(
                            fontSize: fontSize,
                            color: Colors.grey[600],
                          ),
                        ),
                      )
                      : ListView.builder(
                        itemCount: _cartItems.length,
                        itemBuilder: (context, index) {
                          final item = _cartItems[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: height * 0.02),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Checkbox
                                Transform.scale(
                                  scale: width < 360 ? 0.8 : 1.0,
                                  child: Checkbox(
                                    value: true,
                                    activeColor: Colors.orange,
                                    onChanged: (value) {},
                                  ),
                                ),

                                // Product Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child:
                                      item.image.startsWith('http')
                                          ? Image.network(
                                            item.image,
                                            width: imageSize,
                                            height: imageSize,
                                            fit: BoxFit.cover,
                                            errorBuilder: (
                                              context,
                                              error,
                                              stackTrace,
                                            ) {
                                              return Container(
                                                width: imageSize,
                                                height: imageSize,
                                                color: Colors.grey[300],
                                                child: Icon(
                                                  Icons.fastfood,
                                                  color: Colors.grey[600],
                                                  size: imageSize * 0.5,
                                                ),
                                              );
                                            },
                                          )
                                          : Image.asset(
                                            item.image,
                                            width: imageSize,
                                            height: imageSize,
                                            fit: BoxFit.fill,
                                            errorBuilder: (
                                              context,
                                              error,
                                              stackTrace,
                                            ) {
                                              return Container(
                                                width: imageSize,
                                                height: imageSize,
                                                color: Colors.grey[300],
                                                child: Icon(
                                                  Icons.fastfood,
                                                  color: Colors.grey[600],
                                                  size: imageSize * 0.5,
                                                ),
                                              );
                                            },
                                          ),
                                ),
                                SizedBox(width: width * 0.02),

                                // Product Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: smallFontSize,
                                        ),
                                      ),
                                      SizedBox(height: height * 0.005),
                                      Text(
                                        '\$${(item.price / 1000).toStringAsFixed(3)}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: smallFontSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Quantity Controls
                                Row(
                                  children: [
                                    Container(
                                      width: width < 360 ? 28 : 36,
                                      height: width < 360 ? 28 : 36,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.remove,
                                          size: width < 360 ? 12 : 16,
                                        ),
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          if (item.quantity > 1) {
                                            setState(() {
                                              item.quantity--;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.015,
                                      ),
                                      child: Text(
                                        '${item.quantity}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: smallFontSize,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width < 360 ? 28 : 36,
                                      height: width < 360 ? 28 : 36,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          size: width < 360 ? 12 : 16,
                                        ),
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          setState(() {
                                            item.quantity++;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(width: width * 0.01),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                        size: width < 360 ? 18 : 24,
                                      ),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () {
                                        setState(() {
                                          _cartItems.removeAt(index);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ),

            // Payment Summary Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Summary',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Items (${_totalItems})',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: smallFontSize,
                        ),
                      ),
                      Text(
                        '\$${(_subtotal / 1000).toStringAsFixed(3)}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: smallFontSize,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Fee',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: smallFontSize,
                        ),
                      ),
                      Text(
                        'Free',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                          fontSize: smallFontSize,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discount',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: smallFontSize,
                        ),
                      ),
                      Text(
                        '-\$${(_discount / 1000).toStringAsFixed(3)}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                          fontSize: smallFontSize,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.015),
                    child: const Divider(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize,
                        ),
                      ),
                      Text(
                        '\$${(_total / 1000).toStringAsFixed(3)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    "Checkout",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem {
  final String name;
  final double price;
  final String image;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}
