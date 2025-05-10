import 'package:flutter/material.dart';

class PlatformSearchSliverAppBar extends StatefulWidget implements PreferredSizeWidget {
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
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      backgroundColor: theme.colorScheme.surface,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Text(
        'Search',
        style: TextStyle(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w600,
          fontSize: 22,
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
                child: TextField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) => widget.onSearch(value),
                  decoration: InputDecoration(
                    hintText: 'Search by nickname',
                    hintStyle: TextStyle(
                      color: theme.colorScheme.onSurface.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () => widget.onSearch(_searchController.text),
                  icon: Icon(Icons.search_rounded, color: Colors.white),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
