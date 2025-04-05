import 'package:cached_network_image/cached_network_image.dart'; // Import the package
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
    await Provider.of<HandyManProvider>(
      context,
      listen: false,
    ).fetchHandyMan(context);
    await Provider.of<MaintenanceRequestProvider>(
      context,
      listen: false,
    ).fetchMaintenanceRequest(context);
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
                  print("Tapped: ${request.id}");
                  _maintenanceRequestDetails(
                    context,
                    request,
                    room,
                    tenant,
                    tenantProfile,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  void _maintenanceRequestDetails(
    BuildContext context,
    request,
    room,
    tenant,
    tenantProfile,
  ) {
    int requestid = request.id;
    String requestCode = request.ticketCode;
    String roomCode = room.roomCode;
    String tenantName = tenant.name;
    String tenantPhoneNumber = tenantProfile.phoneNumber;
    String requestTitle = request.title;
    String requestProblem = request.description;
    // String requestImage = request.images.toString();
    List<String> requestImages =
        request.images is List<String> ? List<String>.from(request.images) : [];
    String requestImage = requestImages.isNotEmpty ? requestImages.first : '';
    print("request Image: $requestImage");
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fixed header (Row)
              Row(
                children: [
                  Text(
                    "Maintenance Request Details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      print(
                        "requesting for maintenance request(): ${request.id}",
                      );
                      Provider.of<MaintenanceRequestProvider>(
                        context,
                        listen: false,
                      ).acceptMaintenanceRequest(context, requestid);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text("Request"),
                  ),
                ],
              ),
              SizedBox(height: 8),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow("Request ID:", requestid.toString()),
                      _buildDetailRow("Request Code:", requestCode),
                      _buildDetailRow("Room:", roomCode),
                      _buildDetailRow("Requester Name:", tenantName),
                      _buildDetailRow("Requester Number:", tenantPhoneNumber),
                      Divider(),
                      _buildDetailRow("Request Title: ", requestTitle),
                      _buildDetailRow("Problem:", requestProblem),
                      Divider(),

                      // Image section
                      requestImage.isNotEmpty
                          ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Image:"),
                              SizedBox(height: 8),
                              Container(
                                // height: 300, // Set fixed height for the image
                                child: CachedNetworkImage(
                                  imageUrl: requestImage,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder:
                                      (context, url) =>
                                          CircularProgressIndicator(),
                                  errorWidget:
                                      (context, url, error) =>
                                          Icon(Icons.error),
                                ),
                              ),
                            ],
                          )
                          : _buildDetailRow("Image:", "No image available"),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: RefreshIndicator(
          onRefresh: _refreshData, // Trigger refresh when pull down
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
