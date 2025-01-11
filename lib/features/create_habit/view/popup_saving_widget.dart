// import 'package:flutter/material.dart';
// import 'package:peanutprogress/data/models/habit.dart';
// import '/core/config/locator.dart';
// import '/core/utils/enums/progress_status.dart';
// import '/data/models/date_only.dart';
// import '/data/repositories/id_repository.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Future<dynamic> popupSavingWidget(
//     BuildContext context,
//     ValueNotifier<bool> pressed,
//     ValueNotifier<bool> showDaysError,
//     Habit inheritedData) async {
//   // final inheritedData = InheritedWidgetCreateHabit.of(context).habit;
//   // ValueNotifier<bool> showDaysError;
//   // InheritedWidgetCreateHabit.of(context).showDaysError;
//   // ValueNotifier<bool> pressed = InheritedWidgetCreateHabit.of(context).pressed;
// //     final inheritedNotifierEmpty = InheritedNotifierEmptyFields.of(context);
// // final counter = inheritedNotifierEmpty;

//   // final habitProvider = Provider.of<HabitProvider>(context, listen: false);
//   final idRepository = locator<IdRepository>();
//   bool empty = false;

//   if (!context.mounted) return;
//   return await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//             title:
//                 Text(AppLocalizations.of(context)!.popupSavingHabitSaveButton),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(AppLocalizations.of(context)!
//                     .popupSavingHabitConfirmationMessage),
//                 Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       IconButton(
//                         onPressed: () async {
//                           // inheritedNotifierEmpty.setTrue();
//                           pressed.value = true;
//                           if (true) {
//                             if (inheritedData.days.isEmpty) {
//                               showDaysError.value = true;
//                               // ScaffoldMessenger.of(context).showSnackBar(
//                               // const SnackBar(
//                               //     content:
//                               //         Text('Please select at least one day!')),
//                               // );
//                               empty = true;
//                             }
//                             if (inheritedData.title.isEmpty) {
//                               // ScaffoldMessenger.of(context).showSnackBar(
//                               //   const SnackBar(
//                               //       content: Text('Please select a title!')),
//                               // );
//                               empty = true;
//                             }

//                             if (empty) {
//                               Navigator.of(context).pop(empty);

//                               return;
//                             }
//                           }

//                           int id = inheritedData.id == 0
//                               ? await idRepository.generateNextHabitId()
//                               : inheritedData.id;
//                           inheritedData.id = id;
//                           inheritedData.progress.addAll({
//                             dateOnly(inheritedData.getNextDueDate()):
//                                 ProgressStatus.notCompleted,
//                           });
//                           // habitProvider.addHabit(inheritedData);
//                           if (context.mounted) {
//                             Navigator.of(context).pop(inheritedData);
//                           }

//                           // debugPrint('id: $id');
//                           // debugPrint(inheritedData.title);
//                           // debugPrint(inheritedData.description);
//                           // debugPrint(
//                           //     "${inheritedData.time.hour}: ${inheritedData.time.minute}");
//                           // debugPrint(inheritedData.days.toString());
//                           // debugPrint(inheritedData.category.name);
//                         },
//                         icon: const Icon(Icons.check),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         icon: const Icon(Icons.close),
//                       ),
//                     ]),
//               ],
//             ));
//       });
// }
