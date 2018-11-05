# Accounting

_**Description:**_ Application which allow you to keep a record of working hours and calculate your net worth. _(Trying to create my first iOS application)_

_**Task:**_ Create a simple application to calculate your income. The result per working day should be calculated automatically at the end of the working day. Salary per day will be calculated based on working hours. The start and end time of the working day will be recorded by clicking on just one button. **[Goal](https://i.imgur.com/zSermki.png)**

_**Result:**_ [Screenshots](https://imgur.com/a/gTdhdEJ)

_**Fair use:**_ Logic of drawing graphs - [CoreGraphicsGraph](https://github.com/tmdvs/CoreGraphicsGraph) by [Tim Davies](https://github.com/tmdvs)

</br>

## Change Log

#### v.0.4.1 - 10/23/2018
* Added StartNewWorkingDay scene
* Added EndWorkingDay scene
* Added Result scene
* Added BreakDuration scene
* Added StatisticsDay scene

#### v.0.5.6 - 10/25/2018
* Implemented durationPicker in BreakDuration
* Added UIDateVIew to textFields in StatisticsDay
* Added extended durationPicker to StatisticsDay scene

#### v.0.5.9 - 10/26/2018
* Added visualization of days array

#### v.0.6.0 - 10/27/2018
* Allowed saving information into file

#### v.0.9.1 - 10/28/2018
* Connected all views
* Fixed bugs
* Refactored code

#### v.1.0.0 [Alpha] - 10/29/2018
* Added dynamic workingTime to label in EndWorkingDay scene

#### v.1.0.7 - 10/30/2018
* Fixed bug with transformation from time to minutes
* Added 'Statistics' button to CloseApp scene
* Redesigned CloseApp scene

#### v.1.1.0 - 11/02/2018
* Created and connected StatisticsWeeks scene
* Added dynamic visualization of all dayButtons and two labels
* Added action to all dayButtons

#### v.1.1.2 - 11/02/2018
* The action of a swipe down have been moved to a separate button

#### v.1.1.3 - 11/02/2018
* Fixed bug with rotation

#### v.1.2.0 - 11/03/2018
* Redesigned a view of StatisticsWeek
* Redesigned logic of StatisticsWeek

#### v.1.2.1 - 11/04/2018
* Fixed bugs
* Solved problem with running program on weekends

#### v.1.2.2 - 11/04/2018
* Allowed swipe on StatisticsWeek scene
* Added icon

#### v.1.3.0 [Beta] - 11/05/2018
* Added StatisticsGraphView
* Allowed drawing of graph
* Redesigned StatisticsWeek
