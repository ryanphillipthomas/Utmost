//
//  LOActivityPrototype.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 6/26/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOActivityPrototype.h"

@implementation LOActivityPrototype

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

@end
