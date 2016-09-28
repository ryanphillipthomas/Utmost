//
//  LOCategorySourcingChartTableViewCell.m
//  Utmost
//
//  Created by Ryan Thomas on 8/25/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOCategorySourcingChartTableViewCell.h"
#import "LOScore.h"
#import "LOFood.h"

@implementation LOCategorySourcingChartTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.blurView = [[UIView alloc] initWithFrame:self.contentView.frame];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)configureCellForNutritionWithLabel:(NSString *)label
{
    [self.chartLabel setText:label];
    
    if (![self.contentView.subviews containsObject:self.blurView]) {
        [self.blurView setFrame:self.contentView.frame];
        //[self addBlurToView:self.blurView];
        
        [self.contentView addSubview:self.blurView];
        [self.contentView sendSubviewToBack:self.blurView];
    }
    
    if (self.isThisWeek) {
        [self setupNutritionOtherChartWithScore:[[LOScore sharedManager] thisWeekSourcingScoreDataForFoodType:LOFoodTypeOther]
                                      barColors:@[kDEEP_BLUE_COLOR,
                                                  kDARK_RED_COLOR,
                                                  kTEIL_COLOR,
                                                  kDARK_BLUE_COLOR,
                                                  kGREY_COLOR,
                                                  kDARK_GREY_COLOR,
                                                  kLIGHT_BLUE_COLOR,
                                                  kGREEN_COLOR]
                                       maxValue:[[LOScore sharedManager] nutritionSourcingOtherMaxValue]];

        
        [self setupNutritionRedProteinChartWithScore:[[LOScore sharedManager] thisWeekSourcingScoreDataForFoodType:LOFoodTypeRedProtein]
                                           barColors:@[kDEEP_BLUE_COLOR,
                                                       kDARK_RED_COLOR,
                                                       kTEIL_COLOR,
                                                       kDARK_BLUE_COLOR,
                                                       kGREY_COLOR,
                                                       kDARK_GREY_COLOR,
                                                       kLIGHT_BLUE_COLOR,
                                                       kGREEN_COLOR]
                                            maxValue:[[LOScore sharedManager] nutritionSourcingRedProteinMaxValue]];

        
        [self setupNutritionWhiteProteinChartWithScore:[[LOScore sharedManager] thisWeekSourcingScoreDataForFoodType:LOFoodTypeWhiteProtein]
                                             barColors:@[kDEEP_BLUE_COLOR,
                                                         kDARK_RED_COLOR,
                                                         kTEIL_COLOR,
                                                         kDARK_BLUE_COLOR,
                                                         kGREY_COLOR,
                                                         kDARK_GREY_COLOR,
                                                         kLIGHT_BLUE_COLOR,
                                                         kGREEN_COLOR]
                                              maxValue:[[LOScore sharedManager] nutritionSourcingWhiteProteinMaxValue]];

        
        [self setupNutritionNutChartWithScore:[[LOScore sharedManager] thisWeekSourcingScoreDataForFoodType:LOFoodTypeNut]
                                    barColors:@[kDEEP_BLUE_COLOR,
                                                kDARK_RED_COLOR,
                                                kTEIL_COLOR,
                                                kDARK_BLUE_COLOR,
                                                kGREY_COLOR,
                                                kDARK_GREY_COLOR,
                                                kLIGHT_BLUE_COLOR,
                                                kGREEN_COLOR]
                                     maxValue:[[LOScore sharedManager] nutritionSourcingNutMaxValue]];

        
        [self setupNutritionFruitChartWithScore:[[LOScore sharedManager] thisWeekSourcingScoreDataForFoodType:LOFoodTypeFruit]
                                      barColors:@[kDEEP_BLUE_COLOR,
                                                  kDARK_RED_COLOR,
                                                  kTEIL_COLOR,
                                                  kDARK_BLUE_COLOR,
                                                  kGREY_COLOR,
                                                  kDARK_GREY_COLOR,
                                                  kLIGHT_BLUE_COLOR,
                                                  kGREEN_COLOR]
                                       maxValue:[[LOScore sharedManager] nutritionSourcingFruitMaxValue]];

        
        [self setupNutritionVegetableChartWithScore:[[LOScore sharedManager] thisWeekSourcingScoreDataForFoodType:LOFoodTypeVegetable]
                                          barColors:@[kDEEP_BLUE_COLOR,
                                                      kDARK_RED_COLOR,
                                                      kTEIL_COLOR,
                                                      kDARK_BLUE_COLOR,
                                                      kGREY_COLOR,
                                                      kDARK_GREY_COLOR,
                                                      kLIGHT_BLUE_COLOR,
                                                      kGREEN_COLOR]
                                           maxValue:[[LOScore sharedManager] nutritionSourcingVegetableMaxValue]];

        
        
        [self setupNutritionVegetableProteinChartWithScore:[[LOScore sharedManager] thisWeekSourcingScoreDataForFoodType:LOFoodTypePlantProtein]
                                                 barColors:@[kDEEP_BLUE_COLOR,
                                                             kDARK_RED_COLOR,
                                                             kTEIL_COLOR,
                                                             kDARK_BLUE_COLOR,
                                                             kGREY_COLOR,
                                                             kDARK_GREY_COLOR,
                                                             kLIGHT_BLUE_COLOR,
                                                             kGREEN_COLOR]
                                                  maxValue:[[LOScore sharedManager] nutritionSourcingVegetableProteinMaxValue]];

        
    }
    
    if (self.isLastWeek) {
        [self setupNutritionOtherChartWithScore:[[LOScore sharedManager] lastWeekSourcingScoreDataForFoodType:LOFoodTypeOther]
                                      barColors:@[kDEEP_BLUE_COLOR,
                                                  kDARK_RED_COLOR,
                                                  kTEIL_COLOR,
                                                  kDARK_BLUE_COLOR,
                                                  kGREY_COLOR,
                                                  kDARK_GREY_COLOR,
                                                  kLIGHT_BLUE_COLOR,
                                                  kGREEN_COLOR]
                                       maxValue:[[LOScore sharedManager] nutritionSourcingOtherMaxValue]];

        
        [self setupNutritionRedProteinChartWithScore:[[LOScore sharedManager] lastWeekSourcingScoreDataForFoodType:LOFoodTypeRedProtein]
                                           barColors:@[kDEEP_BLUE_COLOR,
                                                       kDARK_RED_COLOR,
                                                       kTEIL_COLOR,
                                                       kDARK_BLUE_COLOR,
                                                       kGREY_COLOR,
                                                       kDARK_GREY_COLOR,
                                                       kLIGHT_BLUE_COLOR,
                                                       kGREEN_COLOR]
                                            maxValue:[[LOScore sharedManager] nutritionSourcingRedProteinMaxValue]];

        
        [self setupNutritionWhiteProteinChartWithScore:[[LOScore sharedManager] lastWeekSourcingScoreDataForFoodType:LOFoodTypeWhiteProtein]
                                             barColors:@[kDEEP_BLUE_COLOR,
                                                         kDARK_RED_COLOR,
                                                         kTEIL_COLOR,
                                                         kDARK_BLUE_COLOR,
                                                         kGREY_COLOR,
                                                         kDARK_GREY_COLOR,
                                                         kLIGHT_BLUE_COLOR,
                                                         kGREEN_COLOR]
                                              maxValue:[[LOScore sharedManager] nutritionSourcingWhiteProteinMaxValue]];

        
        [self setupNutritionNutChartWithScore:[[LOScore sharedManager] lastWeekSourcingScoreDataForFoodType:LOFoodTypeNut]
                                    barColors:@[kDEEP_BLUE_COLOR,
                                                kDARK_RED_COLOR,
                                                kTEIL_COLOR,
                                                kDARK_BLUE_COLOR,
                                                kGREY_COLOR,
                                                kDARK_GREY_COLOR,
                                                kLIGHT_BLUE_COLOR,
                                                kGREEN_COLOR]
                                     maxValue:[[LOScore sharedManager] nutritionSourcingNutMaxValue]];

        
        [self setupNutritionFruitChartWithScore:[[LOScore sharedManager] lastWeekSourcingScoreDataForFoodType:LOFoodTypeFruit]
                                      barColors:@[kDEEP_BLUE_COLOR,
                                                  kDARK_RED_COLOR,
                                                  kTEIL_COLOR,
                                                  kDARK_BLUE_COLOR,
                                                  kGREY_COLOR,
                                                  kDARK_GREY_COLOR,
                                                  kLIGHT_BLUE_COLOR,
                                                  kGREEN_COLOR]
                                       maxValue:[[LOScore sharedManager] nutritionSourcingFruitMaxValue]];

        
        [self setupNutritionVegetableChartWithScore:[[LOScore sharedManager] lastWeekSourcingScoreDataForFoodType:LOFoodTypeVegetable]
                                          barColors:@[kDEEP_BLUE_COLOR,
                                                      kDARK_RED_COLOR,
                                                      kTEIL_COLOR,
                                                      kDARK_BLUE_COLOR,
                                                      kGREY_COLOR,
                                                      kDARK_GREY_COLOR,
                                                      kLIGHT_BLUE_COLOR,
                                                      kGREEN_COLOR]
                                           maxValue:[[LOScore sharedManager] nutritionSourcingVegetableMaxValue]];

        
        
        [self setupNutritionVegetableProteinChartWithScore:[[LOScore sharedManager] lastWeekSourcingScoreDataForFoodType:LOFoodTypePlantProtein]
                                                 barColors:@[kDEEP_BLUE_COLOR,
                                                             kDARK_RED_COLOR,
                                                             kTEIL_COLOR,
                                                             kDARK_BLUE_COLOR,
                                                             kGREY_COLOR,
                                                             kDARK_GREY_COLOR,
                                                             kLIGHT_BLUE_COLOR,
                                                             kGREEN_COLOR]
                                                  maxValue:[[LOScore sharedManager] nutritionSourcingVegetableProteinMaxValue]];

    }
}

- (void)configureCellForMovementWithLabel:(NSString *)label
{
    [self.chartLabel setText:label];

    if (![self.contentView.subviews containsObject:self.blurView]) {
        [self.blurView setFrame:self.contentView.frame];
        //[self addBlurToView:self.blurView];
        
        [self.contentView addSubview:self.blurView];
        [self.contentView sendSubviewToBack:self.blurView];
    }
    
    if (self.isThisWeek) {
        [self setupMovementOtherChartWithScore:[[LOScore sharedManager] thisWeekSourcingScoreDataForActivityType:LOActivityTypeOther]
                                     barColors:@[kDEEP_BLUE_COLOR,
                                                 kDARK_RED_COLOR,
                                                 kTEIL_COLOR]
                                      maxValue:[[LOScore sharedManager] movementSourcingOtherMaxValue]];

        
        [self setupMovementStrengthChartWithScore:[[LOScore sharedManager] thisWeekSourcingScoreDataForActivityType:LOActivityTypeStrength]
                                        barColors:@[kDEEP_BLUE_COLOR,
                                                    kDARK_RED_COLOR,
                                                    kTEIL_COLOR]
                                         maxValue:[[LOScore sharedManager] movementSourcingStrengthMaxValue]];
        
        [self setupMovementCardioChartWithScore:[[LOScore sharedManager] thisWeekSourcingScoreDataForActivityType:LOActivityTypeCardio]
                                      barColors:@[kDEEP_BLUE_COLOR,
                                                  kDARK_RED_COLOR,
                                                  kTEIL_COLOR]
                                       maxValue:[[LOScore sharedManager] movementSourcingCardioMaxValue]];

        
        [self setupMovementFlexibilityChartWithScore:[[LOScore sharedManager] thisWeekSourcingScoreDataForActivityType:LOActivityTypeFlexibility]
                                           barColors:@[kDEEP_BLUE_COLOR,
                                                       kDARK_RED_COLOR,
                                                       kTEIL_COLOR]
                                            maxValue:[[LOScore sharedManager] movementSourcingFlexibilityMaxValue]];

    }
    
    if (self.isLastWeek) {
        [self setupMovementOtherChartWithScore:[[LOScore sharedManager] lastWeekSourcingScoreDataForActivityType:LOActivityTypeOther]
                                     barColors:@[kDEEP_BLUE_COLOR,
                                                 kDARK_RED_COLOR,
                                                 kTEIL_COLOR]
                                      maxValue:[[LOScore sharedManager] movementSourcingOtherMaxValue]];

        
        [self setupMovementStrengthChartWithScore:[[LOScore sharedManager] lastWeekSourcingScoreDataForActivityType:LOActivityTypeStrength]
                                        barColors:@[kDEEP_BLUE_COLOR,
                                                    kDARK_RED_COLOR,
                                                    kTEIL_COLOR]
                                         maxValue:[[LOScore sharedManager] movementSourcingStrengthMaxValue]];

        
        [self setupMovementCardioChartWithScore:[[LOScore sharedManager] lastWeekSourcingScoreDataForActivityType:LOActivityTypeCardio]
                                      barColors:@[kDEEP_BLUE_COLOR,
                                                  kDARK_RED_COLOR,
                                                  kTEIL_COLOR]
                                       maxValue:[[LOScore sharedManager] movementSourcingCardioMaxValue]];

        
        [self setupMovementFlexibilityChartWithScore:[[LOScore sharedManager] lastWeekSourcingScoreDataForActivityType:LOActivityTypeFlexibility]
                                           barColors:@[kDEEP_BLUE_COLOR,
                                                       kDARK_RED_COLOR,
                                                       kTEIL_COLOR]
                                            maxValue:[[LOScore sharedManager] movementSourcingFlexibilityMaxValue]];

    }
}

- (void)configureCellForLifestyleWithLabel:(NSString *)label
{
    [self.chartLabel setText:label];

    if (![self.contentView.subviews containsObject:self.blurView]) {
        [self.blurView setFrame:self.contentView.frame];
        //[self addBlurToView:self.blurView];
        
        [self.contentView addSubview:self.blurView];
        [self.contentView sendSubviewToBack:self.blurView];
    }
    
    [self setupNutritionOtherChartWithScore:@[]
                                  barColors:@[]
                                   maxValue:0.0f];

    
    [self setupNutritionRedProteinChartWithScore:@[]
                                       barColors:@[]
                                        maxValue:0.0f];

    
    [self setupNutritionWhiteProteinChartWithScore:@[]
                                         barColors:@[]
                                          maxValue:0.0f];

    
    [self setupNutritionNutChartWithScore:@[]
                                barColors:@[]
                                 maxValue:0.0f];

    
    [self setupNutritionFruitChartWithScore:@[]
                                  barColors:@[]
                                   maxValue:0.0f];

    
    [self setupNutritionVegetableChartWithScore:@[]
                                      barColors:@[]
                                       maxValue:0.0f];
    
    
    [self setupNutritionVegetableProteinChartWithScore:@[]
                                             barColors:@[]
                                              maxValue:0.0f];
    
}

- (void)setupNutritionOtherChartWithScore:(NSArray *)score barColors:(NSArray *)barColors maxValue:(CGFloat )maxValue
{
    // Line chart, the code way
    TEABarChart *otherChart = [[TEABarChart alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    
    if (maxValue > 64) {
        maxValue = 64;
    }
    
    otherChart.max = maxValue;
    otherChart.data = score;
    otherChart.barColors = barColors;
    otherChart.backgroundColor = kCHART_BACKROUND_COLOR;
    self.otherChartView.backgroundColor = [UIColor whiteColor];
    [self.otherChartView addSubview:otherChart];
}

- (void)setupNutritionRedProteinChartWithScore:(NSArray *)score barColors:(NSArray *)barColors maxValue:(CGFloat )maxValue
{
    
    TEABarChart *redProteinChart = [[TEABarChart alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    
    if (maxValue > 64) {
        maxValue = 64;
    }
    
    redProteinChart.max = maxValue;
    redProteinChart.data = score;
    redProteinChart.barColors = barColors;
    redProteinChart.backgroundColor = kCHART_BACKROUND_COLOR;
    self.redProteinChartView.backgroundColor = [UIColor whiteColor];
    [self.redProteinChartView addSubview:redProteinChart];
}

- (void)setupNutritionWhiteProteinChartWithScore:(NSArray *)score barColors:(NSArray *)barColors maxValue:(CGFloat )maxValue
{
    
    TEABarChart *whiteProteinChart = [[TEABarChart alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    
    if (maxValue > 64) {
        maxValue = 64;
    }
    
    whiteProteinChart.max = maxValue;
    whiteProteinChart.data = score;
    whiteProteinChart.barColors = barColors;
    whiteProteinChart.backgroundColor = kCHART_BACKROUND_COLOR;
    self.whiteProteinChartView.backgroundColor = [UIColor whiteColor];
    [self.whiteProteinChartView addSubview:whiteProteinChart];
}

- (void)setupNutritionNutChartWithScore:(NSArray *)score barColors:(NSArray *)barColors maxValue:(CGFloat )maxValue
{
    TEABarChart *nutsChart = [[TEABarChart alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    
    if (maxValue > 64) {
        maxValue = 64;
    }
    
    nutsChart.max = maxValue;
    nutsChart.data = score;
    nutsChart.barColors = barColors;
    nutsChart.backgroundColor = [UIColor whiteColor];
    self.nutsChartView.backgroundColor = kCHART_BACKROUND_COLOR;
    [self.nutsChartView addSubview:nutsChart];
}

- (void)setupNutritionFruitChartWithScore:(NSArray *)score barColors:(NSArray *)barColors maxValue:(CGFloat )maxValue
{
    TEABarChart *fruitChart = [[TEABarChart alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    
    if (maxValue > 64) {
        maxValue = 64;
    }
    
    fruitChart.max = maxValue;
    fruitChart.data = score;
    fruitChart.barColors = barColors;
    fruitChart.backgroundColor = [UIColor whiteColor];
    self.fruitChartView.backgroundColor = kCHART_BACKROUND_COLOR;
    [self.fruitChartView addSubview:fruitChart];
}

- (void)setupNutritionVegetableChartWithScore:(NSArray *)score barColors:(NSArray *)barColors maxValue:(CGFloat )maxValue
{
    TEABarChart *vegetableChart = [[TEABarChart alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    
    if (maxValue > 64) {
        maxValue = 64;
    }
    
    vegetableChart.max = maxValue;
    vegetableChart.data = score;
    vegetableChart.barColors = barColors;
    vegetableChart.backgroundColor = kCHART_BACKROUND_COLOR;
    self.vegetableChartView.backgroundColor = [UIColor whiteColor];
    [self.vegetableChartView addSubview:vegetableChart];
}

- (void)setupNutritionVegetableProteinChartWithScore:(NSArray *)score barColors:(NSArray *)barColors maxValue:(CGFloat )maxValue
{
    TEABarChart *vegetableproteinChart= [[TEABarChart alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    
    if (maxValue > 64) {
        maxValue = 64;
    }
    
    vegetableproteinChart.max = maxValue;
    vegetableproteinChart.data = score;
    vegetableproteinChart.barColors = barColors;
    vegetableproteinChart.backgroundColor = kCHART_BACKROUND_COLOR;
    self.vegetableproteinChartView.backgroundColor = [UIColor whiteColor];
    [self.vegetableproteinChartView addSubview:vegetableproteinChart];
}



- (void)setupMovementOtherChartWithScore:(NSArray *)score barColors:(NSArray *)barColors maxValue:(CGFloat )maxValue
{
    TEABarChart *movementOtherChart= [[TEABarChart alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    
    if (maxValue > 64) {
        maxValue = 64;
    }
    
    movementOtherChart.max = maxValue;
    movementOtherChart.data = score;
    movementOtherChart.barColors = barColors;
    movementOtherChart.backgroundColor = kCHART_BACKROUND_COLOR;
    self.movementOtherChartView.backgroundColor = [UIColor whiteColor];
    [self.movementOtherChartView addSubview:movementOtherChart];
}


- (void)setupMovementStrengthChartWithScore:(NSArray *)score barColors:(NSArray *)barColors maxValue:(CGFloat )maxValue
{
    TEABarChart *movementStrengthChart= [[TEABarChart alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    
    if (maxValue > 64) {
        maxValue = 64;
    }
    
    movementStrengthChart.max = maxValue;
    movementStrengthChart.data = score;
    movementStrengthChart.barColors = barColors;
    movementStrengthChart.backgroundColor = kCHART_BACKROUND_COLOR;
    self.movementStrengthChartView.backgroundColor = [UIColor whiteColor];
    [self.movementStrengthChartView addSubview:movementStrengthChart];
}

- (void)setupMovementCardioChartWithScore:(NSArray *)score barColors:(NSArray *)barColors maxValue:(CGFloat )maxValue
{
    TEABarChart *movementCardioChart= [[TEABarChart alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    
    if (maxValue > 64) {
        maxValue = 64;
    }
    
    movementCardioChart.max = maxValue;
    movementCardioChart.data = score;
    movementCardioChart.barColors = barColors;
    movementCardioChart.backgroundColor = kCHART_BACKROUND_COLOR;
    self.movementCardioChartView.backgroundColor = [UIColor whiteColor];
    [self.movementCardioChartView addSubview:movementCardioChart];
}

- (void)setupMovementFlexibilityChartWithScore:(NSArray *)score barColors:(NSArray *)barColors maxValue:(CGFloat )maxValue
{
    TEABarChart *movementFlexibilityChart= [[TEABarChart alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    
    if (maxValue > 64) {
        maxValue = 64;
    }
    
    movementFlexibilityChart.max = maxValue;
    movementFlexibilityChart.data = score;
    movementFlexibilityChart.barColors = barColors;
    movementFlexibilityChart.backgroundColor = kCHART_BACKROUND_COLOR;
    self.movementFlexibilityChartView.backgroundColor = [UIColor whiteColor];
    [self.movementFlexibilityChartView addSubview:movementFlexibilityChart];
}

- (void)addBlurToView:(UIView *)view {
    UIView *blurView = nil;
    
    if([UIBlurEffect class]) { // iOS 8
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurView.frame = view.frame;
        
    } else { // workaround for iOS 7
        blurView = [[UIToolbar alloc] initWithFrame:view.bounds];
    }
    
    [blurView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [view addSubview:blurView];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[blurView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(blurView)]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[blurView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(blurView)]];
}



@end
