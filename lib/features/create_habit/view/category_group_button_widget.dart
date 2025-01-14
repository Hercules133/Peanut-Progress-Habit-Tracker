import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:peanutprogress/data/models/category.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/models/own_colors.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';
import 'package:peanutprogress/features/create_habit/view/popup_delete_category.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A GroupButton widget for selecting a category
///
///This widget is used in the [CreateHabitFormWidget] to select the category of the habit
///The widget uses the [GroupButton] to select a category for the habit.
/// The [GroupButton] uses the [GroupButtonOptions] to set the selected and unselected color.
/// The [GroupButton] uses the [buttonIndexedBuilder] to create a button for each category.
/// The [buttonIndexedBuilder] uses an [ElevatedButton] to select a category.
/// The [ElevatedButton] uses the [onPressed] to select the category and update the habit object.
/// The [ElevatedButton] uses the [onLongPress] to delete a category.
/// The [ValueListenableBuilder] checks if the category is already selected. If not, show an error message.
/// It uses the [CategoryProvider] to remove categories.
///
/// ### Required parameters:
/// - [habit] is the current habit
/// - [categoryError] is to validate the category
///
/// ### Validation:
/// The Validation checks that a category is selected
class CategoryGroupButtonWidget extends StatelessWidget {
  CategoryGroupButtonWidget({
    super.key,
    required this.habit,
    required this.categoryError,
  });
  final ValueNotifier<Habit> habit;
  final GroupButtonController groupController =
      GroupButtonController(selectedIndex: 0);
  final ValueNotifier<bool> categoryError;

  @override
  build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final ownColors = Theme.of(context).extension<OwnColors>()!;

    List<String> catNames = [];
    List<Color> catColors = [];
    List<IconData> catIcon = [];
    int i = 0;

    /// Add all categories seperated by their name, color and icon to the lists (needed for the [GroupButton} Widget).
    for (Category cat in categoryProvider.categories) {
      catNames.add(cat.name);
      catColors.add(cat.color);
      catIcon.add(cat.icon);

      /// Check if the category of the habit is already selected. If yes, select the category in the [GroupButton].
      if (habit.value.category.name == cat.name) {
        groupController.selectIndex(i);
      }
      i++;
    }
    return Column(children: [
      GroupButton(
        controller: groupController,
        isRadio: true,
        onSelected: (val, i, selected) {
          if (selected) {
            habit.value =
                habit.value.copyWith(category: categoryProvider.categories[i]);
            categoryError.value = false;
          }
        },
        buttons: catNames,
        options: GroupButtonOptions(
            selectedColor: ownColors.contribution2,
            unselectedColor: ownColors.contribution1),
        buttonIndexedBuilder: (selected, index, context) {
          if (categoryProvider.categories[index].name == 'All') {
            return const SizedBox.shrink();
          }
          return GestureDetector(
            onLongPress: () async {
              bool result = await popupDeleteCategoryWidget(
                  context, categoryProvider.categories[index]);
              if (result) {
                categoryProvider
                    .removeCategory(categoryProvider.categories[index]);
                debugPrint('Kategorie gelöscht: ${catNames[index]}');
              }
            },
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selected
                    ? ownColors.contribution2
                    : ownColors.contribution1,
              ),
              onPressed: () {
                groupController.selectIndex(index);
                habit.value.category = categoryProvider.categories[index];
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(catIcon[index]),
                  Text(catNames[index]),
                ],
              ),
            ),
          );
        },
      ),

      /// Show an error message if no category is selected.
      ValueListenableBuilder<bool>(
        valueListenable: categoryError,
        builder: (context, hasError, _) {
          final hasCustomCategories = categoryProvider.categories
              .where((category) => category.name != 'All')
              .isNotEmpty;
          return hasError
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    hasCustomCategories
                        ? AppLocalizations.of(context)!
                            .createHabitFormSelectCategoryError
                        : AppLocalizations.of(context)!
                            .createHabitFormCreateCategoryPrompt,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : const SizedBox.shrink();
        },
      ),
    ]);
  }
}
