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
  final apiServiceSearch = ApiServiceSearch();
  List<User> users = [];
  String searchQuery = '';
  bool isLoading = false;

  Future<void> _fetchUser() async {
    if (searchQuery.isEmpty){
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final fetchedUsers = await apiServiceSearch.searchUsersByNickname(searchQuery);
      setState(() {
        users = fetchedUsers;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
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
              _fetchUser();
            }
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (isLoading){
                  return const Center(child: PlatformProgressIndicator());
                }

                if (users.isEmpty){
                  return const Center(child: Text('No users found'));
                }

                final user = users[index];
                return UserSearchCard(user: user);
              },
              childCount: isLoading ? 1 : users.isEmpty ? 1 : users.length,
            ),
          ),
        ],
      ),
    );
  }
}