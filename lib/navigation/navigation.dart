import 'dart:io';


import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:ticket_booking_app/account/account_page.dart';
import 'package:ticket_booking_app/core/di/dependency_injection.dart';
import 'package:ticket_booking_app/core/utils/app_constants.dart';
import 'package:ticket_booking_app/events/presentation/pages/event_form.dart';
import 'package:ticket_booking_app/events/presentation/pages/events_page.dart';
import 'package:ticket_booking_app/reservations/presentation/pages/reserve_page.dart';

import 'circle_widgets.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;
  late List<BottomNavigationBarItem> _navbarItems;


  final scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences prefs = di();
  bool isOpen = false;
  double turns = 1.0;
  BottomDrawerController controller = BottomDrawerController();

  refresh() {
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  void initState() {

    _navbarItems = [
      BottomNavigationBarItem(
        icon: Icon(Ionicons.ticket, color: cWhiteColor.withAlpha(100),),
        activeIcon: Icon(Ionicons.ticket),
        label: 'Events',
      ),
      BottomNavigationBarItem(
        icon: Icon(Ionicons.file_tray_full, color: cWhiteColor.withAlpha(100),),
        activeIcon: Icon(Ionicons.file_tray_full),
        label: 'Reservations',
      ),
      BottomNavigationBarItem(
        icon: Icon(Ionicons.person, color: cWhiteColor.withAlpha(100),),
        activeIcon: Icon(Ionicons.person),
        label: 'Account',
      ),
    ];
    _widgetOptions = <Widget>[

      ///
      EventsPage.screen(),
      ReservesPage.screen(),
      AccoutPage(),

    ];


    super.initState();
  }

  onDispose() {}

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      key: scaffoldKey,
      // extendBody: true,
      // resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: cWhiteColor,),
        backgroundColor: cSecondColor,
        hoverElevation: 50,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      EventFormPage.screen()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: cFirstColor,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex)

      ),
     bottomNavigationBar: BottomNavigationBar(
       selectedItemColor: cWhiteColor,
       unselectedItemColor: cGrayColor,
       onTap: (index){
         _onItemTapped(index);
       },
       elevation: 2,
       currentIndex: _selectedIndex,
       backgroundColor: cSecondColor,
       items: _navbarItems,
     ),
    );
  }


  animate(bool isOpen) {
    if (isOpen) {
      setState(() {
        turns += 1 / 8;
        controller.close();
        this.isOpen = false;
      });
    } else {
      setState(() {
        turns -= 1 / 8;
        controller.open();
        this.isOpen = true;
      });
    }
  }
}

///Action bottom drawer
///BottomDrawer(
//           color: Colors.transparent,
//           // followTheBody: false,
//           callback: (isOpen) {
//             setState(() async {
//               this.isOpen = isOpen;
//               animate(!isOpen);
//             });
//           },
//           controller: controller,
//           // cornerRadius: 25,
//           header: Stack(
//             alignment: Alignment.bottomCenter,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: 50.h),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(25),
//                     topRight: Radius.circular(25),
//                   ),
//                   child: BottomAppBar(
//                     height: Platform().isAndroid()?80.h:100.h,
//                     elevation: 0.0,
//                     color: cFirstColor,
//                     child: BottomNavigationBar(
//                       items: <BottomNavigationBarItem>[
//                         BottomNavigationBarItem(
//                           icon: SvgPicture.asset(
//                             Assets.iconsHomeOut,
//                             color: cWhiteColor.withAlpha(100),
//                           ),
//                           activeIcon: SvgPicture.asset(
//                             Assets.iconsHomeOut,
//                             color: cWhiteColor,
//                           ),
//                           label: LocaleKeys.appeals.tr(),
//                         ),
//                         BottomNavigationBarItem(
//                           icon: SvgPicture.asset(
//                             Assets.iconsMailOut,
//                             color: cWhiteColor.withAlpha(100),
//                           ),
//                           activeIcon: SvgPicture.asset(
//                             Assets.iconsMailOut,
//                             color: cWhiteColor,
//                           ),
//                           label: LocaleKeys.appeals.tr(),
//                         ),
//                         BottomNavigationBarItem(
//                           icon: SvgPicture.asset(
//                             Assets.iconsHomeOut,
//                             color: Colors.transparent,
//                           ),
//                           activeIcon: SvgPicture.asset(
//                             Assets.iconsHomeOut,
//                             color: Colors.transparent,
//                           ),
//                           label: LocaleKeys.appeals.tr(),
//                         ),
//                         BottomNavigationBarItem(
//                           icon: SvgPicture.asset(
//                             Assets.iconsHomeOut,
//                             color: Colors.transparent,
//                           ),
//                           activeIcon: SvgPicture.asset(
//                             Assets.iconsHomeOut,
//                             color: Colors.transparent,
//                           ),
//                           label: LocaleKeys.appeals.tr(),
//                         ),
//                         BottomNavigationBarItem(
//                           icon: SvgPicture.asset(
//                             Assets.iconsBellOut,
//                             color: cWhiteColor.withAlpha(100),
//                           ),
//                           activeIcon: SvgPicture.asset(
//                             Assets.iconsBellOut,
//                             color: cWhiteColor,
//                           ),
//                           label: LocaleKeys.appeals.tr(),
//                         ),
//                         BottomNavigationBarItem(
//                           icon: SvgPicture.asset(
//                             Assets.iconsPersonOut,
//                             color: cWhiteColor.withAlpha(100),
//                           ),
//                           activeIcon: SvgPicture.asset(
//                             Assets.iconsPersonOut,
//                             color: cWhiteColor,
//                           ),
//                           label: LocaleKeys.appeals.tr(),
//                         ),
//                       ],
//                       selectedLabelStyle:
//                           TextStyle(fontSize: 15.sp, color: cRedColor),
//                       unselectedLabelStyle:
//                           TextStyle(fontSize: 15.sp, color: cRedColor),
//                       showSelectedLabels: false,
//                       showUnselectedLabels: false,
//                       type: BottomNavigationBarType.fixed,
//                       backgroundColor: cFirstColor,
//                       elevation: 0,
//                       iconSize: 26,
//                       // selectedItemColor: cFirstColor,
//                       // unselectedItemColor: cGrayColor,
//                       currentIndex: _selectedIndex,
//                       onTap: (index) {
//                         if (index == 2 || index == 3) {
//                           return null;
//                         }
//                         setState(() => _selectedIndex = index);
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(bottom: Platform().isAndroid()?35.h:55.h),
//                 child: AnimatedRotation(
//                     turns: turns,
//                     duration: Duration(milliseconds: 250),
//                     child: InkWell(
//                         onTap: () {
//                           /// open the bottom drawer.
//                           animate(isOpen);
//                         },
//                         child: CirclePlusWidget())),
//               )
//             ],
//           ),
//           body: Container(
//             color: cFirstColor,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Container(
//                       width: 120.w,
//                       child: Column(
//                         children: [
//                           ClipOval(
//                             child: Material(
//                               color: Colors.white.withAlpha(50), // button color
//                               child: InkWell(
//                                 splashColor: Colors.white.withAlpha(30),
//                                 // inkwell color
//                                 child: Padding(
//                                   padding: EdgeInsets.all(20.w),
//                                   child: SvgPicture.asset(
//                                     Assets.iconsInfoOut,
//                                     color: cWhiteColor,
//                                   ),
//                                 ),
//                                 onTap: () {
//                                   isLoggedIn == null
//                                       ? Navigator.pushNamed(context, '/login', arguments: TakMuhModule)
//                                       : Navigator.pushNamed(
//                                           context, '/categoriesTaklif');
//                                 },
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(top: 10.h),
//                             child: Text(
//                               LocaleKeys.notifyProblem.tr(),
//                               textAlign: TextAlign.center,
//                               style: TextStyle(color: cWhiteColor),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: 120.w,
//                       child: Column(
//                         children: [
//                           ClipOval(
//                             child: Material(
//                               color: Colors.white.withAlpha(50), // button color
//                               child: InkWell(
//                                 splashColor: Colors.white.withAlpha(30),
//                                 // inkwell color
//                                 child: Padding(
//                                   padding: EdgeInsets.all(20.w),
//                                   child: SvgPicture.asset(
//                                     Assets.iconsSendOut,
//                                     color: cWhiteColor,
//                                   ),
//                                 ),
//                                 onTap: () {
//                                   CustomToast.showToast(
//                                       LocaleKeys.soonAddThisFunc.tr());
//                                 },
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(top: 10.h),
//                             child: Text(
//                               LocaleKeys.sendAppeals.tr(),
//                               textAlign: TextAlign.center,
//                               style: TextStyle(color: cWhiteColor),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: 120.w,
//                       child: Column(
//                         children: [
//                           ClipOval(
//                             child: Material(
//                               color: Colors.white.withAlpha(50), // button color
//                               child: InkWell(
//                                 splashColor: Colors.white.withAlpha(30),
//                                 // inkwell color
//                                 child: Padding(
//                                   padding: EdgeInsets.all(20.h),
//                                   child: SvgPicture.asset(
//                                     Assets.iconsCheckOut,
//                                     color: cWhiteColor,
//                                   ),
//                                 ),
//                                 onTap: () {
//                                   CustomToast.showToast(
//                                       LocaleKeys.soonAddThisFunc.tr());
//                                 },
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(top: 10.h),
//                             child: Text(
//                               LocaleKeys.addProfit.tr(),
//                               textAlign: TextAlign.center,
//                               style: TextStyle(color: cWhiteColor),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ]),
//             ),
//           ),
//           headerHeight: 130.h,
//           drawerHeight: Platform().isAndroid()?270.h:290.h,
//         ),