//
//  LOMapDetailViewController.m
//  Utmost
//
//  Created by Ryan Thomas on 8/12/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOMapDetailViewController.h"
#import "LOLocation.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface LOMapDetailViewController ()

@end

@implementation LOMapDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [self closeButtonItem];
    
    [self setupMap]; //todo default to user location
    [self setUpMapAnnotations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setShowsPointsOfInterest:YES];
    [self.mapView setShowsScale:YES];
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
            
            annotation.title = mapLocation.title;
            annotation.subtitle = mapLocation.address;
            
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
        [self.mapView setUserInteractionEnabled:YES];
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
            [pinView setCanShowCallout:YES];
            [pinView setPinTintColor:[UIColor colorWithRed:0.094 green:0.682 blue:0.871 alpha:1.00]];
            
            // Add a detail disclosure button to the callout.
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            pinView.rightCalloutAccessoryView = rightButton;
        } else {
            pinView.annotation = annotation;
        }
        
        return pinView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(nonnull MKAnnotationView *)view
{
    if (![view.annotation isKindOfClass:[MKUserLocation class]]) {
        // Add an image to the left callout.
        LOLocation *fetchedLocation = [[LOLocation MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"title = %@", view.annotation.title]] firstObject];
        
        UIImageView *iconView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, view.frame.size.height- 10, view.frame.size.height -10)];
        iconView.contentMode = UIViewContentModeScaleAspectFit;
        [iconView sd_setImageWithURL:[NSURL URLWithString:fetchedLocation.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
        view.leftCalloutAccessoryView = iconView;
    }
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    id <MKAnnotation> annotation = [view annotation];
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        [self displayDirectionsAlertForAnnotation:view];
    }
}

- (void)displayDirectionsAlertForAnnotation:(MKAnnotationView *)annView
{
    id <MKAnnotation> annotation = [annView annotation];

    UIAlertController *view = [UIAlertController
                               alertControllerWithTitle:@"Directions"
                               message:[NSString stringWithFormat:@"Would you like to get directions to %@?", annotation.title]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    UIAlertAction *ok = [UIAlertAction
                         actionWithTitle:@"Ok"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [self directionsButtonPressed:annView];
                             
                         }];
    
    [view addAction:cancel];
    [view addAction:ok];
    
    [self presentViewController:view animated:YES completion:nil];
}

- (void)directionsButtonPressed:(MKAnnotationView *)annView
{
    id <MKAnnotation> annotation = [annView annotation];

    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:annotation.coordinate
                                                   addressDictionary:nil];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 10000, 10000);
    [MKMapItem openMapsWithItems:@[mapItem]
                   launchOptions:@{MKLaunchOptionsMapCenterKey : [NSValue valueWithMKCoordinate:region.center],
                                   MKLaunchOptionsMapSpanKey : [NSValue valueWithMKCoordinateSpan:region.span]}];
}



- (UIBarButtonItem *)closeButtonItem
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                         target:self
                                                         action:@selector(closeView:)];
}

- (void)closeView:(id)selector
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
