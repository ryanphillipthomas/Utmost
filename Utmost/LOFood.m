//
//  LOFood.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 12/12/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import "LOItem.h"
#import "LOFood.h"

@implementation LOFood

+(void)createOrUpdateObject:(NSString *)name
                       type:(enum LOFoodType)type
                   categories:(NSObject *)categories
                     location:(enum LOFoodLocation)location
                     mediaURL:(NSString *)mediaURL
                         date:(NSDate *)date
                 rootItemID:(NSString *)rootItemID
                   completion:(LOSaveCompletionBlock)completionBlock
{
    __block LOFood *food;
    __block LOFood *fetchedFood;
    __block LOItem *item;
    __block LOItem *fetchedItem;
    __block LORootItem *rootItem;
    __block LORootItem *fetchedRootItem;
    __block NSDate *foodDate = date;
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        @autoreleasepool {
            if (!foodDate) {
                foodDate = [NSDate date];
            }
            fetchedFood = [[LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"date = %@", foodDate] inContext:localContext] firstObject];
            
            fetchedItem = [[LOItem MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"date = %@", foodDate] inContext:localContext] firstObject];
            
            fetchedRootItem = [[LORootItem MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"rootItemID = %@", rootItemID] inContext:localContext] firstObject];

            if (!fetchedFood) {
                food = [LOFood MR_createEntityInContext:localContext];
            } else {
                food = [fetchedFood MR_inContext:localContext];
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
            
            food.name = [name capitalizedString];
            food.type = [NSNumber numberWithInteger:(LOFoodType)type];
            food.categories = [NSArray arrayWithArray:(NSArray *)categories];
            food.location = [NSNumber numberWithInteger:(LOFoodLocation)location];
            food.mediaURL = mediaURL;
            food.date = foodDate;
            food.stringDate = [self stringDateForDate:foodDate];
            
            if (nil == item.date) {
                item.date = foodDate;
                item.stringDate = [self stringDateForDate:foodDate];
            }
            
            if (nil == item.sectionDate) {
                item.sectionDate = [self sectionDateForItem:foodDate];
            }
            
            if (nil == food.item) {
                [food setItem:item];
            }
            
            if (nil == food.rootItem) {
                [food setRootItem:rootItem];
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
    
    __block LOFood *foodToDelete;
    __block LOFood *fetchedFoodToDelete;
    
    if (date) {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            @autoreleasepool {
                fetchedFoodToDelete = [[LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"date = %@", date] inContext:localContext] firstObject];
                if (fetchedFoodToDelete) {
                    foodToDelete = [localContext objectWithID:fetchedFoodToDelete.objectID];
                    [foodToDelete MR_deleteEntityInContext:localContext];
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

- (NSString *)stringForFoodCategories:(NSArray *)foodCategories
{
    NSString *formatString = [NSString new];
    
    for (NSNumber *foodCategory in foodCategories) {
        NSString *newString = [formatString stringByAppendingString:[NSString stringWithFormat:@"%@, ", [self stringForFoodCategory:[foodCategory integerValue]]]];
        formatString = newString;
    }
    
    return formatString;
}


+ (NSString *)stringDateForDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE MMM d yyyy"];
    
   return [dateFormatter stringFromDate:date];
    
}

- (NSInteger )baseHealthValue {
    NSInteger baseHealthValue = 0;
    NSArray *array = (NSArray *)self.categories;
    for (NSNumber *foodCategory in array) {
        if (foodCategory.integerValue == LOFoodCategoryConventional) {
            baseHealthValue += 1;
        } else if (foodCategory.integerValue == LOFoodCategoryLocal) {
            baseHealthValue += 2;
        } else if (foodCategory.integerValue == LOFoodCategoryVendor) {
            baseHealthValue += 3;
        } else if (foodCategory.integerValue == LOFoodCategoryOrganic) {
            baseHealthValue += 4;
        } else if (foodCategory.integerValue == LOFoodCategoryFarmersMarket) {
            baseHealthValue += 6;
        } else if (foodCategory.integerValue == LOFoodCategoryFarmToTable) {
            baseHealthValue += 7;
        } else if (foodCategory.integerValue == LOFoodCategoryCSA) {
            baseHealthValue += 8;
        }
    }
    
    
    if (self.type.integerValue == LOFoodTypeOther) {
        baseHealthValue += 0;
    } else if (self.type.integerValue == LOFoodTypeRedProtein) {
        baseHealthValue += 1;
    } else if (self.type.integerValue == LOFoodTypeNut) {
        baseHealthValue += 2;
    } else if (self.type.integerValue == LOFoodTypeWhiteProtein) {
        baseHealthValue += 3;
    } else if (self.type.integerValue == LOFoodTypeFruit) {
        baseHealthValue += 3;
    } else if (self.type.integerValue == LOFoodTypeVegetable) {
        baseHealthValue += 6;
    } else if (self.type.integerValue == LOFoodTypePlantProtein) {
        baseHealthValue += 7;
    }
    
    
    if (self.location.integerValue == LOFoodLocationRestaurant) {
        baseHealthValue += 0;
    } else if (self.location.integerValue == LOFoodLocationHome) {
        baseHealthValue += 5;
    }

    return baseHealthValue;
}

- (NSInteger )baseEnvironmentValue {
    NSInteger baseEnvironmentValue = 0;
    NSArray *array = (NSArray *)self.categories;
    
    for (NSNumber *foodType in array) {
        if (foodType.integerValue == LOFoodCategoryConventional) {
            baseEnvironmentValue += 1;
        } else if (foodType.integerValue == LOFoodCategoryLocal) {
            baseEnvironmentValue += 2;
        } else if (foodType.integerValue == LOFoodCategoryVendor) {
            baseEnvironmentValue += 3;
        } else if (foodType.integerValue == LOFoodCategoryOrganic) {
            baseEnvironmentValue += 4;
        } else if (foodType.integerValue == LOFoodCategoryFarmersMarket) {
            baseEnvironmentValue += 7;
        } else if (foodType.integerValue == LOFoodCategoryFarmToTable) {
            baseEnvironmentValue += 9;
        } else if (foodType.integerValue == LOFoodCategoryCSA) {
            baseEnvironmentValue += 9;
        }
    }
    
    
    if (self.type.integerValue == LOFoodTypeOther) {
        baseEnvironmentValue += 0;
    } else if (self.type.integerValue == LOFoodTypeRedProtein) {
        baseEnvironmentValue += 1;
    } else if (self.type.integerValue == LOFoodTypeNut) {
        baseEnvironmentValue += 2;
    } else if (self.type.integerValue == LOFoodTypeWhiteProtein) {
        baseEnvironmentValue += 3;
    } else if (self.type.integerValue == LOFoodTypeFruit) {
        baseEnvironmentValue += 6;
    } else if (self.type.integerValue == LOFoodTypeVegetable) {
        baseEnvironmentValue += 7;
    } else if (self.type.integerValue == LOFoodTypePlantProtein) {
        baseEnvironmentValue += 8;
    }
    
    
    if (self.location.integerValue == LOFoodLocationRestaurant) {
        baseEnvironmentValue += 0;
    } else if (self.location.integerValue == LOFoodLocationHome) {
        baseEnvironmentValue += 5;
    }
    
    return baseEnvironmentValue;
}


@end
