//
//  LOActivityPrototype.h
//  Loop
//
//  Created by Ryan Phillip Thomas on 6/26/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LOActivityPrototype : NSObject

/** ENUM defining the different types of activity types that can be derived from a activity */
typedef NS_ENUM(NSInteger, LOActivityType) {
    LOActivityTypeOther,
    LOActivityTypeStrength,
    LOActivityTypeCardio,
    LOActivityTypeFlexibility
};

/** ENUM defining the different types of activity categories that can be derived from a activity */
typedef NS_ENUM(NSInteger, LOActivityCategory) {
    LOActivityCategoryUtilitarian,
    LOActivityCategoryFitness
};

/** ENUM defining the different types of activity locations that can be derived from a activity */
typedef NS_ENUM(NSInteger, LOActivityLocation) {
    LOActivityLocationIndoor,
    LOActivityLocationOutdoor
};

- (NSString *)stringForActivityType:(NSInteger)activityType;
- (NSString *)stringForActivityCategory:(NSInteger)activityCategory;
- (NSString *)stringForActivityLocation:(NSInteger)activityLocation;

@end
