import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentrealm_handyman_flutter/providers/maintenance_request_provider.dart';

import '../../../providers/handy_man_provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  Future<void> _refreshData() async {
    print("Refreshing data...");
    await _fetchData();
  }

  Future<void> _fetchData() async {
    await Provider.of<HandyManProvider>(
      context,
      listen: false,
    ).fetchHandyMan(context);
    await Provider.of<MaintenanceRequestProvider>(
      context,
      listen: false,
    ).fetchMaintenanceRequest(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView(children: []),
        ),
      ),
    );
  }
}
