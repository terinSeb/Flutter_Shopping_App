import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/providers/auth.dart';
import 'package:shopping_app_flutter/screens/auth_screen.dart';
import 'package:shopping_app_flutter/screens/edit_product_screen.dart';
import 'package:shopping_app_flutter/screens/orders_screen.dart';
import 'package:shopping_app_flutter/screens/products_overview_screen.dart';
import 'package:shopping_app_flutter/screens/user_products_screen.dart';
import './providers/orders.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './providers/products.dart';
import './screens/product_detail_screen.dart';
// import './screens/products_overview_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => Products('', []),
          update: (ctx, auth, previousProducts) => Products(
              auth.token,
              // ignore: unnecessary_null_comparison
              previousProducts!.items == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        )
      ],
      child: Consumer<Auth>(
        builder: ((ctx, auth, _) => MaterialApp(
              title: 'MyShop',
              theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                          .copyWith(secondary: Colors.deepOrange),
                  fontFamily: 'Lato'),
              home: auth.isAuth
                  ? const ProductsOverviewScreen()
                  : const AuthScreen(),
              routes: {
                ProductDetailScreen.routeName: (ctx) =>
                    const ProductDetailScreen(),
                CartScreen.routeName: (ctx) => const CartScreen(),
                OrdersScrenn.routeName: (ctx) => const OrdersScrenn(),
                UserProductsScreen.routeName: (ctx) =>
                    const UserProductsScreen(),
                EditProductScreen.routeName: (ctx) => const EditProductScreen()
              },
            )),
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('MyShop'),
//       ),
//       body: const Center(
//         child: Text('Let\'s build a shop!'),
//       ),
//     );
//   }
// }
