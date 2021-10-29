class DriverFoundModel {
  String tripId;
  String driverId;
  String pickUp;
  String pickUpLon;
  String dropOff;
  String dropOffLon;
  String distance;
  String duration;
  Map<String, dynamic> estimatedFare;
  String distanceToRider;
  String durationToRider;
  Map<String, dynamic> payment;
  Map<String, dynamic> driverDetails;

  DriverFoundModel({ 
    this.distance,
    this.distanceToRider,
    this.driverDetails,
    this.driverId,
    this.dropOff,
    this.dropOffLon,
    this.duration,
    this.durationToRider,
    this.estimatedFare,
    this.payment,
    this.pickUp,
    this.pickUpLon,
    this.tripId,
  });
}

// {
// ""tripId"": ""new trip id"",
// ""driverId"": ""driver id"",
// ""pickUp"": ""12b MacDonald Omole Phase"",
// ""pickUpLon"": ""11.222"",
// ""pickUpLat"": ""33.666"",
// ""dropOff"": ""HubMart Berga road"",
// ""dropOffLon"": ""22.455"",
// ""dropOffLat"": ""32.455"",
// ""distance"": ""36 km"",
// ""duration"": ""2 hours 27 mins""'
// ""estimatedFare"": {
//      lowerEstimate,
//      higherEstimate
//  },
// ""distanceToRider"": ""21 km"",
// ""durationToRider"": ""22 mins"",
// ""payment"": {
//      ""method"": ""card/cash/wallet"",
//       ""cardId"": ""efe33434dd11/null""
//     }
// ""driverDetails"": {
//     ""driverName"": ""drivers name"",
//     ""avatar"": ""driverprofile pic"",
//     ""phone"": ""0809988009"",
//     ""lon"": ""driver_longitude"",
//     ""lat"": ""driver_latitude""
//     ""vehicleDetails"": {
//           ""make"": ""toyota"",
//           ""model"": ""corolla"",
//           ""year"": ""2015"",
//           ""color"": ""blue"",
//           ""numberPlate"": ""aa-234-fst""
//      }
//   }
// }