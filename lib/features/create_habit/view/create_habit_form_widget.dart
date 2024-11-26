import 'package:flutter/material.dart';
import 'package:streaks/data/providers/habit_provider.dart';
import 'package:streaks/features/create_habit/view/add_category_button_widget.dart';
import 'package:streaks/features/create_habit/view/category_button_widget.dart';
import 'package:streaks/features/create_habit/view/days_row_widget.dart';
import 'package:streaks/features/create_habit/view/description_formfield_widget.dart';
import 'package:group_button/group_button.dart'; 
import 'package:streaks/features/create_habit/view/title_formfield_widget.dart';
import 'package:streaks/data/providers/habit_provider.dart';
import 'package:provider/provider.dart';

class CreateHabitFormWidget extends StatelessWidget {
  CreateHabitFormWidget({
    super.key,
  });

  final TextEditingController titleController = TextEditingController();
  // _titleController.text = model.;
  final TextEditingController descriptionController = TextEditingController();

  final _inputform = GlobalKey<FormState>();

   
  

  @override
  Widget build(BuildContext context) {
    // var model = context.watch<HabitProvider>();
    final habitProvider= Provider.of<HabitProvider> (context); 
    final habits= habitProvider.habits; 

    return Form(
      key: _inputform,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Title: "),
          TitleFormfieldWidget(titleController: titleController), 
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
