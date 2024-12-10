import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaks/data/models/category.dart';
import 'package:streaks/data/providers/category_provider.dart';

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

    return TabBar(
      physics: const BouncingScrollPhysics(),
      isScrollable: true,
      overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      labelColor: Theme.of(context).colorScheme.onPrimary,
      unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
      padding: EdgeInsets.zero,
      indicatorPadding: EdgeInsets.zero,
      labelPadding: EdgeInsets.zero,
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
                  const Icon(Icons.info),
                  Text(allCategories[index].name)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
