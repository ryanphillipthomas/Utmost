//
//  LOLocation+CoreDataClass.m
//  Utmost
//
//  Created by Ryan Thomas on 8/11/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOLocation.h"

@implementation LOLocation

+ (void)createOrUpdateObject:(NSString *)title
                  locationID:(NSString *)locationID
                     address:(NSString *)address
                    latitude:(NSString *)latitude
                   longitude:(NSString *)longitude
                       image:(NSString *)image
                  completion:(LOSaveCompletionBlock)completionBlock
{
    __block LOLocation *location;
    __block LOLocation *fetchedLocation;
    __block NSString *newLocationID = locationID;
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        @autoreleasepool {
            if (!newLocationID) {
                newLocationID = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
            }
            fetchedLocation = [[LOLocation MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"locationID = %@", newLocationID] inContext:localContext] firstObject];
            
            if (!fetchedLocation) {
                location = [LOLocation MR_createEntityInContext:localContext];
            } else {
                location = [fetchedLocation MR_inContext:localContext];
            }
            
            location.title = [title capitalizedString];
            location.latitude = latitude;
            location.longitude = longitude;
            location.address = address;
            location.locationID = locationID;
            location.image = image;
        }
        
    } completion:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(),^{
            if (completionBlock != nil) completionBlock(YES, nil, nil);
        });
    }];
}

+ (void)deleteObjectWithLocationID:(NSString *)locationID
                        completion:(LOSaveCompletionBlock)completionBlock
{
    __block LOLocation *locationToDelete;
    __block LOLocation *fetchedLocationToDelete;
    
    if (locationID) {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            @autoreleasepool {
                fetchedLocationToDelete = [[LOLocation MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"locationID = %@", locationID] inContext:localContext] firstObject];
                if (fetchedLocationToDelete) {
                    locationToDelete = [localContext objectWithID:fetchedLocationToDelete.objectID];
                    [locationToDelete MR_deleteEntityInContext:localContext];
                } else {
                    // could not delete
                    dispatch_async(dispatch_get_main_queue(),^{
                        if (completionBlock != nil) completionBlock(YES, nil, nil);
                    });
                }
            }
        } completion:^(BOOL success, NSError *error) {
            dispatch_async(dispatch_get_main_queue(),^{
                if (completionBlock != nil) completionBlock(success, nil, error);
            });
        }];
    } else {
        dispatch_async(dispatch_get_main_queue(),^{
            if (completionBlock != nil) completionBlock(YES, nil, nil);
        });
    }
}

@end
