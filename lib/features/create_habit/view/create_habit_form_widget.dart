import 'package:flutter/material.dart';
import 'package:peanutprogress/core/config/locator.dart';
import 'package:peanutprogress/core/utils/enums/progress_status.dart';
import 'package:peanutprogress/core/widgets/details_dialog_widget.dart';
import 'package:peanutprogress/data/models/date_only.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/data/repositories/id_repository.dart';
import 'package:peanutprogress/features/create_habit/view/popup_delete_category.dart';
// import 'package:peanutprogress/features/create_habit/view/popup_saving_widget.dart';
import 'package:provider/provider.dart';
import 'package:peanutprogress/data/models/category.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/models/own_colors.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';
import 'package:peanutprogress/features/create_habit/view/inherited_widget_create_habit.dart';
import 'package:peanutprogress/features/create_habit/view/add_category_button_widget.dart';
import 'package:peanutprogress/features/create_habit/view/days_row_widget.dart';
import 'package:peanutprogress/features/create_habit/view/description_formfield_widget.dart';
import 'package:group_button/group_button.dart';
import 'package:peanutprogress/features/create_habit/view/title_formfield_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateHabitFormWidget extends StatelessWidget {
  CreateHabitFormWidget({
    super.key,
  });

  final _inputform = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GroupButtonController groupController =
      GroupButtonController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    Habit inheritedData = InheritedWidgetCreateHabit.of(context).habit;
    // final inheritedNotifierEmpty = InheritedNotifierEmptyFields.of(context);
// final counter = inheritedNotifierEmpty?.notifier;
// final count = counter?.empty ?? 0;

    final ownColors = Theme.of(context).extension<OwnColors>()!;

    ValueNotifier<bool> showDaysError = ValueNotifier(false);
    ValueNotifier<bool> pressed = ValueNotifier(false);
    ValueNotifier<bool> categoryError = ValueNotifier(false);
    final habitProvider = Provider.of<HabitProvider>(context, listen: false);
    final idRepository = locator<IdRepository>();

    // bool pressed =
    //     InheritedWidgetCreateHabit.of(context).pressed;
    final categoryProvider = Provider.of<CategoryProvider>(context);

    List<String> catNames = [];
    List<Color> catColors = [];
    List<IconData> catIcon = [];
    int i = 0;
    for (Category cat in categoryProvider.categories) {
      catNames.add(cat.name);
      catColors.add(cat.color);
      catIcon.add(cat.icon);
      if (inheritedData.category.name == cat.name) {
        groupController.selectIndex(i);
      }
      i++;
    }
    bool empty = false;

    return SafeArea(
      child: Form(
        key: _inputform,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Text(AppLocalizations.of(context)!.createHabitFormTitle),
              ValueListenableBuilder(
                  valueListenable: pressed,
                  builder: (context, value, child) {
                    return TitleFormfieldWidget(
                      titleController: titleController,
                      pressed: pressed,
                    );
                  }),
              Text(AppLocalizations.of(context)!
                  .createHabitFormDescriptionPlaceholder),
              DescriptionFormfieldWidget(
                descriptionController: descriptionController,
              ),
              SizedBox(
                height: 30,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    SizedBox(width: 260),
                  ],
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: showDaysError,
                  builder: (context, value, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DaysRowWidget(),
                        if (showDaysError.value)
                          Text(
                            AppLocalizations.of(context)!
                                .createHabitFormSelectDayError,
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.createHabitFormCategory),
                  AddCategoryButtonWidget(),
                ],
              ),
              GroupButton(
                controller: groupController,
                isRadio: true,
                onSelected: (val, i, selected) {
                  if (selected) {
                    inheritedData.category = categoryProvider.categories[i];
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
                        inheritedData.category =
                            categoryProvider.categories[index];
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
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ownColors.contribution1,
                      ),
                      child: Text(AppLocalizations.of(context)!
                          .createHabitFormSaveButton),
                      onPressed: () async {
                        showDaysError.value = false;
                        empty = false;
                        pressed.value = true;

                        if (inheritedData.category == null ||
                            inheritedData.category.name == 'All') {
                          categoryError.value = true;
                          empty = true;
                        } else {
                          categoryError.value = false;
                        }

                        // final result = await popupSavingWidget(context, pressed, showDaysError, inheritedData);

                        // if (context.mounted) {
                        //   // Navigator.pop(context);
                        //   if (result != true) {
                        //     Navigator.pop(context);
                        //     if (result != null) {
                        //       habitProvider.addHabit(inheritedData);
                        //       showDialog(
                        //         context: context,
                        //         builder: (context) =>
                        //             HabitDetailsDialog(habit: result),
                        //       );
                        //     }
                        //   }
                        // }

                        if (true) {
                          if (inheritedData.days.isEmpty) {
                            showDaysError.value = true;
                            empty = true;
                          }
                          if (inheritedData.title.isEmpty) {
                            empty = true;
                          }

                          if (empty) {
                            // Navigator.of(context).pop(empty);
                            return;
                          }
                        }

                        if (empty) return;

                        int id = inheritedData.id == 0
                            ? await idRepository.generateNextHabitId()
                            : inheritedData.id;
                        inheritedData.id = id;
                        inheritedData.progress.addAll({
                          dateOnly(inheritedData.getNextDueDate()):
                              ProgressStatus.notCompleted,
                        });
                        habitProvider.addHabit(inheritedData);

                        final categoriesToRemove =
                            categoryProvider.categories.where((category) {
                          final habitsForCategory =
                              habitProvider.getHabitsByCategory(category);
                          return habitsForCategory.isEmpty &&
                              category.name != 'All';
                        }).toList();

                        for (final category in categoriesToRemove) {
                          categoryProvider.removeCategory(category);
                        }

                        if (context.mounted) {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) =>
                                HabitDetailsDialog(habit: inheritedData),
                          );
                        }

                        // if (context.mounted) {
                        // Navigator.of(context).pop(inheritedData);
                        // }
                        // final result = await popupSavingWidget(context);

                        // if (context.mounted) {
                        //   Navigator.pop(context);
                        //   if (result != true) {
                        //     Navigator.pop(context);
                        //     if (result != null) {
                        //       showDialog(
                        //         context: context,
                        //         builder: (context) =>
                        //             HabitDetailsDialog(habit: result),
                        //       );
                        //     }
                        //   }
                        // }
                        // if (result == true) {
                        //   pressed.value = true;
                        //   showDaysError.value = true;
                        // }
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
