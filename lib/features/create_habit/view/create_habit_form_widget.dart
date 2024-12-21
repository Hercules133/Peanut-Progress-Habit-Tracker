import 'package:flutter/material.dart';
import 'package:peanutprogress/core/config/locator.dart';
import 'package:peanutprogress/core/utils/enums/progress_status.dart';
import 'package:peanutprogress/core/widgets/details_dialog_widget.dart';
import 'package:peanutprogress/data/models/date_only.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/data/repositories/id_repository.dart';
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
      if (inheritedData.category == cat) {
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
              const Text("Title: "),
              ValueListenableBuilder(
                  valueListenable: pressed,
                  builder: (context, value, child) {
                    return TitleFormfieldWidget(
                      titleController: titleController,
                      pressed: pressed,
                    );
                  }),
              const Text("Description(optional): "),
              DescriptionFormfieldWidget(
                descriptionController: descriptionController,
              ),
              SizedBox(
                height: 30,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    Text("Days:"),
                    SizedBox(width: 260),
                    Text("Reminder:"),
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
                          const Text(
                            'Please select at least one day.',
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    );
                  }),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Category"),
                  AddCategoryButtonWidget(),
                ],
              ),
              GroupButton(
                controller: groupController,
                isRadio: true,
                onSelected: (val, i, selected) {
                  if (selected) {
                    inheritedData.category = categoryProvider.categories[i];
                  }
                },
                buttons: catNames,
                options: GroupButtonOptions(
                    selectedColor: ownColors.contribution2,
                    unselectedColor: ownColors.contribution1),
                buttonIndexedBuilder: (selected, index, context) {
                  return GestureDetector(
                    onLongPress: () async {
                      bool result = await popupDeleteCategoryWidget(context);
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
                      child: const Text("Save"),
                      onPressed: () async {
                        showDaysError.value = false;
                        empty = false;
                        pressed.value = true;

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

                        int id = inheritedData.id == 0
                            ? await idRepository.generateNextHabitId()
                            : inheritedData.id;
                        inheritedData.id = id;
                        inheritedData.progress.addAll({
                          dateOnly(inheritedData.getNextDueDate()):
                              ProgressStatus.notCompleted,
                        });
                        habitProvider.addHabit(inheritedData);

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

Future<bool> popupDeleteCategoryWidget(BuildContext context) async {
  var result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Delete'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Do you want to delete this Category?"),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        icon: const Icon(Icons.check),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ]),
              ],
            ));
      });
  return result ?? false;
}
