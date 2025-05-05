import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ServiceModel {
  Future<bool> createServiceRecord(
    String vehicleName,
    String serviceType,
    String date,
    String notes,
  ) async {
    final serviceRecord =
        ParseObject('ServiceRecords')
          ..set('vehicleName', vehicleName)
          ..set('serviceType', serviceType)
          ..set('serviceDate', date)
          ..set('notes', notes);
    var response = await serviceRecord.save();
    return response.success;
  }

  Future<List<ParseObject>> getServiceRecords() async {
    var query = QueryBuilder(ParseObject('ServiceRecords'));
    var response = await query.query();

    if (response.success && response.results != null) {
      return List<ParseObject>.from(
        response.results!,
      ); // Explicitly cast to List<ParseObject>
    } else {
      return [];
    }
  }

  Future<bool> updateServiceRecord(
    String objectId,
    String vehicleName,
    String serviceType,
    String date,
    String notes,
  ) async {
    try {
      final serviceRecord = ParseObject('ServiceRecords')..objectId = objectId;

      // Set the updated values
      serviceRecord.set('vehicleName', vehicleName);
      serviceRecord.set('serviceType', serviceType);
      serviceRecord.set('serviceDate', date);
      serviceRecord.set('notes', notes);

      // Save the updated object
      var response = await serviceRecord.save();
      print(
        "Update response: ${response.success}, Error: ${response.error?.message}",
      );
      return response.success;
    } catch (e) {
      print("Error updating record: $e");
      return false;
    }
  }

  Future<bool> deleteServiceRecord(String objectId) async {
    final serviceRecord = ParseObject('ServiceRecords')..objectId = objectId;
    var response = await serviceRecord.delete();
    return response.success;
  }
}
