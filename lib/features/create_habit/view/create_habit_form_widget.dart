import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaks/data/models/category.dart';
import 'package:streaks/data/models/habit.dart';
import 'package:streaks/data/models/own_colors.dart';
import 'package:streaks/data/providers/category_provider.dart';
import 'package:streaks/features/create_habit/view/inherited_widget_create_habit.dart';
import 'package:streaks/features/create_habit/view/add_category_button_widget.dart';
import 'package:streaks/features/create_habit/view/days_row_widget.dart';
import 'package:streaks/features/create_habit/view/description_formfield_widget.dart';
import 'package:group_button/group_button.dart';
import 'package:streaks/features/create_habit/view/title_formfield_widget.dart';

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
      child: ListView(
        children: [
          const Text("Title: "),
          TitleFormfieldWidget(
            titleController: titleController,
          ),
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
                    inheritedData.category = categoryProvider.categories[index];
                  },
                  child: Text(catNames[index]),
                  //TODO Icon muss noch hinzugefügt werden.
                ),
              );
            },
          ),
        ],
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
