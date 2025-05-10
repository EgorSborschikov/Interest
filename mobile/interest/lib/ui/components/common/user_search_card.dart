import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interest/ui/themes/themes.dart';
import '../user.dart';

class UserSearchCard extends StatelessWidget{
  final User user;

  const UserSearchCard({super.key, required this.user});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 10),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (user.profilePhotoUrl != null)
                CircleAvatar(
                  backgroundImage: NetworkImage(user.profilePhotoUrl!),
                ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.nickname),
                  Text('Interests: ${user.interests.join(', ')}'),
                  Text('Motivations: ${user.motivations.join(', ')}'),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {

            }, 
            icon: theme.isMaterial
              ? Icon(
                  Icons.arrow_forward_ios_rounded, 
                  color: theme.colorScheme.onSurface)
              : Icon(
                  CupertinoIcons.chevron_right, 
                  color: theme.colorScheme.onSurface)
          ),
        ],
      ),
    );
  }
}