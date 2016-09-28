//
//  LOActivity.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 6/26/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOActivity.h"
#import "LOItem.h"

@implementation LOActivity

// Insert code here to add functionality to your managed object subclass
+(void)createOrUpdateObject:(NSString *)name
                       type:(enum LOActivityType)type
                   category:(enum LOActivityCategory)category
                   location:(enum LOActivityLocation)location
                   mediaURL:(NSString *)mediaURL
                       date:(NSDate *)date
                 rootItemID:(NSString *)rootItemID
                 completion:(LOSaveCompletionBlock)completionBlock
{
    __block LOActivity *activity;
    __block LOActivity *fetchedActivity;
    __block LOItem *item;
    __block LOItem *fetchedItem;
    __block LORootItem *rootItem;
    __block LORootItem *fetchedRootItem;
    __block NSDate *activityDate = date;
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        @autoreleasepool {
            if (!activityDate) {
                activityDate = [NSDate date];
            }
            
            fetchedActivity = [[LOActivity MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"date = %@", activityDate] inContext:localContext] firstObject];
            
            fetchedItem = [[LOItem MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"date = %@", activityDate] inContext:localContext] firstObject];
            
            fetchedRootItem = [[LORootItem MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"rootItemID = %@", rootItemID] inContext:localContext] firstObject];


            if (!fetchedActivity) {
                activity = [LOActivity MR_createEntityInContext:localContext];
            } else {
                activity = [fetchedActivity MR_inContext:localContext];
            }
            
            if (!fetchedItem) {
                item = [LOItem MR_createEntityInContext:localContext];
            } else {
                item = [fetchedItem MR_inContext:localContext];
            }
            
            if (!fetchedRootItem) {
                rootItem = [LORootItem MR_createEntityInContext:localContext];
            } else {
                rootItem = [fetchedRootItem MR_inContext:localContext];
            }
            
            activity.name = [name capitalizedString];
            activity.type = [NSNumber numberWithInteger:(LOActivityType)type];
            activity.category = [NSNumber numberWithInteger:(LOActivityCategory)category];
            activity.location = [NSNumber numberWithInteger:(LOActivityLocation)location];
            activity.mediaURL = mediaURL;
            activity.date = activityDate;
            activity.stringDate = [self stringDateForDate:activityDate];
            
            if (nil == item.date) {
                item.date = activityDate;
                item.stringDate = [self stringDateForDate:activityDate];
            }
            
            if (nil == item.sectionDate) {
                item.sectionDate = [self sectionDateForItem:activityDate];
            }
            
            if (nil == activity.item) {
                [activity setItem:item];
            }
            
            if (nil == activity.rootItem) {
                [activity setRootItem:rootItem];
            }
        }
        
    } completion:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(),^{
            if (completionBlock != nil) completionBlock(YES, nil, nil);
        });
    }];
}

+ (NSDate *)sectionDateForItem:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    [components setHour:0];
    
    return [calendar dateFromComponents:components];
}

+ (void)deleteObjectWithDate:(NSDate *)date
                  completion:(LOSaveCompletionBlock)completionBlock; {
    
    __block LOActivity *activityToDelete;
    __block LOActivity *fetchedActivityToDelete;
    
    if (date) {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            @autoreleasepool {
                fetchedActivityToDelete = [[LOActivity MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"date = %@", date] inContext:localContext] firstObject];
                if (fetchedActivityToDelete) {
                    activityToDelete = [localContext objectWithID:fetchedActivityToDelete.objectID];
                    [activityToDelete MR_deleteEntityInContext:localContext];
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

- (NSString *)stringForActivityType:(NSInteger)activityType
{
    
    switch (activityType) {
        case LOActivityTypeOther:
            return @"Other";
            break;
            
        case LOActivityTypeStrength:
            return @"Strength";
            break;
            
        case LOActivityTypeCardio:
            return @"Cardio";
            break;
            
        case LOActivityTypeFlexibility:
            return @"Flexibility";
            break;
            
        default:
            break;
    }
    
    return @"";
}

- (NSString *)stringForActivityCategory:(NSInteger)activityCategory
{
    
    switch (activityCategory) {
        case LOActivityCategoryUtilitarian:
            return @"Utilitarian";
            break;
            
        case LOActivityCategoryFitness:
            return @"Fitness";
            break;
            
        default:
            break;
    }
    
    return @"";
}

- (NSString *)stringForActivityLocation:(NSInteger)activityLocation
{
    switch (activityLocation) {
        case LOActivityLocationIndoor:
            return @"Indoor";
            break;
            
        case LOActivityLocationOutdoor:
            return @"Outdoor";
            break;
            
        default:
            break;
    }
    
    return @"";
}

+ (NSString *)stringDateForDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE MMM d yyyy"];
    
    return [dateFormatter stringFromDate:date];
}


- (NSInteger )baseHealthValue {
    NSInteger baseHealthValue = 0;
    NSNumber *category = self.category;
    
     if (category.integerValue == LOActivityCategoryUtilitarian) {
        baseHealthValue += 1;
    } else if (category.integerValue == LOActivityCategoryFitness) {
        baseHealthValue += 2;
    }
    
    if (self.type.integerValue == LOActivityTypeOther) {
        baseHealthValue += 0;
    } else if (self.type.integerValue == LOActivityTypeCardio) {
        baseHealthValue += 1;
    } else if (self.type.integerValue == LOActivityTypeStrength) {
        baseHealthValue += 2;
    } else if (self.type.integerValue == LOActivityTypeFlexibility) {
        baseHealthValue += 2;
    }
    
    
     if (self.location.integerValue == LOActivityLocationIndoor) {
        baseHealthValue += 1;
    } else if (self.location.integerValue == LOActivityLocationOutdoor)  {
        baseHealthValue += 2;
    }
    
    return baseHealthValue;
}

- (NSInteger )baseEnvironmentValue {
    NSInteger baseEnvironmentValue = 0;
    NSNumber *category = self.category;
    
    if (category.integerValue == LOActivityCategoryUtilitarian) {
        baseEnvironmentValue += 3;
    } else if (category.integerValue == LOActivityCategoryFitness) {
        baseEnvironmentValue += 2;
    }
    
    if (self.type.integerValue == LOActivityTypeOther) {
        baseEnvironmentValue += 0;
    } else if (self.type.integerValue == LOActivityTypeCardio) {
        baseEnvironmentValue += 1;
    } else if (self.type.integerValue == LOActivityTypeStrength) {
        baseEnvironmentValue += 2;
    } else if (self.type.integerValue == LOActivityTypeFlexibility) {
        baseEnvironmentValue += 2;
    }
    
    
    if (self.location.integerValue == LOActivityLocationIndoor) {
        baseEnvironmentValue += 1;
    } else if (self.location.integerValue == LOActivityLocationOutdoor)  {
        baseEnvironmentValue += 3;
    }
    
    return baseEnvironmentValue;
}

@end
