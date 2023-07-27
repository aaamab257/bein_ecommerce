import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../../../config/localization/app_localization.dart';
import '../widgets/favorite_item.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
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