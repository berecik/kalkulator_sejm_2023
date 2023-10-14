import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kalkulator_sejm_2023/lists/lists_controller.dart';
import 'package:kalkulator_sejm_2023/vote/vote_controller.dart';
import 'vote/vote_model.dart';
import 'votes_log_tab.dart';
import 'lists/votes_list_tab.dart';
import 'vote/vote_tab.dart';
import 'votes_fails_tab.dart';
import 'tab_view.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();

  final int amountOfLists = 14;
}

class _TabsScreenState extends State<TabsScreen> {
  // final Map<String, Widget> _tabs = {};
  // final Map<int, VotesListTab> _votesLists = {};
  // late final VoteTab _vote = const VoteTab();
  final VotesFailsTab _votesFails = const VotesFailsTab();

  @override
  void initState() {
    // _tabs["Zliczanie"] = _vote;
    // _tabs["Nieważne"] = _votesFails;
    // for (int i = 1; i <= widget.amountOfLists; i++) {
    //   _votesLists[i] = VotesListTab(i);
    //   _tabs["Lista $i"] = _votesLists[i]!;
    // }
    // _tabs["Log"] = const VotesLogTab();
    super.initState();
  }

  List<Tab> getTabs(Map<String, Widget> tabsMap) {
    List<Tab> tabs = [];
    tabsMap.forEach((key, value) {
      tabs.add(Tab(text: key));
    });
    return tabs;
  }

  List<Widget> getTabBarViews(Map<String, Widget> tabsMap) {
    List<Widget> tabBarViews = [];
    tabsMap.forEach((key, value) {
      tabBarViews.add(
        TabView(value),
      );
    });
    return tabBarViews;
  }

  @override
  Widget build(BuildContext context) {

    ListsController listsController = Get.put(ListsController());

    return GetBuilder<ListsController>(
      builder: (controller) {
        Map<String, Widget> tabsMap = {};
        Map<int, VotesListTab> votesLists = {};

        tabsMap["Zliczanie"] = VoteTab(checkList: listsController.checkList);
        tabsMap["Nieważne"] = _votesFails;
        controller.votesLists.forEach((key, value) {
          votesLists[key] = value;
          tabsMap["Lista $key"] = value;
        });
        tabsMap["Log"] = const VotesLogTab();

        List<Widget> tabs = getTabs(tabsMap);
        List<Widget> tabViews = getTabBarViews(tabsMap);

        return DefaultTabController(
          length: tabs.length,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                isScrollable: true,
                tabs: tabs,
              ),
            ),
            body: TabBarView(
              children: tabViews,
            ),
          ),
        );
      },
    );
  }
}
