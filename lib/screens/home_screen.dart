import 'package:flutter/material.dart';
import 'service_model.dart';
import 'auth_service.dart';
import '../utils/app_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> records = [];

  Future<void> _fetchRecords() async {
    var data = await ServiceModel().getServiceRecords();
    setState(() => records = data);
  }

  void _logout(BuildContext context) async {
    await AuthService().logout();
    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  void initState() {
    super.initState();
    _fetchRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF242526), // Facebook-style dark background
      appBar: AppBar(
        title: Text(
          "Vehicle Service Records",
          style: TextStyle(fontFamily: 'Roboto'),
        ),
        backgroundColor: Color(0xFF1877F2), // Facebook Blue
        leading: IconButton(
          icon: AppIcons.back(color: Colors.white, size: 24.0),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: AppIcons.logout(color: Colors.white),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body:
          records.isEmpty
              ? Center(
                child: Text(
                  "No service records found.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Roboto',
                  ),
                ),
              )
              : RefreshIndicator(
                onRefresh: () async {
                  await _fetchRecords();
                },
                child: ListView.builder(
                  itemCount: records.length,
                  itemBuilder: (context, index) {
                    var record = records[index];
                    return Card(
                      color: Color(0xFF3A3B3C), // Facebook dark card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          record.get('vehicleName'),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        subtitle: Text(
                          "${record.get('serviceType')} - ${record.get('serviceDate')}",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontFamily: 'Roboto',
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: AppIcons.edit(color: Colors.white),
                              onPressed: () async {
                                await Navigator.pushNamed(
                                  context,
                                  "/edit",
                                  arguments: record,
                                );
                                _fetchRecords(); // Refresh after returning from edit screen
                              },
                            ),
                            IconButton(
                              icon: AppIcons.delete(color: Colors.red),
                              onPressed: () async {
                                // Show confirmation dialog
                                bool confirm =
                                    await showDialog(
                                      context: context,
                                      builder:
                                          (context) => AlertDialog(
                                            backgroundColor: Color(0xFF3A3B3C),
                                            title: Text(
                                              "Confirm Delete",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            content: Text(
                                              "Are you sure you want to delete this service record?",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onPressed:
                                                    () => Navigator.pop(
                                                      context,
                                                      false,
                                                    ),
                                              ),
                                              TextButton(
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                onPressed:
                                                    () => Navigator.pop(
                                                      context,
                                                      true,
                                                    ),
                                              ),
                                            ],
                                          ),
                                    ) ??
                                    false;

                                if (confirm) {
                                  bool success = await ServiceModel()
                                      .deleteServiceRecord(record.objectId);
                                  if (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Record deleted successfully",
                                        ),
                                      ),
                                    );
                                    _fetchRecords(); // Refresh the list
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Failed to delete record",
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF1877F2), // Facebook Blue
        onPressed: () async {
          await Navigator.pushNamed(context, "/add");
          _fetchRecords(); // Refresh after adding a new record
        },
        child: AppIcons.add(color: Colors.white),
      ),
    );
  }
}
