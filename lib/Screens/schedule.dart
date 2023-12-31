import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter/material.dart';
import 'package:urbanserv/utils/constants.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({ Key? key }) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _selectedDay = 2;
  int _selectedRepeat = 0;
  String _selectedHour = '13:30';
  List<int> _selectedExteraCleaning = [];

  ItemScrollController _scrollController = ItemScrollController();
  DateTime _selectedDateTime = DateTime.now();

  final List<dynamic> _days = [
    [1, 'Fri'],
    [2, 'Sat'],
    [3, 'Sun'],
    [4, 'Mon'],
    [5, 'Tue'],
    [6, 'Wed'],
    [7, 'Thu'],
    [8, 'Fri'],
    [9, 'Sat'],
    [10, 'Sun'],
    [11, 'Mon'],
    [12, 'Tue'],
    [13, 'Wed'],
    [14, 'Thu'],
    [15, 'Fri'],
    [16, 'Sat'],
    [17, 'Sun'],
    [18, 'Mon'],
    [19, 'Tue'],
    [20, 'Wed'],
    [21, 'Thu'],
    [22, 'Fri'],
    [23, 'Sat'],
    [24, 'Sun'],
    [25, 'Mon'],
    [26, 'Tue'],
    [27, 'Wed'],
    [28, 'Thu'],
    [29, 'Fri'],
    [30, 'Sat'],
    [31, 'Sun']
  ];

  final List<String> _hours = <String>[
    '01:00',
    '01:30',
    '02:00',
    '02:30',
    '03:00',
    '03:30',
    '04:00',
    '04:30',
    '05:00',
    '05:30',
    '06:00',
    '06:30',
    '07:00',
    '07:30',
    '08:00',
    '08:30',
    '09:00',
    '09:30',
    '10:00',
    '10:30',
    '11:00',
    '11:30',
    '12:00',
    '12:30',
    '13:00',
    '13:30',
    '14:00',
    '14:30',
    '15:00',
    '15:30',
    '16:00',
    '16:30',
    '17:00',
    '17:30',
    '18:00',
    '18:30',
    '19:00',
    '19:30',
    '20:00',
    '20:30',
    '21:00',
    '21:30',
    '22:00',
    '22:30',
    '23:00',
    '23:30',
  ];

  final List<String> _repeat = [
    'No repeat',
    'Every day',
    'Every week',
    'Every month'
  ];

  final List<dynamic> _extraCleaning = [
    ['Washing', 'https://img.icons8.com/office/2x/washing-machine.png', '29'],
    ['Fridge', 'https://img.icons8.com/cotton/2x/fridge.png', '79'],
    ['Oven', 'https://img.icons8.com/external-becris-lineal-color-becris/2x/external-oven-kitchen-cooking-becris-lineal-color-becris.png', '129'],
    ['Vehicle', 'https://img.icons8.com/external-vitaliy-gorbachev-blue-vitaly-gorbachev/2x/external-bycicle-carnival-vitaliy-gorbachev-blue-vitaly-gorbachev.png', '12'],
  ];

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate != null && pickedDate != _selectedDateTime) {
      setState(() {
        _selectedDateTime = pickedDate;
      });
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () {
      _scrollController.scrollTo(
        index: 24,
        duration: Duration(seconds: 3),
        curve: Curves.easeInOut,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12, 20, 12, 12),
                  child: Text(
                    'Select Date & Time',
                    style: kHeadingFontStyle.copyWith(
                      fontSize: 28
                    )
                  ),
                ),
              )
            ];
          },
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12,),
                Row(
                  children: [
                    Text("${_selectedDateTime.month} ${_selectedDateTime.year}"),
                    Spacer(),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      icon: Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.grey.shade700,),
                    ),
                  ],
                ),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(width: 1.5, color: kSeperatorColor),
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _days.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDateTime = _selectedDateTime.copyWith(day: _days[index][0]);
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: 62,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: _selectedDateTime.day == _days[index][0] ? Colors.orange.withOpacity(0.2) : Colors.orange.withOpacity(0),
                              border: Border.all(
                                color: _selectedDateTime.day == _days[index][0] ? kPrimaryColor : Colors.white.withOpacity(0),
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(_days[index][0].toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                SizedBox(height: 10,),
                                Text(_days[index][1], style: TextStyle(fontSize: 16),),
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(width: 1.5, color: Colors.grey.shade200),
                  ),
                  child: ScrollablePositionedList.builder(
                      itemScrollController: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: _hours.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDateTime = _selectedDateTime.copyWith(hour: int.parse(_hours[index].split(':')[0]), minute: int.parse(_hours[index].split(':')[1]));
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: _selectedDateTime.hour == int.parse(_hours[index].split(':')[0]) && _selectedDateTime.minute == int.parse(_hours[index].split(':')[1]) ? Colors.orange.withOpacity(0.2) : Colors.orange.withOpacity(0),
                              border: Border.all(
                                color: _selectedDateTime.hour == int.parse(_hours[index].split(':')[0]) && _selectedDateTime.minute == int.parse(_hours[index].split(':')[1]) ? kPrimaryColor : Colors.white.withOpacity(0),
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(_hours[index], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                ),
                SizedBox(height: 28,),
                Text("Repeat", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                SizedBox(height: 14,),
                Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _repeat.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedRepeat = index;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: _selectedRepeat == index ? Colors.orange : Colors.grey.shade100,
                            ),
                            margin: EdgeInsets.only(right: 20),
                            child: Center(child: Text(_repeat[index],
                              style: TextStyle(fontSize: 18, color: _selectedRepeat == index ? Colors.white : Colors.grey.shade800),)
                            ),
                          ),
                        );
                      },
                    )
                ),
                SizedBox(height: 28,),
                Text("Additional Service", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                SizedBox(height: 14,),
                Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _extraCleaning.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (_selectedExteraCleaning.contains(index)) {
                                  _selectedExteraCleaning.remove(index);
                                } else {
                                  _selectedExteraCleaning.add(index);
                                }
                              });
                            },
                            child: Container(
                                width: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: _selectedExteraCleaning.contains(index) ? Colors.orange.withOpacity(0.2) : Colors.transparent,
                                  border: Border.all(
                                    color: kContrastColor,
                                    width: 1.5,
                                  ),
                                ),
                                margin: EdgeInsets.only(right: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.network(_extraCleaning[index][1], height: 40,),
                                    SizedBox(height: 10,),
                                    Text(_extraCleaning[index][0], style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: _selectedExteraCleaning.contains(index) ? Colors.white : Colors.grey.shade800),),
                                    SizedBox(height: 5,),
                                    Text("₹ ${_extraCleaning[index][2]}", style: TextStyle(color: Colors.black),)
                                  ],
                                )
                            )
                        );
                      },
                    )
                ),
                //Spacer(),
                SizedBox(height: 160,),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Add the code to proceed to payment here.
                      Navigator.pushNamed(context, '/bookingScreen');
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 1.5,
                      backgroundColor: kPrimaryColor, // Change to your color
                      minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.8, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text('Proceed to Payment'),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}