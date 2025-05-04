import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:interest/features/chats/chats.dart';
import 'package:interest/features/recommended/recommended.dart';
import 'package:interest/features/search/search.dart';
import 'package:interest/features/settings/settings.dart';
import 'package:interest/ui/themes/themes.dart';
import '../../../ui/components/platform/platform.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController; // Объявляем контроллер

  final List<Widget> _pages = [
    //tmp scaffolds
    RecommendedPage(),
    SearchPage(),
    ChatListPage(),
    SettingsPage()
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentIndex
    );
  }

  void _onSelect(int index){
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar:PlatformNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.compass),
            label: AppLocalizations.of(context)!.recommended
          ),
          BottomNavigationBarItem(
            icon: theme.isMaterial 
            ? const Icon(Icons.search) 
            : Icon(CupertinoIcons.search_circle),
            label: AppLocalizations.of(context)!.search
          ),
          BottomNavigationBarItem(
            icon: theme.isMaterial 
            ? const Icon(Icons.chat_rounded) 
            : Icon(CupertinoIcons.chat_bubble),
            label: AppLocalizations.of(context)!.chats
          ),
          BottomNavigationBarItem(
            icon: theme.isMaterial 
            ? const Icon(CupertinoIcons.gear) 
            : Icon(CupertinoIcons.settings_solid),
            label: AppLocalizations.of(context)!.profile
          ),
        ], 
        onSelect: _onSelect, 
        currentIndex: _currentIndex
      ),
    );
  }
}