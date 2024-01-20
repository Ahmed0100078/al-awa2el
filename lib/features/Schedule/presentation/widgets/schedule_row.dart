import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/Schedule/domain/entities/day_entity.dart';
import 'package:madaresco/features/Schedule/presentation/manager/schedule_view_model.dart';
import 'package:madaresco/features/Schedule/presentation/widgets/subjects_row.dart';
import 'package:provider/provider.dart';

class ScheduleRow extends StatelessWidget {
  final DayEntity _entity;
  final ExpandableController _controller = ExpandableController();

  ScheduleRow({
    required DayEntity entity,
  }) : _entity = entity {
    _controller.addListener(() {
      if (_controller.value) {
        print('expanded');
      } else {
        print('not expanded');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScheduleViewModel vm = Provider.of<ScheduleViewModel>(context);
    var local = AppLocalizations.of(context);
    return ExpandableNotifier(
      // <-- Provides ExpandableController to its children

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expandable(
            // <-- Driven by ExpandableController from ExpandableNotifier

            collapsed: ExpandableButton(
              // <-- Expands when tapped on the cover photo
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                child: Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _entity.arname,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 16.0,
                          )
                        ],
                      ),
                    ),
                    color: kAccentColor,
                  ),
                ),
              ),
            ),
            expanded: Padding(
              padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
              child: Stack(clipBehavior: Clip.none, children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      bottom: 10.0, left: 10.0, right: 10.0, top: 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: Colors.black45)),
                  child: Column(
                    children: getChildren(_entity.no, vm, local),
                  ),
                ),
                Positioned(
                  top: -30,
                  right: 0.0,
                  left: 0.0,
                  child: ExpandableButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 16.0),
                      child: Container(
                        width: double.infinity,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    _entity.arname,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                RotatedBox(
                                  quarterTurns: 2,
                                  child: Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 16.0,
                                )
                              ],
                            ),
                          ),
                          color: kAccentColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getChildren(
      int no, ScheduleViewModel vm, AppLocalizations local) {
    switch (no) {
      case 1:
        return vm.day1.schedules.isNotEmpty
            ? vm.day1.schedules.map((e) => SubjectsRow(subjects: e)).toList()
            : [
                SizedBox(
                  height: 30,
                  child: Center(
                    child: Text(
                      local.translate(
                        'no_schedule',
                      ),
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                )
              ];
      case 2:
        return vm.day2.schedules.isNotEmpty
            ? vm.day2.schedules.map((e) => SubjectsRow(subjects: e)).toList()
            : [
                SizedBox(
                  height: 30,
                  child: Center(
                    child: Text(
                      local.translate(
                        'no_schedule',
                      ),
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                )
              ];
      case 3:
        return vm.day3.schedules.isNotEmpty
            ? vm.day3.schedules.map((e) => SubjectsRow(subjects: e)).toList()
            : [
                SizedBox(
                  height: 30,
                  child: Center(
                    child: Text(
                      local.translate(
                        'no_schedule',
                      ),
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                )
              ];
      case 4:
        return vm.day4.schedules.isNotEmpty
            ? vm.day4.schedules.map((e) => SubjectsRow(subjects: e)).toList()
            : [
                SizedBox(
                  height: 30,
                  child: Center(
                    child: Text(
                      local.translate(
                        'no_schedule',
                      ),
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                )
              ];
      case 5:
        return vm.day5.schedules.isNotEmpty
            ? vm.day5.schedules.map((e) => SubjectsRow(subjects: e)).toList()
            : [
                SizedBox(
                  height: 30,
                  child: Center(
                    child: Text(
                      local.translate(
                        'no_schedule',
                      ),
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                )
              ];
      case 6:
        return vm.day6.schedules.isNotEmpty
            ? vm.day6.schedules.map((e) => SubjectsRow(subjects: e)).toList()
            : [
                SizedBox(
                  height: 30,
                  child: Center(
                    child: Text(
                      local.translate(
                        'no_schedule',
                      ),
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                )
              ];
      case 7:
        return vm.day7.schedules.isNotEmpty
            ? vm.day7.schedules.map((e) => SubjectsRow(subjects: e)).toList()
            : [
                SizedBox(
                  height: 30,
                  child: Center(
                    child: Text(
                      local.translate(
                        'no_schedule',
                      ),
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                )
              ];
      default:
        return [];
    }
  }
}
