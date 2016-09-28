//
//  LOMapDetailViewController.h
//  Utmost
//
//  Created by Ryan Thomas on 8/12/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LOMapDetailViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic) BOOL mapViewAnnotationsAdded;
@property (nonatomic) BOOL mapViewCamerCenteredInUserLocation;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end
