import 'package:flutter/material.dart';

class CreateHabit extends StatelessWidget{
  const CreateHabit({super.key});

@override
  Widget build(BuildContext context) {
    var model; 
    final TextEditingController titleController = TextEditingController();
    // _titleController.text = model.;
    final TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
          Navigator.pop(context); 
          }, 
          icon:  const Icon(Icons.close), 
        ),

        actions:  <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: (){

            },
            )
        ]
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Title: "),
          TextFormField(
            maxLength: 20,
            controller: titleController,
            decoration: const InputDecoration(
            labelText: "Habit title",
            hintText: "Enter a Habit title",
            ),
            validator: (value) {
            return ("Enter habit");
              // value == null || value.isEmpty)
              // ? "Enter task"
              // : model.getTask(index).title;
            },
            onChanged: (value) {
              // model.getTask(index).title = value;
              // model.saveData(storageForm);
            }
          ),
           const Text("Description: "),
          TextFormField(
            maxLength: 150,
            controller: descriptionController,
            decoration: const InputDecoration(
            labelText: "description (optional) ",
            hintText: "Enter a description",
            ),
            validator: (value) {
            return ("Enter description");
              // value == null || value.isEmpty)
              // ? "Enter task"
              // : model.getTask(index).title;
            },
            onChanged: (value) {
              // model.getTask(index).title = value;
              // model.saveData(storageForm);
            }
          ),
          const Row(
            children: [
              Text("Days"),
              SizedBox(width: 400),
              Text("Reminder"),
            ],
          ),          
          Row(
            children: [
              TextButton(
                onPressed: (){

                },
                child: const Text("Mo")
              ),
              TextButton(
                onPressed: (){

                },
                child: const Text("Tu")
              ),
              TextButton(
                onPressed: (){

                },
                child: const Text("We")
              ),
              TextButton(
                onPressed: (){

                },
                child: const Text("Th")
              ),
              TextButton(
                onPressed: (){

                },
                child: const Text("Fr")
              ),
              TextButton(
                onPressed: (){

                },
                child: const Text("Sa")
              ),
              TextButton(
                onPressed: (){

                },
                child: const Text("Su")
              ),
              ElevatedButton(
                    child: const Text('Open time picker'),
                    onPressed: () async {

                    },
              )
                     
            ],
          )
        ],
      ),
    );
  }
}