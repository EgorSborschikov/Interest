import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/ui/themes/themes.dart';
import '../../../ui/components/common/common_drawer.dart';
import '../../../ui/components/platform/platform_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchPage extends StatelessWidget{
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      key: scaffoldKey,
      appBar: PlatformAppBar(
        title: AppLocalizations.of(context)!.search, 
        child: IconButton(
          onPressed: () {
            if (scaffoldKey.currentState != null) {
              scaffoldKey.currentState!.openDrawer(); 
            } else {
              print("Scaffold state is null");
            }
          }, 
          icon: theme.isMaterial 
            ? Icon(Icons.menu_rounded) 
            : Icon(CupertinoIcons.list_bullet)
        ),
      ),
      drawer: CommonDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(

            ),
          ),
        ),
      ),
    );
  }
}