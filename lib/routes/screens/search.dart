import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_store/widgets/modals/products_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF8F8F9),
                hintText: "Search for products",
                hintStyle: GoogleFonts.lexend(),
                prefixIcon: const Icon(CupertinoIcons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              style: GoogleFonts.lexend(),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: demoPopularProducts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.search),
                    title: Text(demoPopularProducts[index].brandName),
                    subtitle: Text(demoPopularProducts[index].title),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
