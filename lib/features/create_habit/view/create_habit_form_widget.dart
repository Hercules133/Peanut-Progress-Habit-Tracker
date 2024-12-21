import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/data/models/category.dart';
import '/data/models/habit.dart';
import '/data/models/own_colors.dart';
import '/data/providers/category_provider.dart';
import '/features/create_habit/view/inherited_widget_create_habit.dart';
import '/features/create_habit/view/add_category_button_widget.dart';
import '/features/create_habit/view/days_row_widget.dart';
import '/features/create_habit/view/description_formfield_widget.dart';
import 'package:group_button/group_button.dart';
import '/features/create_habit/view/title_formfield_widget.dart';
import 'time_button_widget.dart';

class CreateHabitFormWidget extends StatelessWidget {
  CreateHabitFormWidget({
    super.key,
  });

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GroupButtonController groupController =
      GroupButtonController(selectedIndex: 0);

  final _inputform = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ownColors = Theme.of(context).extension<OwnColors>()!;
    Habit inheritedData = InheritedWidgetCreateHabit.of(context).habit;
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

    return Form(
      key: _inputform,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Title: "),
                            TitleFormfieldWidget(
                              titleController: titleController,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Description (optional): "),
                            DescriptionFormfieldWidget(
                              descriptionController: descriptionController,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const DaysRowWidget(),
                  const SizedBox(height: 10),
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
                      unselectedColor: ownColors.contribution1,
                    ),
                    buttonIndexedBuilder: (selected, index, context) {
                      return GestureDetector(
                        onLongPress: () async {
                          bool result =
                              await popupDeleteCategoryWidget(context);
                          if (result) {
                            if (categoryProvider.categories[index].isDefault) {
                              debugPrint(
                                  'Can\'t delete category: ${catNames[index]} - It\'s a default!');
                            } else {
                              categoryProvider.removeCategory(
                                  categoryProvider.categories[index]);
                              debugPrint(
                                  'Category deleted: ${catNames[index]}');
                            }
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
                ],
              );
            } else {
              return Column(
                children: [
                  const Text("Title: "),
                  TitleFormfieldWidget(
                    titleController: titleController,
                  ),
                  const Text("Description (optional): "),
                  DescriptionFormfieldWidget(
                    descriptionController: descriptionController,
                  ),
                  SizedBox(
                    height: 30,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        Text("Days:"),
                        SizedBox(width: 240),
                        Text("Reminder:"),
                      ],
                    ),
                  ),
                  const DaysRowWidget(),
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
                      unselectedColor: ownColors.contribution1,
                    ),
                    buttonIndexedBuilder: (selected, index, context) {
                      return GestureDetector(
                        onLongPress: () async {
                          bool result =
                              await popupDeleteCategoryWidget(context);
                          if (result) {
                            if (categoryProvider.categories[index].isDefault) {
                              debugPrint(
                                  'Can\'t delete category: ${catNames[index]} - It\'s a default!');
                            } else {
                              categoryProvider.removeCategory(
                                  categoryProvider.categories[index]);
                              debugPrint(
                                  'Category deleted: ${catNames[index]}');
                            }
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
                ],
              );
            }
          },
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
