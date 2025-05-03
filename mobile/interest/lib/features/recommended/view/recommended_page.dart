import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../ui/components/platform/platform.dart';

class RecommendedPage extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: PlatformAppBar(
        title: AppLocalizations.of(context)!.recommended, 
      ),
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