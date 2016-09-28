//
//  LOScore.m
//  Utmost
//
//  Created by Ryan Thomas on 8/19/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//
#import "LOItem.h"
#import "LORootItem.h"
#import "LOFood.h"
#import "LOActivity.h"
#import "LOScore.h"
#import "NSDate+Utilities.h"

@implementation LOScore

+ (id)sharedManager
{
    static dispatch_once_t pred;
    static LOScore *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[LOScore alloc] init];
    });
    return shared;
}

- (NSInteger )daysLeftInWeek
{
    NSInteger daysLeft = 0;
    for (int i = 0; i < 7; ++i) {
        if ([[NSDate dateWithDaysFromNow:i] isThisWeek]) {
            ++daysLeft;
        }
    }
    
    return daysLeft;
}

- (CGFloat )homeLastWeekVSThisWeekHealthAndEnvironmentMaxValue_ThisWeek
{
    NSInteger maxScore = [self movementHealthAndEnvironmentThisWeekMaxValue] + [self nutritionHealthAndEnvironmentThisWeekMaxValue];
    
    return maxScore;
}

- (CGFloat )homeLastWeekVSThisWeekHealthAndEnvironmentMaxValue_LastWeek
{
    NSInteger maxScore = [self movementHealthAndEnvironmentLastWeekMaxValue] + [self nutritionHealthAndEnvironmentLastWeekMaxValue];
    
    return maxScore;
}

- (CGFloat )movementHealthAndEnvironmentThisWeekMaxValue
{
    //max health per item = 10 taken from LOActivity
    //max environment per item = 20 taken from LOActivity
    
    NSInteger maxScore = 75;
    
    return [[NSNumber numberWithInteger:maxScore] floatValue];
}

- (CGFloat )nutritionHealthAndEnvironmentThisWeekMaxValue
{
        //max health per item = 20 taken from LOFood
        //max environment per item = 22 taken from LOFood

    NSInteger maxScore = 1080;

    return [[NSNumber numberWithInteger:maxScore] floatValue];
}

- (CGFloat )movementHealthAndEnvironmentLastWeekMaxValue
{
    //max health per item = 10 taken from LOActivity
    //max environment per item = 20 taken from LOActivity
    
    NSInteger maxScore = 75;
    
    return [[NSNumber numberWithInteger:maxScore] floatValue];
}

- (CGFloat )nutritionHealthAndEnvironmentLastWeekMaxValue
{
    //max health per item = 20 taken from LOFood
    //max environment per item = 22 taken from LOFood
    
    NSInteger maxScore = 1080;
    
    return [[NSNumber numberWithInteger:maxScore] floatValue];
}

- (CGFloat )lifestyleHealthAndEnvironmentThisWeekMaxValue
{
    return 100.0f;
}

- (CGFloat )lifestyleHealthAndEnvironmentLastWeekMaxValue
{
    return 100.0f;
}

- (CGFloat )movementQuantitiesMaxValue
{
    NSArray *rootValues = @[[NSNumber numberWithFloat:[self movementSourcingOtherMaxValue]],
                            [NSNumber numberWithFloat:[self movementSourcingStrengthMaxValue]],
                            [NSNumber numberWithFloat:[self movementSourcingCardioMaxValue]],
                            [NSNumber numberWithFloat:[self movementSourcingFlexibilityMaxValue]]];
    
    NSNumber *higestPossibleMax = @0;
    
    for (NSNumber *number in rootValues) {
        if (number.floatValue != 100.0f) {
            if (number.floatValue > higestPossibleMax.floatValue) {
                higestPossibleMax = [NSNumber numberWithFloat:number.floatValue];
            }
        }
    }
    
    return higestPossibleMax.floatValue;
}

- (CGFloat )nutritionQuantitiesMaxValue
{
    NSArray *rootValues = @[[NSNumber numberWithFloat:[self nutritionSourcingOtherMaxValue]],
                            [NSNumber numberWithFloat:[self nutritionSourcingRedProteinMaxValue]],
                            [NSNumber numberWithFloat:[self nutritionSourcingWhiteProteinMaxValue]],
                            [NSNumber numberWithFloat:[self nutritionSourcingNutMaxValue]],
                            [NSNumber numberWithFloat:[self nutritionSourcingFruitMaxValue]],
                            [NSNumber numberWithFloat:[self nutritionSourcingVegetableMaxValue]],
                            [NSNumber numberWithFloat:[self nutritionSourcingVegetableProteinMaxValue]]];
    
    NSNumber *higestPossibleMax = @0;
    
    for (NSNumber *number in rootValues) {
        if (number.floatValue != 100.0f) {
            if (number.floatValue > higestPossibleMax.floatValue) {
                higestPossibleMax = [NSNumber numberWithFloat:number.floatValue];
            }
        }
    }
    
    return higestPossibleMax.floatValue;
}

- (CGFloat )lifestyleQuantitiesMaxValue
{
    return 100.0f;
}

- (CGFloat )movementSourcingOtherMaxValue
{
    NSArray *rootItems = [LORootItem MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"baseActivityType = %li", (long)LOActivityTypeOther]]];
    
    NSNumber *higestPossibleMax = @0;
    
    for (LORootItem *rootItem in rootItems) {
        if (rootItem.healthFrequencyLimit.integerValue > higestPossibleMax.integerValue) {
            higestPossibleMax = [NSNumber numberWithInteger:rootItem.healthFrequencyLimit.integerValue];
        }
    }
    
    return higestPossibleMax.floatValue;
}

- (CGFloat )movementSourcingStrengthMaxValue
{
    NSArray *rootItems = [LORootItem MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"baseActivityType = %li", (long)LOActivityTypeStrength]]];
    
    NSNumber *higestPossibleMax = @0;
    
    for (LORootItem *rootItem in rootItems) {
        if (rootItem.healthFrequencyLimit.integerValue > higestPossibleMax.integerValue) {
            higestPossibleMax = [NSNumber numberWithInteger:rootItem.healthFrequencyLimit.integerValue];
        }
    }
    
    return higestPossibleMax.floatValue;
}

- (CGFloat )movementSourcingCardioMaxValue
{
    NSArray *rootItems = [LORootItem MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"baseActivityType = %li", (long)LOActivityTypeCardio]]];
    
    NSNumber *higestPossibleMax = @0;
    
    for (LORootItem *rootItem in rootItems) {
        if (rootItem.healthFrequencyLimit.integerValue > higestPossibleMax.integerValue) {
            higestPossibleMax = [NSNumber numberWithInteger:rootItem.healthFrequencyLimit.integerValue];
        }
    }
    
    return higestPossibleMax.floatValue;
}

- (CGFloat )movementSourcingFlexibilityMaxValue
{
    NSArray *rootItems = [LORootItem MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"baseActivityType = %li", (long)LOActivityTypeFlexibility]]];
    
    NSNumber *higestPossibleMax = @0;
    
    for (LORootItem *rootItem in rootItems) {
        if (rootItem.healthFrequencyLimit.integerValue > higestPossibleMax.integerValue) {
            higestPossibleMax = [NSNumber numberWithInteger:rootItem.healthFrequencyLimit.integerValue];
        }
    }
    
    return higestPossibleMax.floatValue;
}

- (CGFloat )nutritionSourcingOtherMaxValue
{
    NSArray *rootItems = [LORootItem MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"baseFoodType = %li", (long)LOFoodTypeOther]]];
    
    NSNumber *higestPossibleMax = @0;
    
    for (LORootItem *rootItem in rootItems) {
        if (rootItem.healthFrequencyLimit.integerValue > higestPossibleMax.integerValue) {
            higestPossibleMax = [NSNumber numberWithInteger:rootItem.healthFrequencyLimit.integerValue];
        }
    }
    
    return higestPossibleMax.floatValue;
}

- (CGFloat )nutritionSourcingRedProteinMaxValue
{
    NSArray *rootItems = [LORootItem MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"baseFoodType = %li", (long)LOFoodTypeRedProtein]]];
    
    NSNumber *higestPossibleMax = @0;
    
    for (LORootItem *rootItem in rootItems) {
        if (rootItem.healthFrequencyLimit.integerValue > higestPossibleMax.integerValue) {
            higestPossibleMax = [NSNumber numberWithInteger:rootItem.healthFrequencyLimit.integerValue];
        }
    }
    
    return higestPossibleMax.floatValue;
}

- (CGFloat )nutritionSourcingNutMaxValue
{
    NSArray *rootItems = [LORootItem MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"baseFoodType = %li", (long)LOFoodTypeNut]]];
    
    NSNumber *higestPossibleMax = @0;
    
    for (LORootItem *rootItem in rootItems) {
        if (rootItem.healthFrequencyLimit.integerValue > higestPossibleMax.integerValue) {
            higestPossibleMax = [NSNumber numberWithInteger:rootItem.healthFrequencyLimit.integerValue];
        }
    }
    
    return higestPossibleMax.floatValue;
}

- (CGFloat )nutritionSourcingWhiteProteinMaxValue
{
    NSArray *rootItems = [LORootItem MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"baseFoodType = %li", (long)LOFoodTypeWhiteProtein]]];
    
    NSNumber *higestPossibleMax = @0;
    
    for (LORootItem *rootItem in rootItems) {
        if (rootItem.healthFrequencyLimit.integerValue > higestPossibleMax.integerValue) {
            higestPossibleMax = [NSNumber numberWithInteger:rootItem.healthFrequencyLimit.integerValue];
        }
    }
    
    return higestPossibleMax.floatValue;
}

- (CGFloat )nutritionSourcingFruitMaxValue
{
    NSArray *rootItems = [LORootItem MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"baseFoodType = %li", (long)LOFoodTypeFruit]]];
    
    NSNumber *higestPossibleMax = @0;
    
    for (LORootItem *rootItem in rootItems) {
        if (rootItem.healthFrequencyLimit.integerValue > higestPossibleMax.integerValue) {
            higestPossibleMax = [NSNumber numberWithInteger:rootItem.healthFrequencyLimit.integerValue];
        }
    }
    
    return higestPossibleMax.floatValue;
}

- (CGFloat )nutritionSourcingVegetableMaxValue
{
    NSArray *rootItems = [LORootItem MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"baseFoodType = %li", (long)LOFoodTypeVegetable]]];
    
    NSNumber *higestPossibleMax = @0;
    
    for (LORootItem *rootItem in rootItems) {
        if (rootItem.healthFrequencyLimit.integerValue > higestPossibleMax.integerValue) {
            higestPossibleMax = [NSNumber numberWithInteger:rootItem.healthFrequencyLimit.integerValue];
        }
    }
    
    return higestPossibleMax.floatValue;
}

- (CGFloat )nutritionSourcingVegetableProteinMaxValue
{
    NSArray *rootItems = [LORootItem MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"baseFoodType = %li", (long)LOFoodTypePlantProtein]]];
    
    NSNumber *higestPossibleMax = @0;
    
    for (LORootItem *rootItem in rootItems) {
        if (rootItem.healthFrequencyLimit.integerValue > higestPossibleMax.integerValue) {
            higestPossibleMax = [NSNumber numberWithInteger:rootItem.healthFrequencyLimit.integerValue];
        }
    }
    
    return higestPossibleMax.floatValue;
}

- (NSArray *)lastWeekSourcingScoreDataForFoodType:(NSInteger )foodType
{
    NSMutableArray *returnArray = [NSMutableArray new];
    NSInteger LOFoodCategoryConventionalCount = 0;
    NSInteger LOFoodCategoryLocalCount = 0;
    NSInteger LOFoodCategoryVendorCount = 0;
    NSInteger LOFoodCategoryOrganicCount = 0;
    NSInteger LOFoodCategoryFarmersMarketCount = 0;
    NSInteger LOFoodCategoryFarmToTableCount = 0;
    NSInteger LOFoodCategoryCSACount = 0;
    
    NSArray *foodItems = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)foodType]]]; //returns foods for a specific type // last week or this week etc...
    
    for (LOFood *food in foodItems) {
        NSArray *categories = (NSArray *)food.categories;
        if ([food.date isLastWeek]) {
            for (NSNumber *number in categories) {
                if (number.integerValue == LOFoodCategoryConventional)
                {
                    ++LOFoodCategoryConventionalCount;
                }
                else if (number.integerValue == LOFoodCategoryLocal)
                {
                    ++LOFoodCategoryLocalCount;
                }
                else if (number.integerValue == LOFoodCategoryVendor)
                {
                    ++LOFoodCategoryVendorCount;
                }
                else if (number.integerValue == LOFoodCategoryOrganic)
                {
                    ++LOFoodCategoryOrganicCount;
                }
                else if (number.integerValue == LOFoodCategoryFarmersMarket)
                {
                    ++LOFoodCategoryFarmersMarketCount;
                }
                else if (number.integerValue == LOFoodCategoryFarmToTable)
                {
                    ++LOFoodCategoryFarmToTableCount;
                }
                else if (number.integerValue == LOFoodCategoryCSA)
                {
                    ++LOFoodCategoryCSACount;
                }
            }
        }
    }
    
    [returnArray addObjectsFromArray:@[[NSNumber numberWithInteger:LOFoodCategoryConventionalCount],
                                       [NSNumber numberWithInteger:LOFoodCategoryLocalCount],
                                       [NSNumber numberWithInteger:LOFoodCategoryVendorCount],
                                       [NSNumber numberWithInteger:LOFoodCategoryOrganicCount],
                                       [NSNumber numberWithInteger:LOFoodCategoryFarmersMarketCount],
                                       [NSNumber numberWithInteger:LOFoodCategoryFarmToTableCount],
                                       [NSNumber numberWithInteger:LOFoodCategoryCSACount]]];
    
    return returnArray;

}

- (NSArray *)thisWeekSourcingScoreDataForFoodType:(NSInteger )foodType
{
    NSMutableArray *returnArray = [NSMutableArray new];
    NSInteger LOFoodCategoryConventionalCount = 0;
    NSInteger LOFoodCategoryLocalCount = 0;
    NSInteger LOFoodCategoryVendorCount = 0;
    NSInteger LOFoodCategoryOrganicCount = 0;
    NSInteger LOFoodCategoryFarmersMarketCount = 0;
    NSInteger LOFoodCategoryFarmToTableCount = 0;
    NSInteger LOFoodCategoryCSACount = 0;
    
    NSArray *foodItems = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)foodType]]]; //returns foods for a specific type // last week or this week etc...

    for (LOFood *food in foodItems) {
        NSArray *categories = (NSArray *)food.categories;
        if ([food.date isThisWeek]) {
            for (NSNumber *number in categories) {
                if (number.integerValue == LOFoodCategoryConventional)
                {
                    ++LOFoodCategoryConventionalCount;
                }
                else if (number.integerValue == LOFoodCategoryLocal)
                {
                    ++LOFoodCategoryLocalCount;
                }
                else if (number.integerValue == LOFoodCategoryVendor)
                {
                    ++LOFoodCategoryVendorCount;
                }
                else if (number.integerValue == LOFoodCategoryOrganic)
                {
                    ++LOFoodCategoryOrganicCount;
                }
                else if (number.integerValue == LOFoodCategoryFarmersMarket)
                {
                    ++LOFoodCategoryFarmersMarketCount;
                }
                else if (number.integerValue == LOFoodCategoryFarmToTable)
                {
                    ++LOFoodCategoryFarmToTableCount;
                }
                else if (number.integerValue == LOFoodCategoryCSA)
                {
                    ++LOFoodCategoryCSACount;
                }
            }
        }
    }
    
    [returnArray addObjectsFromArray:@[[NSNumber numberWithInteger:LOFoodCategoryConventionalCount],
                                       [NSNumber numberWithInteger:LOFoodCategoryLocalCount],
                                       [NSNumber numberWithInteger:LOFoodCategoryVendorCount],
                                       [NSNumber numberWithInteger:LOFoodCategoryOrganicCount],
                                       [NSNumber numberWithInteger:LOFoodCategoryFarmersMarketCount],
                                       [NSNumber numberWithInteger:LOFoodCategoryFarmToTableCount],
                                       [NSNumber numberWithInteger:LOFoodCategoryCSACount]]];
    
    return returnArray;
}

- (NSArray *)thisWeekSourcingScoreDataForActivityType:(NSInteger )activityType
{
    
    NSMutableArray *returnArray = [NSMutableArray new];
    NSInteger LOActivityCategoryFitnessCount = 0;
    NSInteger LOActivityCategoryUtilitarianCount = 0;
    
    NSArray *activityItems = [LOActivity MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)activityType]]]; //returns activities for a specific type // last week or this week etc...
    
    for (LOActivity *activity in activityItems) {
        NSNumber *category = activity.category;
        if ([activity.date isThisWeek]) {
            if (category.integerValue == LOActivityCategoryFitness)
            {
                ++LOActivityCategoryFitnessCount;
            }
            else if (category.integerValue == LOActivityCategoryUtilitarian)
            {
                ++LOActivityCategoryUtilitarianCount;
            }
        }
    }
    
    [returnArray addObjectsFromArray:@[[NSNumber numberWithInteger:LOActivityCategoryFitnessCount],
                                       [NSNumber numberWithInteger:LOActivityCategoryUtilitarianCount]]];
    
    return returnArray;
}

- (NSArray *)lastWeekSourcingScoreDataForActivityType:(NSInteger )activityType
{
    
    NSMutableArray *returnArray = [NSMutableArray new];
    NSInteger LOActivityCategoryFitnessCount = 0;
    NSInteger LOActivityCategoryUtilitarianCount = 0;
    
    NSArray *activityItems = [LOActivity MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)activityType]]]; //returns activities for a specific type // last week or this week etc...
    
    for (LOActivity *activity in activityItems) {
        NSNumber *category = activity.category;
        if ([activity.date isLastWeek]) {
            if (category.integerValue == LOActivityCategoryFitness)
            {
                ++LOActivityCategoryFitnessCount;
            }
            else if (category.integerValue == LOActivityCategoryUtilitarian)
            {
                ++LOActivityCategoryUtilitarianCount;
            }
        }
    }
    
    [returnArray addObjectsFromArray:@[[NSNumber numberWithInteger:LOActivityCategoryFitnessCount],
                                       [NSNumber numberWithInteger:LOActivityCategoryUtilitarianCount]]];
    
    return returnArray;
}


- (NSArray *)thisWeekQuantitiesScoreDataForAllActivityTypes
{
    NSMutableArray *returnArray = [NSMutableArray new];
    
    NSInteger LOActivityTypeOtherCount = 0;
    NSInteger LOActivityTypeStrengthCount = 0;
    NSInteger LOActivityTypeCardioCount = 0;
    NSInteger LOActivityTypeFlexibilityCount = 0;
    
    NSArray *activityTypesOther = [LOActivity MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOActivityTypeOther]]];
    NSArray *strengthTypesOther = [LOActivity MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOActivityTypeStrength]]];
    NSArray *cardioTypesOther = [LOActivity MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOActivityTypeCardio]]];
    NSArray *flexibilityTypesOther = [LOActivity MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOActivityTypeFlexibility]]];
    
    
    for (LOActivity *activity in activityTypesOther) {
        if ([activity.date isThisWeek]) {
            ++LOActivityTypeOtherCount;
        }
    }
    
    for (LOActivity *activity in strengthTypesOther) {
        if ([activity.date isThisWeek]) {
            ++LOActivityTypeStrengthCount;
        }
    }
    
    for (LOActivity *activity in cardioTypesOther) {
        if ([activity.date isThisWeek]) {
            ++LOActivityTypeCardioCount;
        }
    }
    
    for (LOActivity *activity in flexibilityTypesOther) {
        if ([activity.date isThisWeek]) {
            ++LOActivityTypeFlexibilityCount;
        }
    }
    
    [returnArray addObjectsFromArray:@[[NSNumber numberWithInteger:LOActivityTypeOtherCount],
                                       [NSNumber numberWithInteger:LOActivityTypeStrengthCount],
                                       [NSNumber numberWithInteger:LOActivityTypeCardioCount],
                                       [NSNumber numberWithInteger:LOActivityTypeFlexibilityCount]]];
    
    return returnArray;
}

- (NSArray *)lastWeekQuantitiesScoreDataForAllActivityTypes
{
    NSMutableArray *returnArray = [NSMutableArray new];
    
    NSInteger LOActivityTypeOtherCount = 0;
    NSInteger LOActivityTypeStrengthCount = 0;
    NSInteger LOActivityTypeCardioCount = 0;
    NSInteger LOActivityTypeFlexibilityCount = 0;
    
    NSArray *activityTypesOther = [LOActivity MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOActivityTypeOther]]];
    NSArray *strengthTypesOther = [LOActivity MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOActivityTypeStrength]]];
    NSArray *cardioTypesOther = [LOActivity MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOActivityTypeCardio]]];
    NSArray *flexibilityTypesOther = [LOActivity MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOActivityTypeFlexibility]]];
    
    
    for (LOActivity *activity in activityTypesOther) {
        if ([activity.date isLastWeek]) {
            ++LOActivityTypeOtherCount;
        }
    }
    
    for (LOActivity *activity in strengthTypesOther) {
        if ([activity.date isLastWeek]) {
            ++LOActivityTypeStrengthCount;
        }
    }
    
    for (LOActivity *activity in cardioTypesOther) {
        if ([activity.date isLastWeek]) {
            ++LOActivityTypeCardioCount;
        }
    }
    
    for (LOActivity *activity in flexibilityTypesOther) {
        if ([activity.date isLastWeek]) {
            ++LOActivityTypeFlexibilityCount;
        }
    }
    
    [returnArray addObjectsFromArray:@[[NSNumber numberWithInteger:LOActivityTypeOtherCount],
                                       [NSNumber numberWithInteger:LOActivityTypeStrengthCount],
                                       [NSNumber numberWithInteger:LOActivityTypeCardioCount],
                                       [NSNumber numberWithInteger:LOActivityTypeFlexibilityCount]]];
    
    return returnArray;
}

- (NSArray *)lastLastWeekQuantitiesScoreDataForAllActivityTypes
{
    NSMutableArray *returnArray = [NSMutableArray new];
    
    NSInteger LOActivityTypeOtherCount = 0;
    NSInteger LOActivityTypeStrengthCount = 0;
    NSInteger LOActivityTypeCardioCount = 0;
    NSInteger LOActivityTypeFlexibilityCount = 0;
    
    NSArray *activityTypesOther = [LOActivity MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOActivityTypeOther]]];
    NSArray *strengthTypesOther = [LOActivity MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOActivityTypeStrength]]];
    NSArray *cardioTypesOther = [LOActivity MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOActivityTypeCardio]]];
    NSArray *flexibilityTypesOther = [LOActivity MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOActivityTypeFlexibility]]];
    
    
    for (LOActivity *activity in activityTypesOther) {
        if ([activity.date isLastLastWeek]) {
            ++LOActivityTypeOtherCount;
        }
    }
    
    for (LOActivity *activity in strengthTypesOther) {
        if ([activity.date isLastLastWeek]) {
            ++LOActivityTypeStrengthCount;
        }
    }
    
    for (LOActivity *activity in cardioTypesOther) {
        if ([activity.date isLastLastWeek]) {
            ++LOActivityTypeCardioCount;
        }
    }
    
    for (LOActivity *activity in flexibilityTypesOther) {
        if ([activity.date isLastLastWeek]) {
            ++LOActivityTypeFlexibilityCount;
        }
    }
    
    [returnArray addObjectsFromArray:@[[NSNumber numberWithInteger:LOActivityTypeOtherCount],
                                       [NSNumber numberWithInteger:LOActivityTypeStrengthCount],
                                       [NSNumber numberWithInteger:LOActivityTypeCardioCount],
                                       [NSNumber numberWithInteger:LOActivityTypeFlexibilityCount]]];
    
    return returnArray;
}

- (NSArray *)thisWeekQuantitiesScoreDataForAllFoodTypes
{
    NSMutableArray *returnArray = [NSMutableArray new];
    
    NSInteger LOFoodTypeOtherCount = 0;
    NSInteger LOFoodTypeRedProteinCount = 0;
    NSInteger LOFoodTypeWhiteProteinCount = 0;
    NSInteger LOFoodTypeNutCount = 0;
    NSInteger LOFoodTypeFruitCount = 0;
    NSInteger LOFoodTypeVegetableCount = 0;
    NSInteger LOFoodTypeVegProteinCount = 0;
    
    NSArray *foodTypesOther = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypeOther]]];
    NSArray *foodTypesRed = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypeRedProtein]]];
    NSArray *foodTypesWhite = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypeWhiteProtein]]];
    NSArray *foodTypesNut = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypeNut]]];
    NSArray *foodTypesFruit = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypeFruit]]];
    NSArray *foodTypesVegetable = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypeVegetable]]];
    NSArray *foodTypesVegProtein = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypePlantProtein]]];
    
    for (LOFood *food in foodTypesOther) {
        if ([food.date isThisWeek]) {
            ++LOFoodTypeOtherCount;
        }
    }
    
    for (LOFood *food in foodTypesRed) {
        if ([food.date isThisWeek]) {
            ++LOFoodTypeRedProteinCount;
        }
    }
    
    for (LOFood *food in foodTypesWhite) {
        if ([food.date isThisWeek]) {
            ++LOFoodTypeWhiteProteinCount;
        }
    }
    
    for (LOFood *food in foodTypesNut) {
        if ([food.date isThisWeek]) {
            ++LOFoodTypeNutCount;
        }
    }
    
    for (LOFood *food in foodTypesFruit) {
        if ([food.date isThisWeek]) {
            ++LOFoodTypeFruitCount;
        }
    }
    
    for (LOFood *food in foodTypesVegetable) {
        if ([food.date isThisWeek]) {
            ++LOFoodTypeVegetableCount;
        }
    }
    
    for (LOFood *food in foodTypesVegProtein) {
        if ([food.date isThisWeek]) {
            ++LOFoodTypeVegProteinCount;
        }
    }
    
    
    [returnArray addObjectsFromArray:@[[NSNumber numberWithUnsignedInteger:LOFoodTypeOtherCount],
                                       [NSNumber numberWithUnsignedInteger:LOFoodTypeRedProteinCount],
                                       [NSNumber numberWithUnsignedInteger:LOFoodTypeWhiteProteinCount],
                                       [NSNumber numberWithUnsignedInteger:LOFoodTypeNutCount],
                                       [NSNumber numberWithUnsignedInteger:LOFoodTypeFruitCount],
                                       [NSNumber numberWithUnsignedInteger:LOFoodTypeVegetableCount],
                                       [NSNumber numberWithUnsignedInteger:LOFoodTypeVegProteinCount]]];
    
    return returnArray;
}

- (NSArray *)lastWeekQuantitiesScoreDataForAllFoodTypes
{
    NSMutableArray *returnArray = [NSMutableArray new];
    
    NSInteger LOFoodTypeOtherCount = 0;
    NSInteger LOFoodTypeRedProteinCount = 0;
    NSInteger LOFoodTypeWhiteProteinCount = 0;
    NSInteger LOFoodTypeNutCount = 0;
    NSInteger LOFoodTypeFruitCount = 0;
    NSInteger LOFoodTypeVegetableCount = 0;
    NSInteger LOFoodTypeVegProteinCount = 0;
    
    NSArray *foodTypesOther = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypeOther]]];
    NSArray *foodTypesRed = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypeRedProtein]]];
    NSArray *foodTypesWhite = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypeWhiteProtein]]];
    NSArray *foodTypesNut = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypeNut]]];
    NSArray *foodTypesFruit = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypeFruit]]];
    NSArray *foodTypesVegetable = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypeVegetable]]];
    NSArray *foodTypesVegProtein = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypePlantProtein]]];
    
    for (LOFood *food in foodTypesOther) {
        if ([food.date isLastWeek]) {
            ++LOFoodTypeOtherCount;
        }
    }
    
    for (LOFood *food in foodTypesRed) {
        if ([food.date isLastWeek]) {
            ++LOFoodTypeRedProteinCount;
        }
    }
    
    for (LOFood *food in foodTypesWhite) {
        if ([food.date isLastWeek]) {
            ++LOFoodTypeWhiteProteinCount;
        }
    }
    
    for (LOFood *food in foodTypesNut) {
        if ([food.date isLastWeek]) {
            ++LOFoodTypeNutCount;
        }
    }
    
    for (LOFood *food in foodTypesFruit) {
        if ([food.date isLastWeek]) {
            ++LOFoodTypeFruitCount;
        }
    }
    
    for (LOFood *food in foodTypesVegetable) {
        if ([food.date isLastWeek]) {
            ++LOFoodTypeVegetableCount;
        }
    }
    
    for (LOFood *food in foodTypesVegProtein) {
        if ([food.date isLastWeek]) {
            ++LOFoodTypeVegProteinCount;
        }
    }
    
    
    [returnArray addObjectsFromArray:@[[NSNumber numberWithUnsignedInteger:LOFoodTypeOtherCount],
                                       [NSNumber numberWithUnsignedInteger:LOFoodTypeRedProteinCount],
                                       [NSNumber numberWithUnsignedInteger:LOFoodTypeWhiteProteinCount],
                                       [NSNumber numberWithUnsignedInteger:LOFoodTypeNutCount],
                                       [NSNumber numberWithUnsignedInteger:LOFoodTypeFruitCount],
                                       [NSNumber numberWithUnsignedInteger:LOFoodTypeVegetableCount],
                                       [NSNumber numberWithUnsignedInteger:LOFoodTypeVegProteinCount]]];
    
    return returnArray;
}

- (NSArray *)lastLastWeekQuantitiesScoreDataForAllFoodTypes
{
    NSMutableArray *returnArray = [NSMutableArray new];
    
    NSInteger LOFoodTypeOtherCount = 0;
    NSInteger LOFoodTypeRedProteinCount = 0;
    NSInteger LOFoodTypeWhiteProteinCount = 0;
    NSInteger LOFoodTypeNutCount = 0;
    NSInteger LOFoodTypeFruitCount = 0;
    NSInteger LOFoodTypeVegetableCount = 0;
    NSInteger LOFoodTypeVegProteinCount = 0;
    
    NSArray *foodTypesOther = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypeOther]]];
    NSArray *foodTypesRed = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypeRedProtein]]];
    NSArray *foodTypesWhite = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypeWhiteProtein]]];
    NSArray *foodTypesNut = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypeNut]]];
    NSArray *foodTypesFruit = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypeFruit]]];
    NSArray *foodTypesVegetable = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypeVegetable]]];
    NSArray *foodTypesVegProtein = [LOFood MR_findAllWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %li", (long)LOFoodTypePlantProtein]]];
    
    for (LOFood *food in foodTypesOther) {
        if ([food.date isLastLastWeek]) {
            ++LOFoodTypeOtherCount;
        }
    }
    
    for (LOFood *food in foodTypesRed) {
        if ([food.date isLastLastWeek]) {
            ++LOFoodTypeRedProteinCount;
        }
    }
    
    for (LOFood *food in foodTypesWhite) {
        if ([food.date isLastLastWeek]) {
            ++LOFoodTypeWhiteProteinCount;
        }
    }
    
    for (LOFood *food in foodTypesNut) {
        if ([food.date isLastLastWeek]) {
            ++LOFoodTypeNutCount;
        }
    }
    
    for (LOFood *food in foodTypesFruit) {
        if ([food.date isLastLastWeek]) {
            ++LOFoodTypeFruitCount;
        }
    }
    
    for (LOFood *food in foodTypesVegetable) {
        if ([food.date isLastLastWeek]) {
            ++LOFoodTypeVegetableCount;
        }
    }
    
    for (LOFood *food in foodTypesVegProtein) {
        if ([food.date isLastLastWeek]) {
            ++LOFoodTypeVegProteinCount;
        }
    }
    
    
    [returnArray addObjectsFromArray:@[[NSNumber numberWithUnsignedInteger:LOFoodTypeOtherCount],
                                       [NSNumber numberWithUnsignedInteger:LOFoodTypeRedProteinCount],
                                       [NSNumber numberWithUnsignedInteger:LOFoodTypeWhiteProteinCount],
                                       [NSNumber numberWithUnsignedInteger:LOFoodTypeNutCount],
                                       [NSNumber numberWithUnsignedInteger:LOFoodTypeFruitCount],
                                       [NSNumber numberWithUnsignedInteger:LOFoodTypeVegetableCount],
                                       [NSNumber numberWithUnsignedInteger:LOFoodTypeVegProteinCount]]];
    
    return returnArray;
}


- (NSNumber *)overallScoreForEnvironmentLastWeekWithFoodItems:(bool)withFoodItems withActivityItems:(bool)withActivityItems
{
    NSInteger score = 0;
    NSArray *items = [LORootItem MR_findAll];
    
    for (LORootItem *rootItem in items) {

        if (withFoodItems) {
            if (rootItem.foods.count > 0) {
                NSInteger rootItemCounter = 0;
                for (LOFood *food in rootItem.foods) {
                    if ([food.date isLastWeek]) {
                        ++rootItemCounter;
                        
                        if (rootItemCounter <= food.rootItem.environmentFrequencyLimit.integerValue) {
                            score += food.baseEnvironmentValue;
                        } else {
                            score -= food.baseEnvironmentValue;
                        }
                        
                        //dont let a score go below 0
                        if (score <= 0) {
                            score = 0;
                        }
                    }
                }
            }
        }
        
        if (withActivityItems) {
            if (rootItem.activities.count > 0) {
                NSInteger rootItemCounter = 0;
                for (LOActivity *activity in rootItem.activities) {
                    if ([activity.date isLastWeek]) {
                        ++rootItemCounter;
                        
                        if (rootItemCounter <= activity.rootItem.environmentFrequencyLimit.integerValue) {
                            score += activity.baseEnvironmentValue;
                        } else {
                            score -= activity.baseEnvironmentValue;
                        }
                        
                        //dont let a score go below 0
                        if (score <= 0) {
                            score = 0;
                        }
                    }
                }
            }
        }
    }
    
    return [NSNumber numberWithFloat:score];
}

- (NSNumber *)overallScoreForEnvironmentThisWeekWithFoodItems:(bool)withFoodItems withActivityItems:(bool)withActivityItems
{
    NSInteger score = 0;
    NSArray *items = [LORootItem MR_findAll];
    
    for (LORootItem *rootItem in items) {
        
        if (withFoodItems) {
            if (rootItem.foods.count > 0) {
                NSInteger rootItemCounter = 0;
                for (LOFood *food in rootItem.foods) {
                    if ([food.date isThisWeek]) {
                        ++rootItemCounter;
                        
                        if (rootItemCounter <= food.rootItem.environmentFrequencyLimit.integerValue) {
                            score += food.baseEnvironmentValue;
                        } else {
                            score -= food.baseEnvironmentValue;
                        }
                        
                        //dont let a score go below 0
                        if (score <= 0) {
                            score = 0;
                        }
                    }
                }
            }
        }

        if (withActivityItems) {
            if (rootItem.activities.count > 0) {
                NSInteger rootItemCounter = 0;
                for (LOActivity *activity in rootItem.activities) {
                    if ([activity.date isThisWeek]) {
                        ++rootItemCounter;
                        
                        if (rootItemCounter <= activity.rootItem.environmentFrequencyLimit.integerValue) {
                            score += activity.baseEnvironmentValue;
                        } else {
                            score -= activity.baseEnvironmentValue;
                        }
                        
                        //dont let a score go below 0
                        if (score <= 0) {
                            score = 0;
                        }
                    }
                }
            }
        }
    }
    
    return [NSNumber numberWithFloat:score];
}

- (NSNumber *)overallScoreForHealthLastWeekWithFoodItems:(bool)withFoodItems withActivityItems:(bool)withActivityItems
{
    NSInteger score = 0;
    NSArray *items = [LORootItem MR_findAll];
    
    for (LORootItem *rootItem in items) {
        if (withFoodItems) {
            if (rootItem.foods.count > 0) {
                NSInteger rootItemCounter = 0;
                for (LOFood *food in rootItem.foods) {
                    if ([food.date isLastWeek]) {
                        NSNumber *type = food.type;
                        ++rootItemCounter;
                        
                        //check that we are not of other type...
                        if (type.integerValue != LOFoodTypeOther) {
                            if (rootItemCounter <= food.rootItem.healthFrequencyLimit.integerValue) {
                                score += food.baseHealthValue;
                            } else {
                                score -= food.baseHealthValue;
                            }
                        }
                        
                        //dont let a score go below 0
                        if (score <= 0) {
                            score = 0;
                        }
                    }
                }
            }
        }
        
        if (withActivityItems) {
            if (rootItem.activities.count > 0) {
                NSInteger rootItemCounter = 0;
                for (LOActivity *activity in rootItem.activities) {
                    if ([activity.date isLastWeek]) {
                        
                        NSNumber *type = activity.type;
                        ++rootItemCounter;
                        
                        //check that we are not of other type...
                        if (type.integerValue != LOActivityTypeOther) {
                            if (rootItemCounter <= activity.rootItem.healthFrequencyLimit.integerValue) {
                                score += activity.baseHealthValue;
                            } else {
                                score -= activity.baseHealthValue;
                            }
                        }
                        
                        //dont let a score go below 0
                        if (score <= 0) {
                            score = 0;
                        }
                    }
                }
            }
        }
    }
    
    return [NSNumber numberWithFloat:score];

}
- (NSNumber *)overallScoreForHealthThisWeekWithFoodItems:(bool)withFoodItems withActivityItems:(bool)withActivityItems
{
    NSInteger score = 0;
    NSArray *items = [LORootItem MR_findAll];
    
    for (LORootItem *rootItem in items) {
        if (withFoodItems) {
            if (rootItem.foods.count > 0) {
                NSInteger rootItemCounter = 0;
                for (LOFood *food in rootItem.foods) {
                    if ([food.date isThisWeek]) {
                        NSNumber *type = food.type;
                        ++rootItemCounter;
                        
                        if (type.integerValue != LOFoodTypeOther) {
                            if (rootItemCounter <= food.rootItem.healthFrequencyLimit.integerValue) {
                                score += food.baseHealthValue;
                            } else {
                                score -= food.baseHealthValue;
                            }
                        }
                        
                        //dont let a score go below 0
                        if (score <= 0) {
                            score = 0;
                        }
                    }
                }
            }
        }

        
        if (withActivityItems) {
            if (rootItem.activities.count > 0) {
                NSInteger rootItemCounter = 0;
                for (LOActivity *activity in rootItem.activities) {
                    if ([activity.date isThisWeek]) {
                        NSNumber *type = activity.type;
                        ++rootItemCounter;
                        
                        if (type.integerValue != LOActivityTypeOther) {
                            if (rootItemCounter <= activity.rootItem.healthFrequencyLimit.integerValue) {
                                score += activity.baseHealthValue;
                            } else {
                                score -= activity.baseHealthValue;
                            }
                        }
                        
                        //dont let a score go below 0
                        if (score <= 0) {
                            score = 0;
                        }
                    }
                }
            }
        }
    }
    
    return [NSNumber numberWithFloat:score];
}

// returns array of nsnumbers for (health lw, env lw).
- (NSArray *)lastWeekHealthAndEnvironmentCurrentScoreDataWithFoodItems:(bool)withFoodItems withActivityItems:(bool)withActivityItems
{
    return @[[self overallScoreForHealthLastWeekWithFoodItems:withFoodItems withActivityItems:withActivityItems],
             [self overallScoreForEnvironmentLastWeekWithFoodItems:withFoodItems withActivityItems:withActivityItems]];
}

// returns array of nsnumbers for (health lw, env lw).
- (NSArray *)thisWeekHealthAndEnvironmentCurrentScoreDataWithFoodItems:(bool)withFoodItems withActivityItems:(bool)withActivityItems
{
    return @[[self overallScoreForHealthThisWeekWithFoodItems:withFoodItems withActivityItems:withActivityItems],
             [self overallScoreForEnvironmentThisWeekWithFoodItems:withFoodItems withActivityItems:withActivityItems]];
}

// returns array of nsnumbers for (health lw, health tw).
- (NSArray *)lastWeekVSThisWeekHealthOnlyCurrentScoreDataWithFoodItems:(bool)withFoodItems withActivityItems:(bool)withActivityItems
{
    return @[[self overallScoreForHealthLastWeekWithFoodItems:withFoodItems withActivityItems:withActivityItems],
             [self overallScoreForHealthThisWeekWithFoodItems:withFoodItems withActivityItems:withActivityItems]];
}

// returns array of nsnumbers for (env lw, env tw).
- (NSArray *)lastWeekVSThisWeekEnvironmentOnlyCurrentScoreDataWithFoodItems:(bool)withFoodItems withActivityItems:(bool)withActivityItems
{
    return @[[self overallScoreForEnvironmentLastWeekWithFoodItems:withFoodItems withActivityItems:withActivityItems],
             [self overallScoreForEnvironmentThisWeekWithFoodItems:withFoodItems withActivityItems:withActivityItems]];
}

- (NSArray *)healthNutritionLessThisWeekGood
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *lessThisWeek = [NSMutableArray new];

    for (LORootItem *rootItem in items) {
        NSInteger thisWeekRootItemCounter = 0;
        NSInteger lastWeekRootItemCounter = 0;

        for (LOFood *food in rootItem.foods) {
            if ([food.date isThisWeek]) {
                thisWeekRootItemCounter ++;
            } else if ([food.date isLastWeek]){
                lastWeekRootItemCounter ++;
            }
        }
        
        //check if the item had gone over the limit last week and only procced if it has and there is less consumed this week
        if (lastWeekRootItemCounter > thisWeekRootItemCounter && lastWeekRootItemCounter > rootItem.healthFrequencyLimit.integerValue) {
            
            //check if the object is not in the array and has not gone over the limit this week
            if (![lessThisWeek containsObject:rootItem] && thisWeekRootItemCounter <= rootItem.healthFrequencyLimit.integerValue) {
                [lessThisWeek addObject:rootItem];
            }
        }
    }
    
    return lessThisWeek;
}

- (NSArray *)healthNutritionMoreThisWeekGood
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *moreThisWeek = [NSMutableArray new];
    
    for (LORootItem *rootItem in items) {
        NSInteger thisWeekRootItemCounter = 0;
        NSInteger lastWeekRootItemCounter = 0;
        
        for (LOFood *food in rootItem.foods) {
            NSNumber *type = food.type;
            
            if (type.integerValue != LOFoodTypeOther) {
                if ([food.date isThisWeek]) {
                    thisWeekRootItemCounter ++;
                } else if ([food.date isLastWeek]){
                    lastWeekRootItemCounter ++;
                }
            }
        }
        
        //check if the item had gone under the limit last week and only procced if it has and there is more consumed this week
        if (lastWeekRootItemCounter < thisWeekRootItemCounter && lastWeekRootItemCounter < rootItem.healthFrequencyLimit.integerValue) {
            
            //check if the object is not in the array and has not gone over the limit this week
            if (![moreThisWeek containsObject:rootItem] && thisWeekRootItemCounter <= rootItem.healthFrequencyLimit.integerValue) {
                [moreThisWeek addObject:rootItem];
            }
        }
    }
    
    return moreThisWeek;
}

- (NSArray *)healthNutritionLessThisWeekBad
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *lessThisWeek = [NSMutableArray new];
    
    for (LORootItem *rootItem in items) {
        NSInteger thisWeekRootItemCounter = 0;
        NSInteger lastWeekRootItemCounter = 0;
        
        for (LOFood *food in rootItem.foods) {
            if ([food.date isThisWeek]) {
                thisWeekRootItemCounter ++;
            } else if ([food.date isLastWeek]){
                lastWeekRootItemCounter ++;
            }
        }
        
        //check if the item had gone under the limit last week and only procced if it has and there is less consumed this week
        if (lastWeekRootItemCounter > thisWeekRootItemCounter && lastWeekRootItemCounter < rootItem.healthFrequencyLimit.integerValue) {
            
            //check if the object is not in the array and has not gone over the limit this week
            if (![lessThisWeek containsObject:rootItem] && thisWeekRootItemCounter <= rootItem.healthFrequencyLimit.integerValue) {
                [lessThisWeek addObject:rootItem];
            }
        }
    }
    
    return lessThisWeek;
}

- (NSArray *)healthNutritionMoreThisWeekBad
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *moreThisWeek = [NSMutableArray new];
    
    for (LORootItem *rootItem in items) {
        NSInteger thisWeekRootItemCounter = 0;
        NSInteger lastWeekRootItemCounter = 0;
        
        for (LOFood *food in rootItem.foods) {
            if ([food.date isThisWeek]) {
                thisWeekRootItemCounter ++;
            } else if ([food.date isLastWeek]){
                lastWeekRootItemCounter ++;
            }
        }
        
        //check if the item had gone under the limit last week and only procced if it has and there is less consumed this week
        if (lastWeekRootItemCounter < thisWeekRootItemCounter) {
            
            //check if the object is not in the array and has not gone over the limit this week
            if (![moreThisWeek containsObject:rootItem] && thisWeekRootItemCounter > rootItem.healthFrequencyLimit.integerValue) {
                [moreThisWeek addObject:rootItem];
            }
        }
    }
    
    return moreThisWeek;
}

- (NSArray *)healthNutritionLessLastWeekGood
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *lessThisWeek = [NSMutableArray new];
    
    for (LORootItem *rootItem in items) {
        NSInteger thisWeekRootItemCounter = 0;
        NSInteger lastWeekRootItemCounter = 0;
        
        for (LOFood *food in rootItem.foods) {
            if ([food.date isLastWeek]) {
                thisWeekRootItemCounter ++;
            } else if ([food.date isLastLastWeek]){
                lastWeekRootItemCounter ++;
            }
        }
        
        //check if the item had gone over the limit last week and only procced if it has and there is less consumed this week
        if (lastWeekRootItemCounter > thisWeekRootItemCounter && lastWeekRootItemCounter > rootItem.healthFrequencyLimit.integerValue) {
            
            //check if the object is not in the array and has not gone over the limit this week
            if (![lessThisWeek containsObject:rootItem] && thisWeekRootItemCounter <= rootItem.healthFrequencyLimit.integerValue) {
                [lessThisWeek addObject:rootItem];
            }
        }
    }
    
    return lessThisWeek;
}

- (NSArray *)healthNutritionMoreLastWeekGood
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *moreThisWeek = [NSMutableArray new];
    
    for (LORootItem *rootItem in items) {
        NSInteger thisWeekRootItemCounter = 0;
        NSInteger lastWeekRootItemCounter = 0;
        
        for (LOFood *food in rootItem.foods) {
            NSNumber *type = food.type;

            if (type.integerValue != LOFoodTypeOther) {
                if ([food.date isLastWeek]) {
                    thisWeekRootItemCounter ++;
                } else if ([food.date isLastLastWeek]){
                    lastWeekRootItemCounter ++;
                }
            }
        }
        
        //check if the item had gone under the limit last week and only procced if it has and there is more consumed this week
        if (lastWeekRootItemCounter < thisWeekRootItemCounter && lastWeekRootItemCounter < rootItem.healthFrequencyLimit.integerValue) {
            
            //check if the object is not in the array and has not gone over the limit this week
            if (![moreThisWeek containsObject:rootItem] && thisWeekRootItemCounter <= rootItem.healthFrequencyLimit.integerValue) {
                [moreThisWeek addObject:rootItem];
            }
        }
    }
    
    return moreThisWeek;
}

- (NSArray *)healthNutritionLessLastWeekBad
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *lessThisWeek = [NSMutableArray new];
    
    for (LORootItem *rootItem in items) {
        NSInteger thisWeekRootItemCounter = 0;
        NSInteger lastWeekRootItemCounter = 0;
        
        for (LOFood *food in rootItem.foods) {
            if ([food.date isLastWeek]) {
                thisWeekRootItemCounter ++;
            } else if ([food.date isLastLastWeek]){
                lastWeekRootItemCounter ++;
            }
        }
        
        //check if the item had gone under the limit last week and only procced if it has and there is less consumed this week
        if (lastWeekRootItemCounter > thisWeekRootItemCounter && lastWeekRootItemCounter < rootItem.healthFrequencyLimit.integerValue) {
            
            //check if the object is not in the array and has not gone over the limit this week
            if (![lessThisWeek containsObject:rootItem] && thisWeekRootItemCounter <= rootItem.healthFrequencyLimit.integerValue) {
                [lessThisWeek addObject:rootItem];
            }
        }
    }
    
    return lessThisWeek;
}

- (NSArray *)healthNutritionMoreLastWeekBad
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *moreThisWeek = [NSMutableArray new];
    
    for (LORootItem *rootItem in items) {
        NSInteger thisWeekRootItemCounter = 0;
        NSInteger lastWeekRootItemCounter = 0;
        
        for (LOFood *food in rootItem.foods) {
            if ([food.date isLastWeek]) {
                thisWeekRootItemCounter ++;
            } else if ([food.date isLastLastWeek]){
                lastWeekRootItemCounter ++;
            }
        }
        
        //check if the item had gone under the limit last week and only procced if it has and there is less consumed this week
        if (lastWeekRootItemCounter < thisWeekRootItemCounter) {
            
            //check if the object is not in the array and has not gone over the limit this week
            if (![moreThisWeek containsObject:rootItem] && thisWeekRootItemCounter > rootItem.healthFrequencyLimit.integerValue) {
                [moreThisWeek addObject:rootItem];
            }
        }
    }
    
    return moreThisWeek;
}

//last

//
- (NSArray *)healthMovementLessThisWeekGood
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *lessThisWeek = [NSMutableArray new];
    
    for (LORootItem *rootItem in items) {
        NSInteger thisWeekRootItemCounter = 0;
        NSInteger lastWeekRootItemCounter = 0;
        
        for (LOActivity *activity in rootItem.activities) {
            if ([activity.date isThisWeek]) {
                thisWeekRootItemCounter ++;
            } else if ([activity.date isLastWeek]){
                lastWeekRootItemCounter ++;
            }
        }
        
        //check if the item had gone over the limit last week and only procced if it has and there is less consumed this week
        if (lastWeekRootItemCounter > thisWeekRootItemCounter && lastWeekRootItemCounter > rootItem.healthFrequencyLimit.integerValue) {
            
            //check if the object is not in the array and has not gone over the limit this week
            if (![lessThisWeek containsObject:rootItem] && thisWeekRootItemCounter <= rootItem.healthFrequencyLimit.integerValue) {
                [lessThisWeek addObject:rootItem];
            }
        }
    }
    
    return lessThisWeek;
}

- (NSArray *)healthMovementMoreThisWeekGood
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *moreThisWeek = [NSMutableArray new];
    
    for (LORootItem *rootItem in items) {
        NSInteger thisWeekRootItemCounter = 0;
        NSInteger lastWeekRootItemCounter = 0;
        
        for (LOActivity *activity in rootItem.activities) {
            NSNumber *type = activity.type;

            if (type.integerValue != LOActivityTypeOther) {
                if ([activity.date isThisWeek]) {
                    thisWeekRootItemCounter ++;
                } else if ([activity.date isLastWeek]){
                    lastWeekRootItemCounter ++;
                }
            }
        }
        
        //check if the item had gone under the limit last week and only procced if it has and there is more consumed this week
        if (lastWeekRootItemCounter < thisWeekRootItemCounter && lastWeekRootItemCounter < rootItem.healthFrequencyLimit.integerValue) {
            
            //check if the object is not in the array and has not gone over the limit this week
            if (![moreThisWeek containsObject:rootItem] && thisWeekRootItemCounter <= rootItem.healthFrequencyLimit.integerValue) {
                [moreThisWeek addObject:rootItem];
            }
        }
    }
    
    return moreThisWeek;
}

- (NSArray *)healthMovementLessThisWeekBad
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *lessThisWeek = [NSMutableArray new];
    
    for (LORootItem *rootItem in items) {
        NSInteger thisWeekRootItemCounter = 0;
        NSInteger lastWeekRootItemCounter = 0;
        
        for (LOActivity *activity in rootItem.activities) {
            if ([activity.date isThisWeek]) {
                thisWeekRootItemCounter ++;
            } else if ([activity.date isLastWeek]){
                lastWeekRootItemCounter ++;
            }
        }
        
        //check if the item had gone under the limit last week and only procced if it has and there is less consumed this week
        if (lastWeekRootItemCounter > thisWeekRootItemCounter && lastWeekRootItemCounter < rootItem.healthFrequencyLimit.integerValue) {
            
            //check if the object is not in the array and has not gone over the limit this week
            if (![lessThisWeek containsObject:rootItem] && thisWeekRootItemCounter <= rootItem.healthFrequencyLimit.integerValue) {
                [lessThisWeek addObject:rootItem];
            }
        }
    }
    
    return lessThisWeek;
}

- (NSArray *)healthMovementMoreThisWeekBad
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *moreThisWeek = [NSMutableArray new];
    
    for (LORootItem *rootItem in items) {
        NSInteger thisWeekRootItemCounter = 0;
        NSInteger lastWeekRootItemCounter = 0;
        
        for (LOActivity *activity in rootItem.activities) {
            if ([activity.date isThisWeek]) {
                thisWeekRootItemCounter ++;
            } else if ([activity.date isLastWeek]){
                lastWeekRootItemCounter ++;
            }
        }
        
        //check if the item had gone under the limit last week and only procced if it has and there is less consumed this week
        if (lastWeekRootItemCounter < thisWeekRootItemCounter) {
            //check if the object is not in the array and has not gone over the limit this week
            if (![moreThisWeek containsObject:rootItem] && thisWeekRootItemCounter > rootItem.healthFrequencyLimit.integerValue) {
                [moreThisWeek addObject:rootItem];
            }
        }
    }
    
    return moreThisWeek;
}
//

//last
- (NSArray *)healthMovementLessLastWeekGood
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *lessThisWeek = [NSMutableArray new];
    
    for (LORootItem *rootItem in items) {
        NSInteger thisWeekRootItemCounter = 0;
        NSInteger lastWeekRootItemCounter = 0;
        
        for (LOActivity *activity in rootItem.activities) {
            if ([activity.date isLastWeek]) {
                thisWeekRootItemCounter ++;
            } else if ([activity.date isLastLastWeek]){
                lastWeekRootItemCounter ++;
            }
        }
        
        //check if the item had gone over the limit last week and only procced if it has and there is less consumed this week
        if (lastWeekRootItemCounter > thisWeekRootItemCounter && lastWeekRootItemCounter > rootItem.healthFrequencyLimit.integerValue) {
            
            //check if the object is not in the array and has not gone over the limit this week
            if (![lessThisWeek containsObject:rootItem] && thisWeekRootItemCounter <= rootItem.healthFrequencyLimit.integerValue) {
                [lessThisWeek addObject:rootItem];
            }
        }
    }
    
    return lessThisWeek;
}

- (NSArray *)healthMovementMoreLastWeekGood
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *moreThisWeek = [NSMutableArray new];
    
    for (LORootItem *rootItem in items) {
        NSInteger thisWeekRootItemCounter = 0;
        NSInteger lastWeekRootItemCounter = 0;
        
        for (LOActivity *activity in rootItem.activities) {
            NSNumber *type = activity.type;
            
            if (type.integerValue != LOActivityTypeOther) {
                if ([activity.date isLastWeek]) {
                    thisWeekRootItemCounter ++;
                } else if ([activity.date isLastLastWeek]){
                    lastWeekRootItemCounter ++;
                }
            }
        }
        
        //check if the item had gone under the limit last week and only procced if it has and there is more consumed this week
        if (lastWeekRootItemCounter < thisWeekRootItemCounter && lastWeekRootItemCounter < rootItem.healthFrequencyLimit.integerValue) {
            
            //check if the object is not in the array and has not gone over the limit this week
            if (![moreThisWeek containsObject:rootItem] && thisWeekRootItemCounter <= rootItem.healthFrequencyLimit.integerValue) {
                [moreThisWeek addObject:rootItem];
            }
        }
    }
    
    return moreThisWeek;
}

- (NSArray *)healthMovementLessLastWeekBad
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *lessThisWeek = [NSMutableArray new];
    
    for (LORootItem *rootItem in items) {
        NSInteger thisWeekRootItemCounter = 0;
        NSInteger lastWeekRootItemCounter = 0;
        
        for (LOActivity *activity in rootItem.activities) {
            if ([activity.date isLastWeek]) {
                thisWeekRootItemCounter ++;
            } else if ([activity.date isLastLastWeek]){
                lastWeekRootItemCounter ++;
            }
        }
        
        //check if the item had gone under the limit last week and only procced if it has and there is less consumed this week
        if (lastWeekRootItemCounter > thisWeekRootItemCounter && lastWeekRootItemCounter < rootItem.healthFrequencyLimit.integerValue) {
            
            //check if the object is not in the array and has not gone over the limit this week
            if (![lessThisWeek containsObject:rootItem] && thisWeekRootItemCounter <= rootItem.healthFrequencyLimit.integerValue) {
                [lessThisWeek addObject:rootItem];
            }
        }
    }
    
    return lessThisWeek;
}

- (NSArray *)healthMovementMoreLastWeekBad
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *moreThisWeek = [NSMutableArray new];
    
    for (LORootItem *rootItem in items) {
        NSInteger thisWeekRootItemCounter = 0;
        NSInteger lastWeekRootItemCounter = 0;
        
        for (LOActivity *activity in rootItem.activities) {
            if ([activity.date isLastWeek]) {
                thisWeekRootItemCounter ++;
            } else if ([activity.date isLastLastWeek]){
                lastWeekRootItemCounter ++;
            }
        }
        
        //check if the item had gone under the limit last week and only procced if it has and there is less consumed this week
        if (lastWeekRootItemCounter < thisWeekRootItemCounter) {
            //check if the object is not in the array and has not gone over the limit this week
            if (![moreThisWeek containsObject:rootItem] && thisWeekRootItemCounter > rootItem.healthFrequencyLimit.integerValue) {
                [moreThisWeek addObject:rootItem];
            }
        }
    }
    
    return moreThisWeek;
}

- (NSMutableDictionary *)environmentNutritionSourcingGoodThisWeek
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *categoryLocalItems = [NSMutableArray new];
    NSMutableArray *categoryVendorItems = [NSMutableArray new];
    NSMutableArray *categoryOrganicItems = [NSMutableArray new];
    NSMutableArray *categoryFarmersMarketItems = [NSMutableArray new];
    NSMutableArray *categoryFarmToTableItems = [NSMutableArray new];
    NSMutableArray *categoryCSAItems = [NSMutableArray new];
    
    NSMutableDictionary *goodThisWeek = [NSMutableDictionary new];
    
    for (LORootItem *rootItem in items) {
        for (LOFood *food in rootItem.foods) {
            if ([food.date isThisWeek]) {
                NSArray *categories = (NSArray *)food.categories;
                NSNumber *type = food.type;

                for (NSNumber *category in categories) {
                    if (type.integerValue != LOFoodTypeOther) {
                        if (category.integerValue == LOFoodCategoryLocal) {
                            [categoryLocalItems addObject:food];
                        } else if (category.integerValue == LOFoodCategoryVendor) {
                            [categoryVendorItems addObject:food];
                        } else if (category.integerValue == LOFoodCategoryOrganic) {
                            [categoryOrganicItems addObject:food];
                        } else if (category.integerValue == LOFoodCategoryFarmersMarket) {
                            [categoryFarmersMarketItems addObject:food];
                        } else if (category.integerValue == LOFoodCategoryFarmToTable) {
                            [categoryFarmToTableItems addObject:food];
                        } else if (category.integerValue == LOFoodCategoryCSA) {
                            [categoryCSAItems addObject:food];
                        }
                    }
                }
            }
        }
    }
    
    [goodThisWeek setValue:categoryLocalItems forKey:[[NSNumber numberWithInteger:LOFoodCategoryLocal] stringValue]];
    [goodThisWeek setValue:categoryVendorItems forKey:[[NSNumber numberWithInteger:LOFoodCategoryLocal] stringValue]];
    [goodThisWeek setValue:categoryOrganicItems forKey:[[NSNumber numberWithInteger:LOFoodCategoryOrganic] stringValue]];
    [goodThisWeek setValue:categoryFarmersMarketItems forKey:[[NSNumber numberWithInteger:LOFoodCategoryFarmersMarket] stringValue]];
    [goodThisWeek setValue:categoryFarmToTableItems forKey:[[NSNumber numberWithInteger:LOFoodCategoryFarmToTable] stringValue]];
    [goodThisWeek setValue:categoryCSAItems forKey:[[NSNumber numberWithInteger:LOFoodCategoryCSA] stringValue]];
    
    return goodThisWeek;
}

- (NSMutableDictionary *)environmentNutritionSourcingBadThisWeek
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *categoryConventionalItems = [NSMutableArray new];
    NSMutableArray *typeOtherItems = [NSMutableArray new];

    NSMutableDictionary *badThisWeek = [NSMutableDictionary new];
    
    for (LORootItem *rootItem in items) {
        for (LOFood *food in rootItem.foods) {
            if ([food.date isThisWeek]) {
                NSArray *categories = (NSArray *)food.categories;
                NSNumber *type = food.type;

                for (NSNumber *category in categories) {
                    if (category.integerValue == LOFoodCategoryConventional) {
                        [categoryConventionalItems addObject:food];
                    }
                }
                
                if (type.integerValue == LOFoodTypeOther) {
                    [typeOtherItems addObject:food];
                }
            }
        }
    }
    
    [badThisWeek setValue:typeOtherItems forKey:[[NSNumber numberWithInteger:100] stringValue]];
    [badThisWeek setValue:categoryConventionalItems forKey:[[NSNumber numberWithInteger:LOFoodCategoryConventional] stringValue]];
    
    return badThisWeek;
}

- (NSMutableDictionary *)environmentNutritionSourcingGoodLastWeek
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *categoryLocalItems = [NSMutableArray new];
    NSMutableArray *categoryVendorItems = [NSMutableArray new];
    NSMutableArray *categoryOrganicItems = [NSMutableArray new];
    NSMutableArray *categoryFarmersMarketItems = [NSMutableArray new];
    NSMutableArray *categoryFarmToTableItems = [NSMutableArray new];
    NSMutableArray *categoryCSAItems = [NSMutableArray new];
    
    NSMutableDictionary *goodThisWeek = [NSMutableDictionary new];
    
    for (LORootItem *rootItem in items) {
        for (LOFood *food in rootItem.foods) {
            if ([food.date isLastWeek]) {
                NSArray *categories = (NSArray *)food.categories;
                NSNumber *type = food.type;
                for (NSNumber *category in categories) {
                    if (type.integerValue != LOFoodTypeOther) {
                        if (category.integerValue == LOFoodCategoryLocal) {
                            [categoryLocalItems addObject:food];
                        } else if (category.integerValue == LOFoodCategoryVendor) {
                            [categoryVendorItems addObject:food];
                        } else if (category.integerValue == LOFoodCategoryOrganic) {
                            [categoryOrganicItems addObject:food];
                        } else if (category.integerValue == LOFoodCategoryFarmersMarket) {
                            [categoryFarmersMarketItems addObject:food];
                        } else if (category.integerValue == LOFoodCategoryFarmToTable) {
                            [categoryFarmToTableItems addObject:food];
                        } else if (category.integerValue == LOFoodCategoryCSA) {
                            [categoryCSAItems addObject:food];
                        }
                    }
                }
            }
        }
    }
    
    [goodThisWeek setValue:categoryLocalItems forKey:[[NSNumber numberWithInteger:LOFoodCategoryLocal] stringValue]];
    [goodThisWeek setValue:categoryVendorItems forKey:[[NSNumber numberWithInteger:LOFoodCategoryVendor] stringValue]];
    [goodThisWeek setValue:categoryOrganicItems forKey:[[NSNumber numberWithInteger:LOFoodCategoryOrganic] stringValue]];
    [goodThisWeek setValue:categoryFarmersMarketItems forKey:[[NSNumber numberWithInteger:LOFoodCategoryFarmersMarket] stringValue]];
    [goodThisWeek setValue:categoryFarmToTableItems forKey:[[NSNumber numberWithInteger:LOFoodCategoryFarmToTable] stringValue]];
    [goodThisWeek setValue:categoryCSAItems forKey:[[NSNumber numberWithInteger:LOFoodCategoryCSA] stringValue]];
    
    return goodThisWeek;
}


- (NSMutableDictionary *)environmentNutritionSourcingBadLastWeek
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *categoryConventionalItems = [NSMutableArray new];
    NSMutableArray *typeOtherItems = [NSMutableArray new];

    NSMutableDictionary *badThisWeek = [NSMutableDictionary new];
    
    for (LORootItem *rootItem in items) {
        for (LOFood *food in rootItem.foods) {
            if ([food.date isLastWeek]) {
                NSArray *categories = (NSArray *)food.categories;
                NSNumber *type = food.type;
                
                for (NSNumber *category in categories) {
                    if (category.integerValue == LOFoodCategoryConventional) {
                        [categoryConventionalItems addObject:food];
                    }
                }
                
                if (type.integerValue == LOFoodTypeOther) {
                    [typeOtherItems addObject:food];
                }
            }
        }
    }
    [badThisWeek setValue:typeOtherItems forKey:[[NSNumber numberWithInteger:100] stringValue]]; //use random value here...
    [badThisWeek setValue:categoryConventionalItems forKey:[[NSNumber numberWithInteger:LOFoodCategoryConventional] stringValue]];
    
    return badThisWeek;
}


- (NSMutableDictionary *)environmentMovementSourcingGoodThisWeek
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *categoryFitnessItems = [NSMutableArray new];
    NSMutableArray *categoryUtilitarianItems = [NSMutableArray new];
    NSMutableDictionary *goodThisWeek = [NSMutableDictionary new];
    
    for (LORootItem *rootItem in items) {
        for (LOActivity *activity in rootItem.activities) {
            if ([activity.date isThisWeek]) {
                NSNumber *type = activity.type;
                if (type.integerValue != LOActivityTypeOther) {
                    if (activity.category.integerValue == LOActivityCategoryFitness) {
                        [categoryFitnessItems addObject:activity];
                    } else if (activity.category.integerValue == LOActivityCategoryUtilitarian) {
                        [categoryUtilitarianItems addObject:activity];
                    }
                }
            }
        }
    }
    
    [goodThisWeek setValue:categoryFitnessItems forKey:[[NSNumber numberWithInteger:LOActivityCategoryFitness] stringValue]];
    [goodThisWeek setValue:categoryUtilitarianItems forKey:[[NSNumber numberWithInteger:LOActivityCategoryUtilitarian] stringValue]];
    
    return goodThisWeek;
}

- (NSMutableDictionary *)environmentMovementSourcingGoodLastWeek
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *categoryFitnessItems = [NSMutableArray new];
    NSMutableArray *categoryUtilitarianItems = [NSMutableArray new];
    NSMutableDictionary *goodLastWeek = [NSMutableDictionary new];
    
    for (LORootItem *rootItem in items) {
        for (LOActivity *activity in rootItem.activities) {
            if ([activity.date isLastWeek]) {
                NSNumber *type = activity.type;
                if (type.integerValue != LOActivityTypeOther) {
                    if (activity.category.integerValue == LOActivityCategoryFitness) {
                        [categoryFitnessItems addObject:activity];
                    } else if (activity.category.integerValue == LOActivityCategoryUtilitarian) {
                        [categoryUtilitarianItems addObject:activity];
                    }
                }
            }
        }
    }
    
    [goodLastWeek setValue:categoryFitnessItems forKey:[[NSNumber numberWithInteger:LOActivityCategoryFitness] stringValue]];
    [goodLastWeek setValue:categoryUtilitarianItems forKey:[[NSNumber numberWithInteger:LOActivityCategoryUtilitarian] stringValue]];
    
    return goodLastWeek;
}

- (NSMutableDictionary *)environmentMovementSourcingBadLastWeek
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *categoryOtherItems = [NSMutableArray new];
    
    NSMutableDictionary *badLastWeek = [NSMutableDictionary new];
    
    for (LORootItem *rootItem in items) {
        for (LOActivity *activity in rootItem.activities) {
            if ([activity.date isLastWeek]) {
                if (activity.type.integerValue == LOActivityTypeOther) {
                    [categoryOtherItems addObject:activity];
                }
            }
        }
    }
    
    [badLastWeek setValue:categoryOtherItems forKey:[[NSNumber numberWithInteger:100] stringValue]];
    
    return badLastWeek;
}

- (NSMutableDictionary *)environmentMovementSourcingBadThisWeek
{
    NSArray *items = [LORootItem MR_findAll];
    NSMutableArray *categoryOtherItems = [NSMutableArray new];
    
    NSMutableDictionary *badThisWeek = [NSMutableDictionary new];
    
    for (LORootItem *rootItem in items) {
        for (LOActivity *activity in rootItem.activities) {
            if ([activity.date isThisWeek]) {
                if (activity.type.integerValue == LOActivityTypeOther) {
                    [categoryOtherItems addObject:activity];
                }
            }
        }
    }
    
    [badThisWeek setValue:categoryOtherItems forKey:[[NSNumber numberWithInteger:100] stringValue]];
    
    return badThisWeek;
}

- (NSString *)healthHowToImproveNutritionDataStringThisWeek {
    
    NSString *howToImproveString = [NSString new];
    
    for (LORootItem *rootItem in [self healthNutritionMoreThisWeekBad]) {
        NSString *stringToAdd = [NSString stringWithFormat:@"Try having less %@ next week than you did this week.", rootItem.title];
        howToImproveString = [NSString stringWithFormat:@"%@ \n\n%@", howToImproveString, stringToAdd];
    }
    
    for (LORootItem *rootItem in [self healthNutritionLessThisWeekBad]) {
        NSString *stringToAdd = [NSString stringWithFormat:@"Try having more %@ next week than you did this week.", rootItem.title];
        howToImproveString = [NSString stringWithFormat:@"%@ \n\n%@", howToImproveString, stringToAdd];
    }
    
    if (howToImproveString.length <= 0) {
        howToImproveString = @"Data is not yet available.";
    }

    return howToImproveString;
}

- (NSString *)healthWhatWeLikeNutritionDataStringThisWeek {

    NSString *whatWeLikeString = [NSString new];

    for (LORootItem *rootItem in [self healthNutritionMoreThisWeekGood]) {
        NSString *stringToAdd = [NSString stringWithFormat:@"You had more %@ this week than you did last week.", rootItem.title];
        whatWeLikeString = [NSString stringWithFormat:@"%@ \n\n%@", whatWeLikeString, stringToAdd];
    }
    
    for (LORootItem *rootItem in [self healthNutritionLessThisWeekGood]) {
        NSString *stringToAdd = [NSString stringWithFormat:@"You had less %@ this week than you did last week.", rootItem.title];
        whatWeLikeString = [NSString stringWithFormat:@"%@ \n\n%@", whatWeLikeString, stringToAdd];
    }
    
    if (whatWeLikeString.length <= 0) {
        whatWeLikeString = @"Data is not yet available.";
    }
    
    return whatWeLikeString;
}

- (NSString *)healthHowToImproveMovementDataStringThisWeek {
    
    NSString *howToImproveString = [NSString new];
    
    for (LORootItem *rootItem in [self healthMovementMoreThisWeekBad]) {
        NSString *stringToAdd = [NSString stringWithFormat:@"Try doing less %@ next week than you did this week.", rootItem.title];
        howToImproveString = [NSString stringWithFormat:@"%@ \n\n%@", howToImproveString, stringToAdd];
    }
    
    for (LORootItem *rootItem in [self healthMovementLessThisWeekBad]) {
        NSString *stringToAdd = [NSString stringWithFormat:@"Try doing more %@ next week than you did this week.", rootItem.title];
        howToImproveString = [NSString stringWithFormat:@"%@ \n\n%@", howToImproveString, stringToAdd];
    }
    
    if (howToImproveString.length <= 0) {
        howToImproveString = @"Data is not yet available.";
    }
    
    return howToImproveString;
}

- (NSString *)healthWhatWeLikeMovementDataStringThisWeek {
    
    NSString *whatWeLikeString = [NSString new];
    
    for (LORootItem *rootItem in [self healthMovementMoreThisWeekGood]) {
        NSString *stringToAdd = [NSString stringWithFormat:@"You did more %@ this week than you did last week.", rootItem.title];
        whatWeLikeString = [NSString stringWithFormat:@"%@ \n\n%@", whatWeLikeString, stringToAdd];
    }
    
    for (LORootItem *rootItem in [self healthMovementLessThisWeekGood]) {
        NSString *stringToAdd = [NSString stringWithFormat:@"You did less %@ this week than you did last week.", rootItem.title];
        whatWeLikeString = [NSString stringWithFormat:@"%@ \n\n%@", whatWeLikeString, stringToAdd];
    }
    
    if (whatWeLikeString.length <= 0) {
        whatWeLikeString = @"Data is not yet available.";
    }
    
    return whatWeLikeString;
}

// last
- (NSString *)healthHowToImproveNutritionDataStringLastWeek {
    
    NSString *howToImproveString = [NSString new];
    
    for (LORootItem *rootItem in [self healthNutritionMoreLastWeekBad]) {
        NSString *stringToAdd = [NSString stringWithFormat:@"Try having less %@ this week than you did last week.", rootItem.title];
        howToImproveString = [NSString stringWithFormat:@"%@ \n\n%@", howToImproveString, stringToAdd];
    }
    
    for (LORootItem *rootItem in [self healthNutritionLessLastWeekBad]) {
        NSString *stringToAdd = [NSString stringWithFormat:@"Try having more %@ this week than you did last week.", rootItem.title];
        howToImproveString = [NSString stringWithFormat:@"%@ \n\n%@", howToImproveString, stringToAdd];
    }
    
    if (howToImproveString.length <= 0) {
        howToImproveString = @"Data is not yet available.";
    }
    
    return howToImproveString;
}

- (NSString *)healthWhatWeLikeNutritionDataStringLastWeek {
    
    NSString *whatWeLikeString = [NSString new];
    
    for (LORootItem *rootItem in [self healthNutritionMoreLastWeekGood]) {
        NSString *stringToAdd = [NSString stringWithFormat:@"You had more %@ last week than you did the week before last week.", rootItem.title];
        whatWeLikeString = [NSString stringWithFormat:@"%@ \n\n%@", whatWeLikeString, stringToAdd];
    }
    
    for (LORootItem *rootItem in [self healthNutritionLessLastWeekGood]) {
        NSString *stringToAdd = [NSString stringWithFormat:@"You had less %@ last week than you did the week before last week.", rootItem.title];
        whatWeLikeString = [NSString stringWithFormat:@"%@ \n\n%@", whatWeLikeString, stringToAdd];
    }
    
    if (whatWeLikeString.length <= 0) {
        whatWeLikeString = @"Data is not yet available.";
    }
    
    return whatWeLikeString;
}

- (NSString *)healthHowToImproveMovementDataStringLastWeek {
    
    NSString *howToImproveString = [NSString new];
    
    for (LORootItem *rootItem in [self healthMovementMoreLastWeekBad]) {
        NSString *stringToAdd = [NSString stringWithFormat:@"Try doing less %@ this week than you did last week.", rootItem.title];
        howToImproveString = [NSString stringWithFormat:@"%@ \n\n%@", howToImproveString, stringToAdd];
    }
    
    for (LORootItem *rootItem in [self healthMovementLessLastWeekBad]) {
        NSString *stringToAdd = [NSString stringWithFormat:@"Try doing more %@ this week than you did last week.", rootItem.title];
        howToImproveString = [NSString stringWithFormat:@"%@ \n\n%@", howToImproveString, stringToAdd];
    }
    
    if (howToImproveString.length <= 0) {
        howToImproveString = @"Data is not yet available.";
    }
    
    return howToImproveString;
}

- (NSString *)healthWhatWeLikeMovementDataStringLastWeek {
    
    NSString *whatWeLikeString = [NSString new];
    
    for (LORootItem *rootItem in [self healthMovementMoreLastWeekGood]) {
        NSString *stringToAdd = [NSString stringWithFormat:@"You did more %@ last week than you did the week before last week.", rootItem.title];
        whatWeLikeString = [NSString stringWithFormat:@"%@ \n\n%@", whatWeLikeString, stringToAdd];
    }
    
    for (LORootItem *rootItem in [self healthMovementLessLastWeekGood]) {
        NSString *stringToAdd = [NSString stringWithFormat:@"You did less %@ last week than you did the week before last week.", rootItem.title];
        whatWeLikeString = [NSString stringWithFormat:@"%@ \n\n%@", whatWeLikeString, stringToAdd];
    }
    
    if (whatWeLikeString.length <= 0) {
        whatWeLikeString = @"Data is not yet available.";
    }
    
    return whatWeLikeString;
}
// last

- (NSString *)environmentHowToImproveNutritionThisWeekDataString {
    
    NSString *howToImproveString = [NSString new];
    
    NSMutableDictionary *data = [self environmentNutritionSourcingBadThisWeek];
    
    for (NSString *categoryKey in [data allKeys]) {
        LORootItem *lastRootItem;
        for (LOFood *food in (NSMutableArray *)[data valueForKey:categoryKey]) {
            if (food.rootItem != lastRootItem) {
                
                //add unique string
                NSString *stringToAdd = [NSString stringWithFormat:@"Try having less %@ %@ next week", [self stringForFoodCategory:categoryKey.integerValue], food.rootItem.title];
                howToImproveString = [NSString stringWithFormat:@"%@ \n\n%@", howToImproveString, stringToAdd];
                
                lastRootItem = food.rootItem;
            }
        }
    }
    
    if (howToImproveString.length <= 0) {
        howToImproveString = @"Data is not yet available.";
    }
    
    return howToImproveString;
}

- (NSString *)environmentWhatWeLikeNutritionThisWeekDataString {
    
    NSString *whatWeLikeString = [NSString new];
    
    NSMutableDictionary *data = [self environmentNutritionSourcingGoodThisWeek];
    
    for (NSString *categoryKey in [data allKeys]) {
        LORootItem *lastRootItem;
        for (LOFood *food in (NSMutableArray *)[data valueForKey:categoryKey]) {
            if (food.rootItem != lastRootItem) {
                
                //add unique string
                NSString *stringToAdd = [NSString stringWithFormat:@"You had %@ %@ this week", [self stringForFoodCategory:categoryKey.integerValue], food.rootItem.title];
                whatWeLikeString = [NSString stringWithFormat:@"%@ \n\n%@", whatWeLikeString, stringToAdd];
                
                lastRootItem = food.rootItem;
            }
        }
    }
    
    if (whatWeLikeString.length <= 0) {
        whatWeLikeString = @"Data is not yet available.";
    }
    
    return whatWeLikeString;
}

- (NSString *)environmentHowToImproveNutritionLastWeekDataString {
    
    NSString *howToImproveString = [NSString new];
    
    NSMutableDictionary *data = [self environmentNutritionSourcingBadLastWeek];
    
    for (NSString *categoryKey in [data allKeys]) {
        LORootItem *lastRootItem;
        for (LOFood *food in (NSMutableArray *)[data valueForKey:categoryKey]) {
            if (food.rootItem != lastRootItem) {
                
                //add unique string
                NSString *stringToAdd = [NSString stringWithFormat:@"Try having less %@ %@ next week", [self stringForFoodCategory:categoryKey.integerValue], food.rootItem.title];
                howToImproveString = [NSString stringWithFormat:@"%@ \n\n%@", howToImproveString, stringToAdd];
                
                lastRootItem = food.rootItem;
            }
        }
    }
    
    if (howToImproveString.length <= 0) {
        howToImproveString = @"Data is not yet available.";
    }
    
    return howToImproveString;
}


- (NSString *)environmentWhatWeLikeNutritionLastWeekDataString {
    
    NSString *whatWeLikeString = [NSString new];
    
    NSMutableDictionary *data = [self environmentNutritionSourcingGoodLastWeek];
    
    for (NSString *categoryKey in [data allKeys]) {
        LORootItem *lastRootItem;
        for (LOFood *food in (NSMutableArray *)[data valueForKey:categoryKey]) {
            if (food.rootItem != lastRootItem) {
                
                //add unique string
                NSString *stringToAdd = [NSString stringWithFormat:@"You had %@ %@ last week", [self stringForFoodCategory:categoryKey.integerValue], food.rootItem.title];
                whatWeLikeString = [NSString stringWithFormat:@"%@ \n\n%@", whatWeLikeString, stringToAdd];
                
                lastRootItem = food.rootItem;
            }
        }
    }
    
    if (whatWeLikeString.length <= 0) {
        whatWeLikeString = @"Data is not yet available.";
    }
    
    return whatWeLikeString;
}


- (NSString *)environmentHowToImproveMovementThisWeekDataString {
    
    NSString *howToImproveString = [NSString new];
    
    NSMutableDictionary *data = [self environmentMovementSourcingBadThisWeek];
    
    for (NSString *categoryKey in [data allKeys]) {
        LORootItem *lastRootItem;
        for (LOActivity *activity in (NSMutableArray *)[data valueForKey:categoryKey]) {
            if (activity.rootItem != lastRootItem) {
                
                //add unique string
                NSString *stringToAdd = [NSString stringWithFormat:@"Try doing less %@ %@ next week", [self stringForActivityCategory:categoryKey.integerValue], activity.rootItem.title];
                howToImproveString = [NSString stringWithFormat:@"%@ \n\n%@", howToImproveString, stringToAdd];
                
                lastRootItem = activity.rootItem;
            }
        }
    }
    
    if (howToImproveString.length <= 0) {
        howToImproveString = @"Data is not yet available.";
    }
    
    return howToImproveString;
}

- (NSString *)environmentWhatWeLikeMovementThisWeekDataString {
    
    NSString *whatWeLikeString = [NSString new];
    
    NSMutableDictionary *data = [self environmentMovementSourcingGoodThisWeek];
    
    for (NSString *categoryKey in [data allKeys]) {
        LORootItem *lastRootItem;
        for (LOActivity *activity in (NSMutableArray *)[data valueForKey:categoryKey]) {
            if (activity.rootItem != lastRootItem) {
                
                //add unique string
                NSString *stringToAdd = [NSString stringWithFormat:@"You did %@ %@ this week", [self stringForActivityCategory:categoryKey.integerValue], activity.rootItem.title];
                whatWeLikeString = [NSString stringWithFormat:@"%@ \n\n%@", whatWeLikeString, stringToAdd];
                
                lastRootItem = activity.rootItem;
            }
        }
    }
    
    if (whatWeLikeString.length <= 0) {
        whatWeLikeString = @"Data is not yet available.";
    }
    
    return whatWeLikeString;
}

- (NSString *)environmentHowToImproveMovementLastWeekDataString {
    
    NSString *howToImproveString = [NSString new];
    
    NSMutableDictionary *data = [self environmentMovementSourcingBadLastWeek];
    
    for (NSString *categoryKey in [data allKeys]) {
        LORootItem *lastRootItem;
        for (LOActivity *activity in (NSMutableArray *)[data valueForKey:categoryKey]) {
            if (activity.rootItem != lastRootItem) {
                
                //add unique string
                NSString *stringToAdd = [NSString stringWithFormat:@"Try doing less %@ %@ next week", [self stringForActivityCategory:categoryKey.integerValue], activity.rootItem.title];
                howToImproveString = [NSString stringWithFormat:@"%@ \n\n%@", howToImproveString, stringToAdd];
                
                lastRootItem = activity.rootItem;
            }
        }
    }
    
    if (howToImproveString.length <= 0) {
        howToImproveString = @"Data is not yet available.";
    }
    
    return howToImproveString;
}


- (NSString *)environmentWhatWeLikeMovementLastWeekDataString {
    
    NSString *whatWeLikeString = [NSString new];
    
    NSMutableDictionary *data = [self environmentMovementSourcingGoodLastWeek];
    
    for (NSString *categoryKey in [data allKeys]) {
        LORootItem *lastRootItem;
        for (LOActivity *activity in (NSMutableArray *)[data valueForKey:categoryKey]) {
            if (activity.rootItem != lastRootItem) {
                
                //add unique string
                NSString *stringToAdd = [NSString stringWithFormat:@"You did %@ %@ last week", [self stringForActivityCategory:categoryKey.integerValue], activity.rootItem.title];
                whatWeLikeString = [NSString stringWithFormat:@"%@ \n\n%@", whatWeLikeString, stringToAdd];
                
                lastRootItem = activity.rootItem;
            }
        }
    }
    
    if (whatWeLikeString.length <= 0) {
        whatWeLikeString = @"Data is not yet available.";
    }
    
    return whatWeLikeString;
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
            return @"Other";
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
            return @"Other";
            break;
    }
    
    return @"";
}

@end
