import 'package:flutter_test/flutter_test.dart';
import 'package:peanutprogress/core/utils/get_greeting.dart';
import 'package:clock/clock.dart';

void main() {
  
  test('getGreeting returns correct greeting for morning', () {
    final mockClock = Clock.fixed(DateTime(2025, 01, 01, 9));
    
    withClock(mockClock, () {
      expect(getGreeting(), 'Good Morning!');
    });
  });
 

 test('getGreeting returns correct greeting for afternoon', (){
 final mockClock = Clock.fixed(DateTime(2025, 01, 01, 13));
    
    withClock(mockClock, () {
      expect(getGreeting(), 'Hello!');
    });
 });

 test('getGreeting returns correct greeting for evening', (){
 final mockClock = Clock.fixed(DateTime(2025, 01, 01, 20));
    
    withClock(mockClock, () {
      expect(getGreeting(), 'Good Evening!');
    });
 });
 

  test('getGreeting returns correct greeting for night', (){
 final mockClock = Clock.fixed(DateTime(2025, 01, 01, 05));
    
    withClock(mockClock, () {
      expect(getGreeting(), 'Good Night!');
    });
 });
}