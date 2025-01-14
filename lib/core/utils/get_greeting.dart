import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:peanutprogress/data/providers/username_provider.dart';
import 'package:provider/provider.dart';
import 'package:clock/clock.dart';

/// Returns a greeting message based on the current time.
///
/// The greeting depends on the current time:
/// . between 6 AM and 12 PM: 'Good Morning!'
/// - between 12 PM and 6 PM: 'Hello!'
/// - between 6 PM and 10 PM: 'Good Evening!'
/// - between 10 PM and 6 AM: 'Good Night!'
///
/// Returns a [String] with the greeting message.

String getGreeting(BuildContext context) {
  UsernameProvider usernameProvider = context.watch<UsernameProvider>();
  final hour = clock.now().hour;
  if (hour >= 6 && hour < 12) {
    return "${AppLocalizations.of(context)!.goodMorning} ${usernameProvider.username}!";
  } else if (hour >= 12 && hour < 18) {
    return "${AppLocalizations.of(context)!.greeting} ${usernameProvider.username}!";
  } else if (hour >= 18 && hour < 22) {
    return "${AppLocalizations.of(context)!.goodEvening} ${usernameProvider.username}!";
  } else {
    return "${AppLocalizations.of(context)!.goodNight} ${usernameProvider.username}!";
  }
}
