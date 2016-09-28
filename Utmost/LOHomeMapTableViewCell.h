//
//  LOHomeMapTableViewCell.h
//  Loop
//
//  Created by Ryan Phillip Thomas on 12/5/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LOHomeMapTableViewCell : UITableViewCell <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic) BOOL mapViewAnnotationsAdded;
@property (nonatomic) BOOL mapViewCamerCenteredInUserLocation;
@property (nonatomic, strong) CLLocationManager *locationManager;


- (void)configureCell;


@end
