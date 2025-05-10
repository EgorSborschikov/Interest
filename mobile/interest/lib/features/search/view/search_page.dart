import 'package:flutter/material.dart';
import 'package:interest/services/api/api_service_search.dart';
import 'package:interest/ui/components/common/user_search_card.dart';
import 'package:interest/ui/components/platform/platform.dart';
import '../../../ui/components/user.dart';

class SearchPage extends StatefulWidget{
  const SearchPage({super.key,});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ApiServiceSearch apiServiceSearch = ApiServiceSearch();
  List<User> users = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fecthUsers();
  }

  Future<void> _fecthUsers() async {
    try {
      final response = await apiServiceSearch.searchUsersByNickname(searchQuery);
      setState(() {
        users = (response.data as List).map((userData) => User.fromJson(userData)).toList();
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          PlatformSearchSliverAppBar(
            onSearch: (query) { 
              setState(() {
                searchQuery = query;
              });
              _fecthUsers();
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (users.isEmpty) {
                  return Center(child: PlatformProgressIndicator());
                }
                final user = users[index];
                return UserSearchCard(user: user);
              },
              childCount: users.isEmpty ? 1 : users.length,
            ),
          ),
        ],
      ),
    );
  }
}