//
//  LOFoodPrototype.h
//  Loop
//
//  Created by Ryan Phillip Thomas on 1/16/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LOFoodPrototype : NSObject

/** ENUM defining the different types of food types that can be derived from a food */
typedef NS_ENUM(NSInteger, LOFoodType) {
    LOFoodTypeOther,
    LOFoodTypeRedProtein,
    LOFoodTypeWhiteProtein,
    LOFoodTypeNut,
    LOFoodTypeFruit,
    LOFoodTypeVegetable,
    LOFoodTypePlantProtein
};

/** ENUM defining the different types of food categories that can be derived from a food */
typedef NS_ENUM(NSInteger, LOFoodCategory) {
    LOFoodCategoryConventional,
    LOFoodCategoryLocal,
    LOFoodCategoryVendor,
    LOFoodCategoryOrganic,
    LOFoodCategoryFarmersMarket,
    LOFoodCategoryFarmToTable,
    LOFoodCategoryCSA
};

/** ENUM defining the different types of food locations that can be derived from a food */
typedef NS_ENUM(NSInteger, LOFoodLocation) {
    LOFoodLocationRestaurant,
    LOFoodLocationHome
};

- (NSString *)stringForFoodType:(NSInteger)foodType;
- (NSString *)stringForFoodCategory:(NSInteger)foodCategory;
- (NSString *)stringForFoodCategories:(NSArray *)foodCategories;

- (NSString *)stringForFoodLocation:(NSInteger)foodLocation;

@end
