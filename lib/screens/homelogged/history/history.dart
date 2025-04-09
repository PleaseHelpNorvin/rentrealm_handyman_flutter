import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/maintenance_request_model.dart';
import '../../../providers/handy_man_provider.dart';
import '../../../providers/maintenance_request_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  String formatDateTime(String? dateString) {
    if (dateString == null) return 'Not yet assigned';
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy hh:mm a').format(date);
    } catch (e) {
      return dateString; // fallback if error
    }
  }

  @override
  void initState() {
    super.initState();
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

  Widget _buildMaintenanceCompletedRequest(BuildContext context) {
    return Consumer<MaintenanceRequestProvider>(
      builder: (context, maintenanceRequestProvider, child) {
        final maintenanceRequests =
            maintenanceRequestProvider.completedRequests;

        // If data is loading
        if (maintenanceRequestProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        // If no assigned requests
        if (maintenanceRequests.isEmpty) {
          return Center(child: Text("No requests"));
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
    String assignedBy = request.assignedBy?.name;
    String assignedAt = request.assignedAt;
    String assistedAt = request.assistedAt;
    String approvedBy = request.approvedBy?.name;
    String approvedAt = request.approvedAt;
    String completedAt = request.completedAt;
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
                    "Request Details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () async {
                      print("Completed request${request.id}");
                      // await Provider.of<MaintenanceRequestProvider>(
                      //   context,
                      //   listen: false,
                      // ).startMaintenanceRequest(context, requestid);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
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
                    child: Text("Completed!"),
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
                      _buildDetailRow("Assigned By:", assignedBy),
                      _buildDetailRow(
                        "Assigned At:",
                        formatDateTime(assignedAt),
                      ),
                      _buildDetailRow(
                        "Assisted At:",
                        formatDateTime(assistedAt),
                      ),
                      _buildDetailRow(
                        "Completed At:",
                        formatDateTime(completedAt),
                      ),
                      _buildDetailRow(
                        "Approved By:",
                        formatDateTime(approvedBy),
                      ),
                      _buildDetailRow(
                        "Approved At:",
                        formatDateTime(approvedAt),
                      ),
                      Divider(),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
            softWrap: true,
          ),
          SizedBox(width: 8),
          Expanded(child: Text(value, softWrap: true)),
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
          onRefresh: _refreshData,
          child: ListView(
            children: [_buildMaintenanceCompletedRequest(context)],
          ),
        ),
      ),
    );
  }
}
