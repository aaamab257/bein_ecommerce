import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/features/user/favorites/presentation/widgets/favorite_item.dart';

import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        // automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context)!.translate('fav') ?? "Favorites",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return const FavoritesItem();
          },
        ),
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        
      },
      child: const Icon(
        Icons.chat_bubble_outline_outlined,
      ),
    );
  }
}
