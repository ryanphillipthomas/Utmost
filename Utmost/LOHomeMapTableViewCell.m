//
//  LOHomeMapTableViewCell.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 12/5/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import "LOHomeMapTableViewCell.h"
#import "LOMapLocationData.h"
#import "LOLocation.h"

@implementation LOHomeMapTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupMap]; //todo default to user location

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)configureCell
{
    if ([self listOfLocations].count > 0) {
        [self setUpMapAnnotations];
    }
}

- (NSArray *)listOfLocations
{
    NSArray *locations = [LOLocation MR_findAll];
    return locations;
}


- (CLLocation *)locationForLatitude:(NSString *)latitude longitude:(NSString *)longitude
{
    if (!latitude || !longitude) {
        return nil;
    }
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
    CLLocation *location = [[CLLocation alloc] initWithCoordinate:coordinate
                                                             altitude:100
                                                   horizontalAccuracy:10
                                                     verticalAccuracy:10
                                                            timestamp:[NSDate date]];
    
    return location;
}


- (void)setupMap {
    self.mapView.frame = CGRectMake(10.0f, 10.0f, self.mapView.bounds.size.width - (10.0f * 2), self.mapView.bounds.size.height);
    self.mapView.layer.cornerRadius = 8;
    self.mapView.layer.masksToBounds = YES;
    [self.mapView setDelegate:self];
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
   // NSLog(@"---------- locationManager didUpdateToLocation");
    //location=newLocation.coordinate;
    
    NSLog(@"Location after calibration, user location (%f, %f)", self.mapView.userLocation.coordinate.latitude, self.mapView.userLocation.coordinate.longitude);
    
    if (self.mapViewCamerCenteredInUserLocation) {
        return;
    }
    
    if (self.mapView.userLocation.coordinate.latitude != 0) {
        MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:self.mapView.userLocation.coordinate
                                                         fromEyeCoordinate:self.mapView.userLocation.coordinate
                                                               eyeAltitude:10000];
        
        [self.mapView setCamera:camera animated:YES];
        self.mapViewCamerCenteredInUserLocation = TRUE;
    }
}

- (NSMutableArray *)locationData
{
    NSMutableArray *annotations = [NSMutableArray new];
    if ([self listOfLocations].count > 0) {
        for (LOLocation *mapLocation in [self listOfLocations]) {
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            
            
            CLLocation *location = [self locationForLatitude:mapLocation.latitude
                                                   longitude:mapLocation.longitude];
            
            [annotation setCoordinate:location.coordinate];
            [annotations addObject:annotation];
        }

    }
    
    return annotations;
}

- (void)setUpMapAnnotations
{
    @autoreleasepool {
        
        [self.mapView removeAnnotations:self.mapView.annotations];
        [self.mapView addAnnotations:[self locationData]];
        
        MKPointAnnotation *annotation = [[self locationData] firstObject];
        CLLocationCoordinate2D coordinate = annotation.coordinate;
        
        if (self.locationManager.location.coordinate.latitude != 0) {
            coordinate = self.locationManager.location.coordinate;
        }
        
        MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:coordinate
                                                         fromEyeCoordinate:coordinate
                                                               eyeAltitude:100000];
        
        [self.mapView setCamera:camera animated:NO];
    
        [self.mapView setUserInteractionEnabled:NO];
        
        if (self.mapView) {
            self.mapViewAnnotationsAdded = TRUE;
        }
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.w
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"LOAnnotationView"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"LOAnnotationView"];
            [pinView setPinTintColor:[UIColor colorWithRed:0.094 green:0.682 blue:0.871 alpha:1.00]];
        } else {
            pinView.annotation = annotation;
        }
        
        return pinView;
    }
    
    return nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectItemFromMapCell" object:nil];
}

@end
