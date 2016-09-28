//
//  LOScore.h
//  Utmost
//
//  Created by Ryan Thomas on 8/19/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LOScore : NSObject

+ (id)sharedManager;

//Last Week VS This Week Health And Environment Scores
// returns array of nsnumbers for (health lw, health tw) can specify to include food and activity items in the calcuation
- (NSArray *)lastWeekVSThisWeekHealthOnlyCurrentScoreDataWithFoodItems:(bool)withFoodItems withActivityItems:(bool)withActivityItems;
// returns array of nsnumbers for (env lw, env tw) can specify to include food and activity items in the calcuation
- (NSArray *)lastWeekVSThisWeekEnvironmentOnlyCurrentScoreDataWithFoodItems:(bool)withFoodItems withActivityItems:(bool)withActivityItems;

//Last Week OR This Week Health And Environment Scores
// returns array of nsnumbers for (health lw, env lw) can specify to include food and activity items in the calcuation
- (NSArray *)lastWeekHealthAndEnvironmentCurrentScoreDataWithFoodItems:(bool)withFoodItems withActivityItems:(bool)withActivityItems;

// returns array of nsnumbers for (health tw, env tw) can specify to include food and activity items in the calcuation
- (NSArray *)thisWeekHealthAndEnvironmentCurrentScoreDataWithFoodItems:(bool)withFoodItems withActivityItems:(bool)withActivityItems;


//FoodType Sourcing Scores
// returns array of nsnumbers
- (NSArray *)lastLastWeekQuantitiesScoreDataForAllFoodTypes;
- (NSArray *)lastWeekQuantitiesScoreDataForAllFoodTypes;

- (NSArray *)lastWeekSourcingScoreDataForFoodType:(NSInteger )foodType;

- (NSArray *)thisWeekQuantitiesScoreDataForAllFoodTypes;
- (NSArray *)thisWeekSourcingScoreDataForFoodType:(NSInteger )foodType;

//ActivityType Sourcing Scores
// returns array of nsnumbers
- (NSArray *)lastWeekQuantitiesScoreDataForAllActivityTypes;
- (NSArray *)lastLastWeekQuantitiesScoreDataForAllActivityTypes;

- (NSArray *)lastWeekSourcingScoreDataForActivityType:(NSInteger )activityType;
- (NSArray *)thisWeekQuantitiesScoreDataForAllActivityTypes;
- (NSArray *)thisWeekSourcingScoreDataForActivityType:(NSInteger )activityType;

// Health Scores

//this week
- (NSString *)healthHowToImproveNutritionDataStringThisWeek;
- (NSString *)healthWhatWeLikeNutritionDataStringThisWeek;
- (NSString *)healthHowToImproveMovementDataStringThisWeek;
- (NSString *)healthWhatWeLikeMovementDataStringThisWeek;

//last week
- (NSString *)healthHowToImproveNutritionDataStringLastWeek;
- (NSString *)healthWhatWeLikeNutritionDataStringLastWeek;
- (NSString *)healthHowToImproveMovementDataStringLastWeek;
- (NSString *)healthWhatWeLikeMovementDataStringLastWeek;

//last week
- (NSString *)environmentWhatWeLikeMovementLastWeekDataString;
- (NSString *)environmentHowToImproveMovementLastWeekDataString;
- (NSString *)environmentWhatWeLikeNutritionLastWeekDataString;
- (NSString *)environmentHowToImproveNutritionLastWeekDataString;

//this week
- (NSString *)environmentWhatWeLikeNutritionThisWeekDataString;
- (NSString *)environmentHowToImproveNutritionThisWeekDataString;
- (NSString *)environmentWhatWeLikeMovementThisWeekDataString;
- (NSString *)environmentHowToImproveMovementThisWeekDataString;

//Chart Max Score Values
- (CGFloat )homeLastWeekVSThisWeekHealthAndEnvironmentMaxValue_LastWeek;
- (CGFloat )homeLastWeekVSThisWeekHealthAndEnvironmentMaxValue_ThisWeek;

- (CGFloat )movementHealthAndEnvironmentThisWeekMaxValue;
- (CGFloat )nutritionHealthAndEnvironmentThisWeekMaxValue;
- (CGFloat )lifestyleHealthAndEnvironmentThisWeekMaxValue;

- (CGFloat )movementHealthAndEnvironmentLastWeekMaxValue;
- (CGFloat )nutritionHealthAndEnvironmentLastWeekMaxValue;
- (CGFloat )lifestyleHealthAndEnvironmentLastWeekMaxValue;

- (CGFloat )movementQuantitiesMaxValue;
- (CGFloat )nutritionQuantitiesMaxValue;
- (CGFloat )lifestyleQuantitiesMaxValue;

- (CGFloat )movementSourcingOtherMaxValue;
- (CGFloat )movementSourcingStrengthMaxValue;
- (CGFloat )movementSourcingCardioMaxValue;
- (CGFloat )movementSourcingFlexibilityMaxValue;

- (CGFloat )nutritionSourcingOtherMaxValue;
- (CGFloat )nutritionSourcingRedProteinMaxValue;
- (CGFloat )nutritionSourcingNutMaxValue;
- (CGFloat )nutritionSourcingWhiteProteinMaxValue;
- (CGFloat )nutritionSourcingFruitMaxValue;
- (CGFloat )nutritionSourcingVegetableMaxValue;
- (CGFloat )nutritionSourcingVegetableProteinMaxValue;



@end
