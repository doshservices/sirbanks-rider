class GetTripDetailModel {
  String duration;
  String distance;
  String lowerEstimate;
  String higherEstimate;
  String durationToRider;
  String distanceToRider;
  List<DriverLocModel> driverLocation;

  GetTripDetailModel({
    this.duration,
    this.distance,
    this.distanceToRider,
    this.driverLocation,
    this.durationToRider,
    this.higherEstimate,
    this.lowerEstimate,
  });
}

class DriverLocModel {
  double long;
  double lat;

  DriverLocModel({ 
    this.lat,
    this.long
  });
}

// {"duration":"1 hour 9 mins","distance":"17.3 km",
    //   "estimatedFare":{"lowerEstimate":1900,"higherEstimate":2100},
    //   "durationToRider":"2 hours 1 min","distanceToRider":"32.9 km",
    //   "drivers":[{"lon":3.251979,"lat":6.6903758}]}