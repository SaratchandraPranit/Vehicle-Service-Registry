import 'package:flutter/material.dart';
import 'service_model.dart';
import '../utils/app_icons.dart';

class ServiceForm extends StatefulWidget {
  final dynamic existingData; // Nullable for new entries
  ServiceForm({this.existingData});

  @override
  _ServiceFormState createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm> {
  TextEditingController vehicleController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  void _saveRecord() async {
    // Validate required fields
    if (vehicleController.text.isEmpty ||
        typeController.text.isEmpty ||
        dateController.text.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Vehicle name, service type, and date are required"),
          ),
        );
      }
      return;
    }

    // Store values locally to avoid accessing controllers after widget disposal
    final String vehicleName = vehicleController.text;
    final String serviceType = typeController.text;
    final String serviceDate = dateController.text;
    final String notes = notesController.text;
    final String? objectId = widget.existingData?.objectId;
    final bool isNewRecord = widget.existingData == null;

    try {
      bool success;
      if (isNewRecord) {
        // Create new record
        print("Creating new record");
        success = await ServiceModel().createServiceRecord(
          vehicleName,
          serviceType,
          serviceDate,
          notes,
        );
      } else {
        // Update existing record
        print("Updating record with ID: $objectId");
        success = await ServiceModel().updateServiceRecord(
          objectId!,
          vehicleName,
          serviceType,
          serviceDate,
          notes,
        );
      }

      // Check if widget is still mounted before updating UI
      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Record saved successfully")));
          Navigator.pop(context, true); // Return true to indicate success
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Failed to save record")));
        }
      }
    } catch (e) {
      print("Error saving record: $e");
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.existingData != null) {
      print(
        "Initializing form with existing data: ${widget.existingData.objectId}",
      );
      try {
        vehicleController.text = widget.existingData.get('vehicleName') ?? '';
        typeController.text = widget.existingData.get('serviceType') ?? '';
        dateController.text = widget.existingData.get('serviceDate') ?? '';
        notesController.text = widget.existingData.get('notes') ?? '';

        print(
          "Loaded data: Vehicle=${vehicleController.text}, Type=${typeController.text}",
        );
      } catch (e) {
        print("Error loading existing data: $e");
      }
    } else {
      print("Creating new record form");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF242526), // Facebook-style dark background
      appBar: AppBar(
        title: Text(
          widget.existingData == null ? "Add Service Record" : "Edit Record",
          style: TextStyle(fontFamily: 'Roboto'),
        ),
        backgroundColor: Color(0xFF1877F2), // Facebook Blue
        leading: IconButton(
          icon: AppIcons.back(color: Colors.white, size: 24.0),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(vehicleController, "Vehicle Name"),
            _buildTextField(typeController, "Service Type"),
            _buildDateField(dateController, "Service Date"),
            _buildTextField(notesController, "Notes"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveRecord,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1877F2), // Facebook Blue
                foregroundColor: Colors.white, // White text
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text(
                "Save",
                style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.black54, // Slightly lighter background for contrast
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        readOnly: true, // Prevent keyboard from appearing
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.black54,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
          suffixIcon: Icon(Icons.date_range, color: Colors.white),
        ),
        style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
            builder: (context, child) {
              return Theme(
                data: ThemeData.dark().copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: Color(0xFF1877F2), // Facebook Blue
                    onPrimary: Colors.white,
                    surface: Color(0xFF242526),
                    onSurface: Colors.white,
                  ),
                  dialogBackgroundColor: Color(0xFF3A3B3C),
                  // Use standard Material icons for date picker
                  iconTheme: IconThemeData(color: Colors.white),
                ),
                child: child!,
              );
            },
          );
          if (picked != null) {
            controller.text =
                "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
          }
        },
      ),
    );
  }
}
