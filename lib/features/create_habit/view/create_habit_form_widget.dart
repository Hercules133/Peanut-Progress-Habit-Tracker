import 'package:flutter/material.dart';
import 'package:streaks/data/providers/habit_provider.dart';
import 'package:streaks/features/create_habit/view/add_category_button_widget.dart';
import 'package:streaks/features/create_habit/view/days_row_widget.dart';
import 'package:streaks/features/create_habit/view/description_formfield_widget.dart';
import 'package:group_button/group_button.dart'; 
import 'package:streaks/features/create_habit/view/title_formfield_widget.dart';
import 'package:provider/provider.dart';
import 'package:streaks/data/models/habit.dart';
import 'package:streaks/features/create_habit/inherited_widget_create_habit.dart';


typedef HabitCallback= void Function(Habit habit); 

class CreateHabitFormWidget extends StatelessWidget {
  CreateHabitFormWidget({
    super.key,
    required this.onHabitChanged
  });

  final TextEditingController titleController = TextEditingController();
  // _titleController.text = model.;
  final TextEditingController descriptionController = TextEditingController();
  final HabitCallback onHabitChanged; 

  final _inputform = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    final inheritedData = InheritedWidgetCreateHabit.of(context).habit;
    final habitProvider= Provider.of<HabitProvider> (context); 
    final habits= habitProvider.habits; 
    String title=""; 

    void updateTitle(String newTitle){
      title=newTitle; 
      inheritedData.title= newTitle; 
    }

    return Form(
      key: _inputform,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Title: "),
          TitleFormfieldWidget(
            titleController: titleController,
            onTitleChanged: (String newTitle){
              updateTitle(newTitle); 
              print(title); 
            }
           
          ), 
          const Text("Description: "),
          DescriptionFormfieldWidget(descriptionController: descriptionController), 
          const Row(
            children: [
              Text("Days"),
              SizedBox(width: 400),
              Text("Reminder"),
            ],
          ),
          const DaysRowWidget(), 
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Category"),
              AddCategoryButtonWidget(),
            ],),
            const GroupButton(
              isRadio: true,
              buttons: ["Sports", "Hobby"] ,
              options: GroupButtonOptions (
                selectedColor: Colors.yellow,
                unselectedColor: Colors.blue,
                )
              )
            // Row(
            //   children: [
            //     CategoryButtonWidget(category: "Sports", color: Colors.blue),
            //     CategoryButtonWidget(category: "Hobby", color: Colors.green),
            // ],)
        ],
      ),
      
    );
  }
}
