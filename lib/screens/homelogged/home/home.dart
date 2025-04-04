import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentrealm_handyman_flutter/providers/maintenance_request_provider.dart';

import '../../../models/maintenance_request_model.dart';
import '../../../providers/handy_man_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Initial data fetch
    _fetchData();
  }

  // Method to refresh data
  Future<void> _refreshData() async {
    print("Refreshing data...");
    await _fetchData();
  }

  // Helper method to fetch data from providers
  Future<void> _fetchData() async {
    await Provider.of<HandyManProvider>(context, listen: false).fetchHandyMan(context);
    await Provider.of<MaintenanceRequestProvider>(context, listen: false).fetchMaintenanceRequest(context);
  }

  Widget _buildHandymanInformationCard(BuildContext context) {
    return Consumer<HandyManProvider>(
      builder: (context, handymanProvider, child) {
        final handyman = handymanProvider.handyman;

        if (handyman == null) {
          return Center(child: CircularProgressIndicator());
        }

        return Card(
          child: Container(
            width: double.infinity, 
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Text("Name: ${handyman.user?.name}"),
                Text("Status: ${handyman.status}"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMaintenancePendingRequest(BuildContext context) {
    return Consumer<MaintenanceRequestProvider>(
      builder: (context, maintenanceRequestProvider, child) {
        final maintenanceRequests = maintenanceRequestProvider.pendingRequests;

        // If data is loading
        if (maintenanceRequestProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        // If no pending requests
        if (maintenanceRequests.isEmpty) {
          return Center(child: Text("No pending requests"));
        }

        return ListView.builder(
          shrinkWrap: true, // This allows ListView to behave like a normal scrollable inside the RefreshIndicator
          itemCount: maintenanceRequests.length,
          itemBuilder: (context, index) {
            MaintenanceRequest request = maintenanceRequests[index]!;

            return Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(request.title),
                subtitle: Text(request.description),
                leading: Icon(Icons.build),
                trailing: Icon(Icons.arrow_forward),
                // onTap: () {
                //   Navigator.pushNamed(context, '/maintenanceRequestDetails', arguments: request);
                // },
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
          onRefresh: _refreshData,  // Trigger refresh when pull down
          child: ListView(
            children: [
              Text("Dashboard"),
              _buildHandymanInformationCard(context),
              Text("Maintenance Requests (pending)"),
              _buildMaintenancePendingRequest(context),
            ],
          ),
        ),
      ),
    );
  }
}
