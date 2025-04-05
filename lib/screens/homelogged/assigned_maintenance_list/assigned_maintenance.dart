import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/maintenance_request_model.dart';
import '../../../providers/handy_man_provider.dart';
import '../../../providers/maintenance_request_provider.dart';

class AssignedMaintenanceScreen extends StatefulWidget {
  const AssignedMaintenanceScreen({super.key});

  @override
  State<AssignedMaintenanceScreen> createState() =>
      _AssignedMaintenanceScreenState();
}

class _AssignedMaintenanceScreenState extends State<AssignedMaintenanceScreen> {
  @override
  void initState() {
    super.initState();
    // Initial data fetch
    _fetchData();
  }

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

  Widget _buildMaintenanceAssignedRequest(BuildContext context) {
    return Consumer<MaintenanceRequestProvider>(
      builder: (context, maintenanceRequestProvider, child) {
        final maintenanceRequests = maintenanceRequestProvider.assignedRequests;

        // If data is loading
        if (maintenanceRequestProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        // If no pending requests
        if (maintenanceRequests.isEmpty) {
          return Center(child: Text("No Assigned requests"));
        }

        return ListView.builder(
          shrinkWrap:
              true, // Allows ListView to behave like a normal scrollable inside the RefreshIndicator
          itemCount: maintenanceRequests.length,
          itemBuilder: (context, index) {
            MaintenanceRequest request = maintenanceRequests[index]!;

            final room = request.room;
            final tenant = request.tenant?.userProfile.user;
            final tenantProfile = request.tenant?.userProfile;

            return Card(
              elevation: 4, // Adds shadow for a lifted effect
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(
                  16,
                ), // Padding inside the ListTile
                title: Text(
                  request.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(
                  request.description,
                  maxLines: 2, // Limits the description length
                  overflow:
                      TextOverflow
                          .ellipsis, // Adds ellipsis when the text overflows
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                leading: Icon(Icons.build, color: Colors.blue, size: 30),
                trailing: Icon(Icons.arrow_forward, color: Colors.blue),
                onTap: () {
                  // print("Tapped: ${request.id}");
                  // _maintenanceRequestDetails(
                  //   context,
                  //   request,
                  //   room,
                  //   tenant,
                  //   tenantProfile,
                  // );
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView(
            children: [_buildMaintenanceAssignedRequest(context)],
          ),
        ),
      ),
    );
  }
}
