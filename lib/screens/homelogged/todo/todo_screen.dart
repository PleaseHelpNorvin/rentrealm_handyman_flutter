import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentrealm_handyman_flutter/models/address_model.dart';
import 'package:rentrealm_handyman_flutter/providers/maintenance_request_provider.dart';
import '../../../providers/handy_man_provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  String formatDateTime(String? dateString) {
    if (dateString == null) return 'Not yet assigned';
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy hh:mm a').format(date);
    } catch (e) {
      return dateString; // fallback if error
    }
  }

  Future<void> _refreshData() async {
    print("Refreshing data...");
    await _fetchData();
  }

  Future<void> _fetchData() async {
    // Fetch Handyman data
    await Provider.of<HandyManProvider>(
      context,
      listen: false,
    ).fetchHandyMan(context);

    // Fetch Maintenance Requests
    await Provider.of<MaintenanceRequestProvider>(
      context,
      listen: false,
    ).fetchMaintenanceRequest(context);
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // Access MaintenanceRequestProvider
    final maintenanceRequestProvider = Provider.of<MaintenanceRequestProvider>(
      context,
    );

    // Get the "in-progress" maintenance request
    final inProgressRequest = maintenanceRequestProvider.inProgressRequest;

    List<String> requestImages =
        inProgressRequest?.images is List<String>
            ? List<String>.from(inProgressRequest!.images)
            : [];
    String requestImage = requestImages.isNotEmpty ? requestImages.first : '';
    print("request Image: $requestImage");
    String address =
        "${inProgressRequest?.room?.property?.address.line1 ?? "Unknown line1"}, ${inProgressRequest?.room?.property?.address.line2 ?? "Unknown line2"}, ${inProgressRequest?.room?.property?.address.province ?? "Unknown provice"}, ${inProgressRequest?.room?.property?.address.postalCode ?? "Unknown postalCode"} ";
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0), // Increased padding for better spacing
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Displaying "in-progress" request if available
                if (inProgressRequest != null)
                  Card(
                    // elevation: 5.0, // Card elevation for better visual appeal
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ), // Rounded corners
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                    ), // Margin around card
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // height: 300, // Set fixed height for the image
                            child: CachedNetworkImage(
                              imageUrl: requestImage,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => CircularProgressIndicator(),
                              errorWidget:
                                  (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                          // Divider(),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.assignment,
                                color: Colors.blueAccent,
                              ), // Icon for task
                              SizedBox(width: 10),
                              Text(
                                inProgressRequest.title ?? "No Title",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            inProgressRequest.description ?? "No Description",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 12),
                          Divider(color: Colors.grey[300]), // Separator line
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.person, color: Colors.green),
                              SizedBox(width: 10),
                              Text(
                                "Assigned By: ${inProgressRequest.assignedBy?.name ?? "Unknown"}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.task, color: Colors.green),
                              SizedBox(width: 10),
                              Text(
                                "Assigned at: ${formatDateTime(inProgressRequest.assignedAt) ?? "Unknown"}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.handyman, color: Colors.green),
                              SizedBox(width: 10),
                              Text(
                                "Assisted at: ${formatDateTime(inProgressRequest.assistedAt) ?? "Unknown"}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.bed, color: Colors.blue),
                              SizedBox(width: 10),
                              Text(
                                "Room: ${inProgressRequest.room?.roomCode ?? "Unknown Room"}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.house, color: Colors.orange),
                              SizedBox(width: 10),
                              Text(
                                "find for property: ${inProgressRequest.room?.property?.name}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.room, color: Colors.tealAccent),
                              SizedBox(width: 10),
                              Text(
                                "Address: $address",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 16),
                          // You can add a button here to update the request or take action
                          ElevatedButton(
                            onPressed: () {
                              // Implement action when the button is pressed
                              Provider.of<MaintenanceRequestProvider>(
                                context,
                                listen: false,
                              ).forApproveMaintenanceRequest(
                                context,
                                inProgressRequest.id,
                              );
                              print("Action Complete Request request");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green, // Button color
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                            ),
                            child: Text(
                              'Done? ',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Center(
                    child: Text(
                      "No in-progress request available.",
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
