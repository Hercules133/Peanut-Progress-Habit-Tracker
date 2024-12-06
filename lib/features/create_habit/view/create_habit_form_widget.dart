import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaks/data/models/category.dart';
import 'package:streaks/data/models/habit.dart';
import 'package:streaks/data/models/ownColors.dart';
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

  final _inputform = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    final ownColors = Theme.of(context).extension<OwnColors>()!;
    Habit inheritedData = InheritedWidgetCreateHabit.of(context).habit;
    final categoryProvider= Provider.of<CategoryProvider> (context); 
    List<String> catNames = []; 
    List<Color> catColors = []; 
    for(Category cat in categoryProvider.categories){
      catNames.add(cat.name); 
      catColors.add(cat.color);  
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
          Container(
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
            ],),
            GroupButton(
              isRadio: true,
              onSelected: (val, i, selected) {
                if(selected){
                  inheritedData.category= categoryProvider.categories[i]; 
                }
              },
              buttons: catNames,
              options: GroupButtonOptions (
                selectedColor: ownColors.contribution2,
                unselectedColor: ownColors.contribution1
                ),
                // buttonIndexedBuilder: (selected, index, context){
                //   Color color= !selected
                //                 ? catColors[index] 
                //                 : ownColors.contribution2;  
                  
                // return Container( 
                //   margin: const EdgeInsets.symmetric(horizontal: 5), 
                //   child: ElevatedButton(
                //    style: ElevatedButton.styleFrom(
                //      backgroundColor: selected ? ownColors.contribution1 :color,
                //     ), 
                //   onPressed: () {
                //     // AutocompleteOnSelected; 
                //   }, 
                //   child: Text(catNames[index]),
                // ),
                // ); 
                // },
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