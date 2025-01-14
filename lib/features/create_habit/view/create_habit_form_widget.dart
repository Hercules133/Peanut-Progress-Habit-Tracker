import 'package:flutter/material.dart';
import 'package:peanutprogress/core/config/locator.dart';
import 'package:peanutprogress/core/config/notification.dart';
import 'package:peanutprogress/core/utils/enums/progress_status.dart';
import 'package:peanutprogress/core/widgets/details_dialog_widget.dart';
import 'package:peanutprogress/data/models/date_only.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/data/repositories/id_repository.dart';
import 'package:peanutprogress/features/create_habit/view/popup_delete_category.dart';
import 'package:provider/provider.dart';
import 'package:peanutprogress/data/models/category.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/models/own_colors.dart';
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
/// The [CreateHabitFormWidget] contains the [TitleFormfieldWidget], the [DescriptionFormfieldWidget], the [DaysRowWidget] and the [AddCategoryButtonWidget].
/// The widget also holds a GroupButton to show and select the categories and a [ElevateButton] to save the habit.
/// The [CreateHabitFormWidget] uses a [ValueNotifier] to update the habit object.
/// The widget uses the [GroupButton] to select a category for the habit.
/// The [CreateHabitFormWidget] uses a [ValueNotifier] to show an error message if no days are selected.
/// The [CreateHabitFormWidget] uses a [ValueNotifier] to show an error message if no category is selected.
/// The [CreateHabitFormWidget] uses a [ValueNotifier] to show if the save button was pressed. This starts the validation of the form.
/// The widget uses the [IdRepository] to generate a new habit id.
/// It uses the [NotificationService] to schedule a notification for the habit.
/// It uses the [HabitProvider] to add the habit to the list of habits.
/// It uses the [CategoryProvider] to add or remove categories.
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
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final ownColors = Theme.of(context).extension<OwnColors>()!;
    final habitProvider = Provider.of<HabitProvider>(context);
    final idRepository = locator<IdRepository>();
    final ValueNotifier<Habit> habit1 = ValueNotifier(h);

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
      if (habit1.value.category.name == cat.name) {
        groupController.selectIndex(i);
      }
      i++;
    }
    bool empty = false;

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
                                DaysRowWidget(habit: habit1),
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
                          Text(AppLocalizations.of(context)!
                              .createHabitFormCategory),
                          AddCategoryButtonWidget(),
                        ],
                      ),

                      /// Use the [GroupButton] to select only one category for the habit.
                      ///
                      /// The [GroupButton] uses the [GroupButtonOptions] to set the selected and unselected color.
                      /// The [GroupButton] uses the [buttonIndexedBuilder] to create a button for each category.
                      /// The [buttonIndexedBuilder] uses an [ElevatedButton] to select a category.
                      /// The [ElevatedButton] uses the [onPressed] to select the category and update the habit object.
                      /// The [ElevatedButton] uses the [onLongPress] to delete a category.
                      /// The [ValueListenableBuilder] checks if the category is already selected. If not, show an error message.
                      ///
                      GroupButton(
                        controller: groupController,
                        isRadio: true,
                        onSelected: (val, i, selected) {
                          if (selected) {
                            habit1.value = habit1.value.copyWith(
                                category: categoryProvider.categories[i]);
                            categoryError.value = false;
                          }
                        },
                        buttons: catNames,
                        options: GroupButtonOptions(
                            selectedColor: ownColors.contribution2,
                            unselectedColor: ownColors.contribution1),
                        buttonIndexedBuilder: (selected, index, context) {
                          if (categoryProvider.categories[index].name ==
                              'All') {
                            return const SizedBox.shrink();
                          }
                          return GestureDetector(
                            onLongPress: () async {
                              bool result = await popupDeleteCategoryWidget(
                                  context, categoryProvider.categories[index]);
                              if (result) {
                                categoryProvider.removeCategory(
                                    categoryProvider.categories[index]);
                                debugPrint(
                                    'Kategorie gelöscht: ${catNames[index]}');
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
                                habit1.value.category =
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

                      /// Show an error message if no category is selected.
                      ValueListenableBuilder<bool>(
                        valueListenable: categoryError,
                        builder: (context, hasError, _) {
                          final hasCustomCategories = categoryProvider
                              .categories
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

                      /// Save the habit object and schedule a notification.
                      ///
                      /// The [ElevatedButton] uses the [onPressed] to validate the form and save the habit object.
                      /// The Validation checks if the title, the category and the days are selected.(Form Validation)
                      /// If its a new habit, generate a new id.
                      /// if the habit is saved, show a dialog with the habit details and add habit to the habitProvider.
                      /// Remove categories that are not used anymore.
                      ///
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

                                if (habit1.value.category.name == 'All') {
                                  categoryError.value = true;
                                  empty = true;
                                } else {
                                  categoryError.value = false;
                                }

                                if (true) {
                                  if (habit1.value.days.isEmpty) {
                                    showDaysError.value = true;
                                    empty = true;
                                  }
                                  if (habit1.value.title.isEmpty) {
                                    empty = true;
                                  }

                                  if (empty) {
                                    return;
                                  }
                                }

                                if (empty) return;

                                int id = habit1.value.id == 0
                                    ? await idRepository.generateNextHabitId()
                                    : habit1.value.id;
                                habit1.value.id = id;
                                habit1.value.progress.addAll({
                                  dateOnly(habit1.value.getNextDueDate()):
                                      ProgressStatus.notCompleted,
                                });
                                habitProvider.addHabit(habit1.value);
                                NotificationService.scheduleNotification(
                                    id,
                                    "Time to complete your habit!",
                                    "Don't forget to complete your habit: ${habit1.value.title}",
                                    DateTime(
                                        habit1.value.getNextDueDate().year,
                                        habit1.value.getNextDueDate().month,
                                        habit1.value.getNextDueDate().day,
                                        habit1.value.time.hour,
                                        habit1.value.time.minute));

                                final categoriesToRemove = categoryProvider
                                    .categories
                                    .where((category) {
                                  final habitsForCategory = habitProvider
                                      .getHabitsByCategory(category);
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
                                        HabitDetailsDialog(habit: habit1.value),
                                  );
                                }
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
