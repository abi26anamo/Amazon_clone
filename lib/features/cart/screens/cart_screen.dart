import 'package:flutter/material.dart';
import 'package:flutternodeapp/common/widgets/custom_button.dart';
import 'package:flutternodeapp/constants/global_variables.dart';
import 'package:flutternodeapp/features/address/screens/address_screen.dart';
import 'package:flutternodeapp/features/cart/widgets/cart_product.dart';
import 'package:flutternodeapp/features/cart/widgets/cart_widget.dart';
import 'package:flutternodeapp/features/search/screens/search_screen.dart';
import 'package:flutternodeapp/home/widgets/address_box.dart';
import 'package:flutternodeapp/models/product.dart';
import 'package:flutternodeapp/providers/user_provider.dart';
import 'package:provider/provider.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
    void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

 
  void navigateToAddress(int sum) {
    Navigator.pushNamed(context, AddressScreen.routeName,arguments:sum.toString() );
  }
  @override
  Widget build(BuildContext context) {
        final user = context.watch<UserProvider>().user;
      int sum = 0;
    user.cart.map(
      (e) => sum += e['quantity'] * e['product']['price'] as int,
    );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 0,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressBox(),
            const CartSubTotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: 'Proceed to By (${user.cart.length} items)',
                onTap:()=>navigateToAddress(sum),
                color: Colors.yellow[600],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            const SizedBox(
              height: 5,
            ),
            // ListView.builder(
            //   itemCount: user.cart.length,
            //   itemBuilder: (context, index) {
            //     return CartProduct(
            //       index: index,
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

