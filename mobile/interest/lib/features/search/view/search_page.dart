import 'package:flutter/material.dart';
import 'package:interest/ui/components/common/user_search_card.dart';
import 'package:interest/ui/components/platform/platform.dart';

class SearchPage extends StatelessWidget{
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          PlatformSearchSliverAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverList.builder(
            itemBuilder: (context, index) => UserSearchCard()
          ),
        ],
      ),
    );
  }
}