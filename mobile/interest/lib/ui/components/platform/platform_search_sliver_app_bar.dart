import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/ui/components/platform/platform.dart';
import 'package:interest/ui/themes/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../themes/theme_provider.dart';

class PlatformSearchSliverAppBar extends StatefulWidget implements PreferredSizeWidget{  
  final Function(String) onSearch;

  const PlatformSearchSliverAppBar({super.key, required this.onSearch});

  @override
  State<PlatformSearchSliverAppBar> createState() => _PlatformSearchSliverAppBarState();
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _PlatformSearchSliverAppBarState extends State<PlatformSearchSliverAppBar> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    Provider.of<ThemeProvider>(context, listen: false).addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    Provider.of<ThemeProvider>(context, listen: false).removeListener(_onThemeChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _onThemeChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (theme.isMaterial) {
      return SliverAppBar(
        backgroundColor: themeProvider.isDarkTheme
            ? theme.colorScheme.tertiary.withOpacity(1.0)
            : Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context)!.search,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 22
          ),
        ),
        centerTitle: true,
        pinned: true,
        floating: false,
        snap: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 16, 
              top: 4, 
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CommonSearchTextField(
                    controller: _searchController,
                    onSubmitted: (value) => _onTapSearch(context),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: IconButton(
                    onPressed: () => widget.onSearch(_searchController.text), 
                    icon: theme.isMaterial
                      ? Icon(Icons.search_rounded, color: Colors.white)
                      : Icon(CupertinoIcons.search, color: Colors.white),
                    padding: EdgeInsets.zero,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: IconButton(
                    onPressed: () => widget.onSearch(_searchController.text), 
                    icon: theme.isMaterial
                      ? Icon(Icons.more_vert, color: Colors.white)
                      : Icon(CupertinoIcons.ellipsis, color: Colors.white),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return CupertinoSliverNavigationBar(
        backgroundColor: themeProvider.isDarkTheme
          ? theme.colorScheme.tertiary.withOpacity(1.0)
          : Colors.white,
        automaticallyImplyLeading: false,
        largeTitle: Text(
          AppLocalizations.of(context)!.search,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        leading: IconButton(
          onPressed: () {

          }, 
          icon: Icon(CupertinoIcons.ellipsis, color: theme.colorScheme.onSurface),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => widget.onSearch(_searchController.text),
          child: Text(
            AppLocalizations.of(context)!.ready,
            style: TextStyle(
              color: theme.cupertinoActionColor,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        middle: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: CommonSearchTextField(
                  controller: _searchController,
                  onSubmitted: (value) {
                    
                  },
                ),
              ),
            ],
          ),
        ),
      );  
    }
  }

  void _onTapSearch(BuildContext context) {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _fetchQuery(context, query);
    }
  }

  void _fetchQuery(context, query) {

  }
}