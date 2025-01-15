import 'package:flutter/material.dart';
import 'package:peanutprogress/features/create_habit/view/category_group_button_widget.dart';
import 'package:peanutprogress/features/create_habit/view/save_button_widget.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';
import 'package:peanutprogress/features/create_habit/view/add_category_button_widget.dart';
import 'package:peanutprogress/features/create_habit/view/days_row_widget.dart';
import 'package:peanutprogress/features/create_habit/view/description_formfield_widget.dart';
import 'package:group_button/group_button.dart';
import 'package:peanutprogress/features/create_habit/view/title_formfield_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A form widget to create or edit a habit.
///
/// This widget is used in the [CreateHabitScreenWidget] to create or edit a habit.
/// It uses a [Form] to validate the input fields.
/// The [CreateHabitFormWidget] contains the [TitleFormfieldWidget], the [DescriptionFormfieldWidget], the [DaysRowWidget], the [AddCategoryButtonWidget], the [CategoryGroupButtonWidget] and the [SaveButtonWidget].
/// The [CreateHabitFormWidget] uses a [ValueNotifier] to update the habit object.
/// The [CreateHabitFormWidget] uses a [ValueNotifier] to show an error message if no days are selected.
/// The [CreateHabitFormWidget] uses a [ValueNotifier] to show an error message if no category is selected.
/// The [CreateHabitFormWidget] uses a [ValueNotifier] to show if the save button was pressed. This starts the validation of the form.
/// It uses the [CategoryProvider] to add categories.
/// The widget is Stateful to save the State of the habit object and the controllers when popups are called.
///
/// ### Required parameters:
/// - [habit] is the habit object to update.
///
/// ### Validation:
/// The title, the category and the days are required fields.
class CreateHabitFormWidget extends StatefulWidget {
  const CreateHabitFormWidget({super.key, required this.habit});

  final Habit habit;

  @override
  State<CreateHabitFormWidget> createState() => _CreateHabitFormWidgetState();
}

class _CreateHabitFormWidgetState extends State<CreateHabitFormWidget> {
  final _inputform = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final GroupButtonController groupController =
      GroupButtonController(selectedIndex: 0);
  final ValueNotifier<bool> showDaysError = ValueNotifier(false);
  final ValueNotifier<bool> pressed = ValueNotifier(false);
  final ValueNotifier<bool> categoryError = ValueNotifier(false);
  late Habit h;

  @override
  void initState() {
    super.initState();
    h = widget.habit;

    // Initialize the controllers
    titleController = TextEditingController(text: h.title);
    descriptionController = TextEditingController(text: h.description);
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Habit> habit1 = ValueNotifier(h);

    return SafeArea(
        child: ValueListenableBuilder(
            valueListenable: habit1,
            builder: (context, value, child) {
              return Form(
                key: _inputform,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView(
                    children: [
                      ///Responsive design for the title and description fields.
                      LayoutBuilder(
                        builder: (context, constraints) {
                          bool isWideScreen = constraints.maxWidth > 600;

                          return isWideScreen
                              ? Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(AppLocalizations.of(context)!
                                              .createHabitFormTitle),
                                          const SizedBox(height: 8),
                                          ValueListenableBuilder(
                                            valueListenable: pressed,
                                            builder: (context, value, child) {
                                              return TitleFormfieldWidget(
                                                titleController:
                                                    titleController,
                                                pressed: pressed,
                                                habit: habit1,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .createHabitFormDescriptionPlaceholder,
                                          ),
                                          const SizedBox(height: 8),
                                          DescriptionFormfieldWidget(
                                            descriptionController:
                                                descriptionController,
                                            habit: habit1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppLocalizations.of(context)!
                                        .createHabitFormTitle),
                                    const SizedBox(height: 8),
                                    ValueListenableBuilder(
                                      valueListenable: pressed,
                                      builder: (context, value, child) {
                                        return TitleFormfieldWidget(
                                          titleController: titleController,
                                          pressed: pressed,
                                          habit: habit1,
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .createHabitFormDescriptionPlaceholder,
                                    ),
                                    const SizedBox(height: 8),
                                    DescriptionFormfieldWidget(
                                      descriptionController:
                                          descriptionController,
                                      habit: habit1,
                                    ),
                                  ],
                                );
                        },
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
                                DaysRowWidget(
                                    habit: habit1,
                                    showDaysError: showDaysError),
                                // if (showDaysError.value)
                                //   Text(
                                //     AppLocalizations.of(context)!
                                //         .createHabitFormSelectDayError,
                                //     style: TextStyle(color: Colors.red),
                                //   ),
                              ],
                            );
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!
                              .createHabitFormCategory),
                          AddCategoryButtonWidget(),
                        ],
                      ),
                      CategoryGroupButtonWidget(
                          habit: habit1, categoryError: categoryError),

                      SizedBox(
                        height: 50,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SaveButtonWidget(
                              habit: habit1,
                              showDaysError: showDaysError,
                              categoryError: categoryError,
                              pressed: pressed),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
