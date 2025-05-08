import 'package:flutter/material.dart';
import 'package:interest/ui/components/platform/platform.dart';

class SearchPage extends StatelessWidget{
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          PlatformSearchSliverAppBar(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // Здесь вы можете добавить элементы списка для отображения результатов поиска
                return ListTile(
                  title: Text('Item $index'),
                );
              },
              childCount: 20, // Количество элементов в списке
            ),
          ),
        ],
      )
    );
  }
}