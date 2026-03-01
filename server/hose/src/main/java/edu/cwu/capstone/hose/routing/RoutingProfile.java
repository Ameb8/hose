package edu.cwu.capstone.hose.routing;

public enum RoutingProfile {

    WALK("walking"),
    CAR("driving"),
    BIKE("cycling");

    private final String osrmProfile;

    RoutingProfile(String osrmProfile) {
        this.osrmProfile = osrmProfile;
    }

    public String getOsrmProfile() {
        return osrmProfile;
    }
}