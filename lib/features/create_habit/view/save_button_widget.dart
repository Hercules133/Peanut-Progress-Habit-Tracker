import 'package:flutter/material.dart';
import 'package:peanutprogress/core/config/locator.dart';
import 'package:peanutprogress/core/config/notification.dart';
import 'package:peanutprogress/core/utils/enums/progress_status.dart';
import 'package:peanutprogress/core/widgets/details_dialog_widget.dart';
import 'package:peanutprogress/data/models/date_only.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/data/repositories/id_repository.dart';
import 'package:peanutprogress/data/models/own_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

///A button Widget to  Save the habit object and schedule a notification.
///
///This widget is used in the [CreateHabitFormWidget] to save the changes of the habit in the provider
///It uses multiple [ValueNotifier] to get the updated habit an to validate the fields
////// The widget uses the [IdRepository] to generate a new habit id.
/// The [ElevatedButton] uses the [onPressed] to validate the form and save the habit object.
/// It uses the [NotificationService] to schedule a notification for the habit.
/// It uses the [HabitProvider] to add the habit to the list of habits.
/// If its a new habit, generate a new id.
/// If the habit is saved, show a dialog with the habit details and add habit to the habitProvider.
/// Remove categories that are not used anymore.
///
///### Required parameters:
/// - [habit] is the current habit with all changes that were made
/// - [showDaysError] is to validate the days
/// - [categoryError]
/// - [pressed] is to start the validation of the titleFormField
///
/// ### Validation:
/// The Validation checks if the title, the category and the days are selected.(Form Validation)Because they cannot be empty
///
class SaveButtonWidget extends StatelessWidget {
  const SaveButtonWidget({
    super.key,
    required this.habit,
    required this.showDaysError,
    required this.categoryError,
    required this.pressed,
  });

  final ValueNotifier<Habit> habit;
  final ValueNotifier<bool> showDaysError;
  final ValueNotifier<bool> pressed;
  final ValueNotifier<bool> categoryError;

  @override
  build(BuildContext context) {
    bool empty = false;
    final ownColors = Theme.of(context).extension<OwnColors>()!;
    final habitProvider = Provider.of<HabitProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final idRepository = locator<IdRepository>();

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ownColors.contribution1,
        ),
        child: Text(AppLocalizations.of(context)!.createHabitFormSaveButton),
        onPressed: () async {
          showDaysError.value = false;
          empty = false;
          pressed.value = true;

          if (habit.value.category.name == 'All') {
            categoryError.value = true;
            empty = true;
          } else {
            categoryError.value = false;
          }

          if (true) {
            if (habit.value.days.isEmpty) {
              showDaysError.value = true;
              empty = true;
            }
            if (habit.value.title.isEmpty) {
              empty = true;
            }

            if (empty) {
              return;
            }
          }

          if (empty) return;

          int id = habit.value.id == 0
              ? await idRepository.generateNextHabitId()
              : habit.value.id;
          habit.value.id = id;
          habit.value.progress.addAll({
            dateOnly(habit.value.getNextDueDate()): ProgressStatus.notCompleted,
          });
          await habitProvider.addHabit(habit.value);
          NotificationService.scheduleNotification(
              id,
              "Time to complete your habit!",
              "Don't forget to complete your habit: ${habit.value.title}",
              DateTime(
                  habit.value.getNextDueDate().year,
                  habit.value.getNextDueDate().month,
                  habit.value.getNextDueDate().day,
                  habit.value.time.hour,
                  habit.value.time.minute));

          final categoriesToRemove =
              categoryProvider.categories.where((category) {
            final habitsForCategory =
                habitProvider.getHabitsByCategory(category);
            return habitsForCategory.isEmpty && category.name != 'All';
          }).toList();

          for (final category in categoriesToRemove) {
            categoryProvider.removeCategory(category);
          }

          if (context.mounted) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => HabitDetailsDialog(habit: habit.value),
            );
          }
        });
  }
}
