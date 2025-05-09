import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/ui/components/platform/platform.dart';
import 'package:interest/ui/themes/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../themes/theme_provider.dart';

class PlatformSearchSliverAppBar extends StatefulWidget implements PreferredSizeWidget{
  const PlatformSearchSliverAppBar({super.key});

  @override
  State<PlatformSearchSliverAppBar> createState() => _PlatformSearchSliverAppBarState();
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _PlatformSearchSliverAppBarState extends State<PlatformSearchSliverAppBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ThemeProvider>(context, listen: false).addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    Provider.of<ThemeProvider>(context, listen: false).removeListener(_onThemeChanged);
    _searchController.dispose();
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.tune_rounded),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Row(
            children: [
              Expanded(
                child: PlatformSearchTextField(
                  controller: _searchController,
                  onSubmitted: (String? value) {
                    // Обработка отправки текста
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SliverSafeArea(
        sliver: SliverList(
          delegate: SliverChildListDelegate([
            CupertinoSliverNavigationBar(
              backgroundColor: themeProvider.isDarkTheme
                  ? theme.colorScheme.tertiary.withOpacity(1.0)
                  : Colors.white,
              automaticallyImplyLeading: false,
              largeTitle: Text(
                AppLocalizations.of(context)!.search,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 26
                ),
              ),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: Text(AppLocalizations.of(context)!.ready),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: PlatformSearchTextField(
                controller: _searchController,
                onSubmitted: (value) {
                  // Обработка отправки текста
                },
              ),
            ),
          ]),
        ),
      );
    }
  }
}
