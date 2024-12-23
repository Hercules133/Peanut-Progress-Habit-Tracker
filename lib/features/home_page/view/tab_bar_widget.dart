import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/data/models/category.dart';
import '/data/models/own_colors.dart';
import '/data/providers/category_provider.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    super.key,
    this.isScrollable = true,
  });

  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = context.watch<CategoryProvider>();
    List<Category> allCategories = categoryProvider.categories;
    final ownColors = Theme.of(context).extension<OwnColors>()!;

    return TabBar(
      physics: const BouncingScrollPhysics(),
      isScrollable: true,
      overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
      labelColor: ownColors.habitText,
      unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
      padding: EdgeInsets.zero,
      indicatorPadding: EdgeInsets.zero,
      indicatorColor: Colors.transparent,
      labelPadding: EdgeInsets.zero,
      dividerColor: Colors.transparent,
      onTap: (index) {
        categoryProvider.updateSelectedIndex(index);
      },
      tabs: List.generate(
        allCategories.length,
            (index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: allCategories[index].color,
          ),
          margin: const EdgeInsets.all(2),
          child: Tab(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  if (index == categoryProvider.selectedIndex) Icon(Icons.check),
                  Icon(allCategories[index].icon),
                  Text(allCategories[index].name),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
