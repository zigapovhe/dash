import 'package:dash/helpers/colors.dart';
import 'package:dash/state/firebaseState/firebaseState.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sidebarx/sidebarx.dart';

class ScaffoldWithBottomNavBar extends ConsumerStatefulWidget {
  const ScaffoldWithBottomNavBar({Key? key, required this.child, required this.tabs}) : super(key: key);
  final List tabs;
  final Widget child;

  @override
  ConsumerState<ScaffoldWithBottomNavBar> createState() => _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends ConsumerState<ScaffoldWithBottomNavBar> {
  // getter that computes the current index from the current location,
  // using the helper method below
  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  final _webController = SidebarXController(selectedIndex: 0, extended: true);

  int _locationToTabIndex(String location) {
    final index = widget.tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  // callback used to navigate to the desired tab
  void _onItemTapped(BuildContext context, int tabIndex) {
    if (GoRouter.of(context).location != widget.tabs[tabIndex].initialLocation) {
      if(kIsWeb){
        _webController.selectIndex(tabIndex);
      }
      // go to the initial location of the selected tab (by index)xy
      context.go(widget.tabs[tabIndex].initialLocation);

    }
  }

  @override
  Widget build(BuildContext context) {
    ref.read(getCurrentUserDocumentProvider);
    if(!kIsWeb){
      return Scaffold(
        body: SafeArea(child: Material(child: widget.child)),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 2,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedItemColor: ColorsHelper.accent,
          type: BottomNavigationBarType.fixed,
          enableFeedback: true,
          currentIndex: _currentIndex,
          items: widget.tabs as List<BottomNavigationBarItem>,
          onTap: (index) => _onItemTapped(context, index),
        ),
      );
    } else {
      return Scaffold(
        body: Material(
          child: Row(
            children: [
              SidebarX(
                controller: _webController,
                theme: SidebarXTheme(
                  //margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.05),
                    //borderRadius: BorderRadius.circular(20),
                  ),
                  itemTextPadding: const EdgeInsets.only(left: 30),
                  selectedItemTextPadding: const EdgeInsets.only(left: 30),
                  selectedIconTheme: const IconThemeData(
                    color: Colors.black,
                    size: 20,
                  ),
                  selectedItemDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorsHelper.accent.withOpacity(0.37),
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black.withOpacity(0.5),
                    size: 20,
                  ),
                ),
                extendedTheme: SidebarXTheme(
                  hoverColor: Colors.grey,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.05),
                  ),
                  textStyle: TextStyle(color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.bold),
                  selectedIconTheme: const IconThemeData(
                    color: Colors.black,
                    size: 20,
                  ),
                  selectedTextStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                  margin: const EdgeInsets.only(right: 10),
                ),
                items: List.generate(widget.tabs.length, (index) => SidebarXItem(
                  icon: widget.tabs[index].webIcon,
                  label: widget.tabs[index].label,
                  onTap: () => _onItemTapped(context, index),
                )),

              ),
              Expanded(child: widget.child),
            ],
          ),
        ),
      );
    }
  }
}