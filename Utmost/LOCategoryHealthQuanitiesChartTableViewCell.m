//
//  LOCategoryHealthQuanitiesChartTableViewCell.m
//  Utmost
//
//  Created by Ryan Thomas on 8/25/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOCategoryHealthQuanitiesChartTableViewCell.h"
#import "LOScore.h"

@implementation LOCategoryHealthQuanitiesChartTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.blurView = [[UIView alloc] initWithFrame:self.contentView.frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)configureCellForNutritionWithRightLabel:(NSString *)rightlabel leftLabel:(NSString *)leftLabel
{
    [self.rightLabel setText:rightlabel];
    [self.leftLabel setText:leftLabel];
    
    if (![self.contentView.subviews containsObject:self.blurView]) {
        [self.blurView setFrame:self.contentView.frame];
        //[self addBlurToView:self.blurView];
        
        [self.contentView addSubview:self.blurView];
        [self.contentView sendSubviewToBack:self.blurView];
    }

    if (self.isThisWeek) {
        [self setupLastWeekChartWithScore:[[LOScore sharedManager] lastWeekQuantitiesScoreDataForAllFoodTypes]
                                barColors:@[kDEEP_BLUE_COLOR,
                                            kDARK_RED_COLOR,
                                            kTEIL_COLOR,
                                            kDARK_BLUE_COLOR,
                                            kGREY_COLOR,
                                            kDARK_GREY_COLOR,
                                            kLIGHT_BLUE_COLOR]
                                 maxValue:[[LOScore sharedManager] nutritionQuantitiesMaxValue]];

        
        
        [self setupThisWeekChartWithScore:[[LOScore sharedManager] thisWeekQuantitiesScoreDataForAllFoodTypes]
                                barColors:@[kDEEP_BLUE_COLOR,
                                            kDARK_RED_COLOR,
                                            kTEIL_COLOR,
                                            kDARK_BLUE_COLOR,
                                            kGREY_COLOR,
                                            kDARK_GREY_COLOR,
                                            kLIGHT_BLUE_COLOR]
                                 maxValue:[[LOScore sharedManager] nutritionQuantitiesMaxValue]];

    }
    
    if (self.isLastWeek) {
        [self setupLastWeekChartWithScore:[[LOScore sharedManager] lastLastWeekQuantitiesScoreDataForAllFoodTypes] //would really be last last week :)
                                barColors:@[kDEEP_BLUE_COLOR,
                                            kDARK_RED_COLOR,
                                            kTEIL_COLOR,
                                            kDARK_BLUE_COLOR,
                                            kGREY_COLOR,
                                            kDARK_GREY_COLOR,
                                            kLIGHT_BLUE_COLOR]
                                 maxValue:[[LOScore sharedManager] nutritionQuantitiesMaxValue]];

        
        [self setupThisWeekChartWithScore:[[LOScore sharedManager] lastWeekQuantitiesScoreDataForAllFoodTypes]
                                barColors:@[kDEEP_BLUE_COLOR,
                                            kDARK_RED_COLOR,
                                            kTEIL_COLOR,
                                            kDARK_BLUE_COLOR,
                                            kGREY_COLOR,
                                            kDARK_GREY_COLOR,
                                            kLIGHT_BLUE_COLOR]
                                 maxValue:[[LOScore sharedManager] nutritionQuantitiesMaxValue]];

    }
}

- (void)configureCellForMovementWithRightLabel:(NSString *)rightlabel leftLabel:(NSString *)leftLabel
{
    
    [self.rightLabel setText:rightlabel];
    [self.leftLabel setText:leftLabel];
    
    if (![self.contentView.subviews containsObject:self.blurView]) {
        [self.blurView setFrame:self.contentView.frame];
        //[self addBlurToView:self.blurView];
        
        [self.contentView addSubview:self.blurView];
        [self.contentView sendSubviewToBack:self.blurView];
    }
    
    
    if (self.isThisWeek) {
        [self setupLastWeekChartWithScore:[[LOScore sharedManager] lastWeekQuantitiesScoreDataForAllActivityTypes]
                                barColors:@[kDEEP_BLUE_COLOR,
                                            kDARK_RED_COLOR,
                                            kTEIL_COLOR,
                                            kDARK_BLUE_COLOR]
                                 maxValue:[[LOScore sharedManager] movementQuantitiesMaxValue]];

        
        [self setupThisWeekChartWithScore:[[LOScore sharedManager] thisWeekQuantitiesScoreDataForAllActivityTypes]
                                barColors:@[kDEEP_BLUE_COLOR,
                                            kDARK_RED_COLOR,
                                            kTEIL_COLOR,
                                            kDARK_BLUE_COLOR]
                                 maxValue:[[LOScore sharedManager] movementQuantitiesMaxValue]];

    }
    
    if (self.isLastWeek) {
        [self setupLastWeekChartWithScore:[[LOScore sharedManager] lastLastWeekQuantitiesScoreDataForAllActivityTypes] // would really be last last week :)
                                barColors:@[kDEEP_BLUE_COLOR,
                                            kDARK_RED_COLOR,
                                            kTEIL_COLOR,
                                            kDARK_BLUE_COLOR]
                                 maxValue:[[LOScore sharedManager] movementQuantitiesMaxValue]];

        
        [self setupThisWeekChartWithScore:[[LOScore sharedManager] lastWeekQuantitiesScoreDataForAllActivityTypes]
                                barColors:@[kDEEP_BLUE_COLOR,
                                            kDARK_RED_COLOR,
                                            kTEIL_COLOR,
                                            kDARK_BLUE_COLOR]
                                 maxValue:[[LOScore sharedManager] movementQuantitiesMaxValue]];

    }
}

- (void)configureCellForLifestyleWithRightLabel:(NSString *)rightlabel leftLabel:(NSString *)leftLabel
{
    
    [self.rightLabel setText:rightlabel];
    [self.leftLabel setText:leftLabel];
    
    if (![self.contentView.subviews containsObject:self.blurView]) {
        [self.blurView setFrame:self.contentView.frame];
        //[self addBlurToView:self.blurView];
        
        [self.contentView addSubview:self.blurView];
        [self.contentView sendSubviewToBack:self.blurView];
    }
    
    
    if (self.isThisWeek) {
        [self setupLastWeekChartWithScore:@[]
                                barColors:@[]
                                 maxValue:[[LOScore sharedManager] lifestyleQuantitiesMaxValue]];

        
        [self setupThisWeekChartWithScore:@[] // would really be last last week :)
                                barColors:@[]
                                 maxValue:[[LOScore sharedManager] lifestyleQuantitiesMaxValue]];
    }
    
    if (self.isLastWeek) {
        [self setupLastWeekChartWithScore:@[]
                                barColors:@[]
                                 maxValue:[[LOScore sharedManager] lifestyleQuantitiesMaxValue]];

        
        [self setupThisWeekChartWithScore:@[]
                                barColors:@[]
                                 maxValue:[[LOScore sharedManager] lifestyleQuantitiesMaxValue]];

    }
}



- (void)setupLastWeekChartWithScore:(NSArray *)score barColors:(NSArray *)barColors maxValue:(CGFloat )maxValue
{
    // Line chart, the code way
    TEABarChart *lastWeekBarChart = [[TEABarChart alloc] initWithFrame:CGRectMake(0, 0, 100, 128)];
    
    if (maxValue > 128) {
        maxValue = 128;
    }
    
    lastWeekBarChart.data = score;
    lastWeekBarChart.max = maxValue;
    lastWeekBarChart.barColors = barColors;
    lastWeekBarChart.backgroundColor = kCHART_BACKROUND_COLOR;
    self.lastWeekChartView.backgroundColor = [UIColor whiteColor];
    [self.lastWeekChartView addSubview:lastWeekBarChart];
}

- (void)setupThisWeekChartWithScore:(NSArray *)score barColors:(NSArray *)barColors maxValue:(CGFloat )maxValue
{
    // Line chart, the code way
    TEABarChart *thisWeekBarChart = [[TEABarChart alloc] initWithFrame:CGRectMake(0, 0, 100, 128)];
    
    if (maxValue > 128) {
        maxValue = 128;
    }
    
    thisWeekBarChart.data = score;
    thisWeekBarChart.max = maxValue;
    thisWeekBarChart.barColors = barColors;
    thisWeekBarChart.backgroundColor = kCHART_BACKROUND_COLOR;
    self.thisWeekChartView.backgroundColor = [UIColor whiteColor];
    [self.thisWeekChartView addSubview:thisWeekBarChart];
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
