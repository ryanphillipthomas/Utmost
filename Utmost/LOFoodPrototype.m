//
//  LOFoodPrototype.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 1/16/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOFoodPrototype.h"

@implementation LOFoodPrototype

- (NSString *)stringForFoodType:(NSInteger)foodType
{
    switch (foodType) {
        case LOFoodTypeOther:
            return @"Other";
            break;
            
        case LOFoodTypeRedProtein:
            return @"Red Protein";
            break;
            
        case LOFoodTypeWhiteProtein:
            return @"White Protein";
            break;
            
        case LOFoodTypeNut:
            return @"Nut";
            break;
            
        case LOFoodTypeFruit:
            return @"Fruit";
            break;
            
        case LOFoodTypeVegetable:
            return @"Vegetable";
            break;
            
        case LOFoodTypePlantProtein:
            return @"Plant Protein";
            break;
            
        default:
            break;
    }
    
    return @"";
}

- (NSString *)stringForFoodCategory:(NSInteger)foodCategory
{
    switch (foodCategory) {
        case LOFoodCategoryConventional:
            return @"Conventional";
            break;
            
        case LOFoodCategoryLocal:
            return @"Local";
            break;
            
        case LOFoodCategoryVendor:
            return @"Vendor";
            break;
            
        case LOFoodCategoryOrganic:
            return @"Organic";
            break;
            
        case LOFoodCategoryFarmersMarket:
            return @"Farmers Market";
            break;
            
        case LOFoodCategoryFarmToTable:
            return @"Farm To Table";
            break;
            
        case LOFoodCategoryCSA:
            return @"CSA";
            break;
            
        default:
            break;
    }
    
    return @"";
}

- (NSString *)stringForFoodCategories:(NSArray *)foodCategories
{
    NSString *formatString = [NSString new];
    
    for (NSNumber *foodCategory in foodCategories) {
        NSString *newString = [formatString stringByAppendingString:[NSString stringWithFormat:@", %@", [self stringForFoodCategory:[foodCategory integerValue]]]];
        formatString = newString;
    }
    
    return formatString;
}

- (NSString *)stringForFoodLocation:(NSInteger)foodLocation
{
    switch (foodLocation) {
        case LOFoodLocationRestaurant:
            return @"Restaurant";
            break;
            
        case LOFoodLocationHome:
            return @"Home";
            break;
            
        default:
            break;
    }
    
    return @"";
}

@end
