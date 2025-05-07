import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:moon_store/widgets/modals/hive_modal.dart';
import 'package:moon_store/routes/pages/product_details_screen.dart';
import 'package:moon_store/widgets/modals/products_model.dart';

class HomeScreen extends StatelessWidget {
  final List<ProductModel> cartItems;
  final void Function(ProductModel) addToCart;

  const HomeScreen({
    super.key,
    required this.cartItems,
    required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    final Box<User> userBox = Hive.box<User>('userBox');
    final User? user = userBox.get('user');

    Widget _buildProductCard(ProductModel product) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(product: product),
            ),
          );
        },
        child: Container(
          width: 150,
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  product.image,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    product.brandName,
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    product.title,
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '\$${product.priceAfterDiscount?.toStringAsFixed(2) ?? product.price.toStringAsFixed(2)}',
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                if (product.priceAfterDiscount != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                if (product.discountPercent != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '${product.discountPercent}% OFF',
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 8.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () => addToCart(product),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(150, 36),
                    ),
                    child: Text(
                      'Add to Cart',
                      style: GoogleFonts.lexend(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildProductSection(String title, List<ProductModel> products) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              '$title',
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 350,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: products.map(_buildProductCard).toList(),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset('assets/bg.jpg'),
                Positioned(
                  top: 60,
                  left: 150,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/avater.jpg'),
                  ),
                ),
                Positioned(
                  top: 185,
                  left: 15,
                  child: Text(
                    user != null
                        ? 'Welcome ${user.username} to Moon-Store.'
                        : 'Welcome to Moon-Store.',
                    style: GoogleFonts.lexend(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Categories',
                style: GoogleFonts.lexend(
                  color: Colors.grey[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 56,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  _buildCategoryButton('Popular Products'),
                  _buildCategoryButton('Flash Sale'),
                  _buildCategoryButton('Best Sellers'),
                  _buildCategoryButton('Kids'),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            _buildProductSection(
              'Popular Products With Discounts',
              demoPopularProducts,
            ),
            _buildProductSection(
              'Flash Sale Products',
              demoFlashSaleProducts,
            ),
            _buildProductSection(
              'Best Sellers Products',
              demoBestSellersProducts,
            ),
            _buildProductSection(
              'Kids Products',
              kidsProducts,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: const Color.fromRGBO(123, 97, 255, 1),
          foregroundColor: Colors.white,
          minimumSize: const Size(20, 40),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
