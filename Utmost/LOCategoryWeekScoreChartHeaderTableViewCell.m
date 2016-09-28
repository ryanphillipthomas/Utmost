//
//  LOCategoryWeekScoreChartHeaderTableViewCell.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 3/26/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOScore.h"
#import "LOCategoryWeekScoreChartHeaderTableViewCell.h"

@implementation LOCategoryWeekScoreChartHeaderTableViewCell


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
        [self setupChartWithScore:[[LOScore sharedManager] thisWeekHealthAndEnvironmentCurrentScoreDataWithFoodItems:YES withActivityItems:NO]
                        barColors:@[kDEEP_BLUE_COLOR,
                                    kGREEN_COLOR]
                         maxValue:[[LOScore sharedManager] nutritionHealthAndEnvironmentThisWeekMaxValue]];

    }
    
    if (self.isLastWeek) {
        [self setupChartWithScore:[[LOScore sharedManager] lastWeekHealthAndEnvironmentCurrentScoreDataWithFoodItems:YES withActivityItems:NO]
                        barColors:@[kDEEP_BLUE_COLOR,
                                    kGREEN_COLOR]
                         maxValue:[[LOScore sharedManager] nutritionHealthAndEnvironmentLastWeekMaxValue]];

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
        [self setupChartWithScore:[[LOScore sharedManager] thisWeekHealthAndEnvironmentCurrentScoreDataWithFoodItems:NO withActivityItems:YES]
                        barColors:@[kDEEP_BLUE_COLOR,
                                    kGREEN_COLOR]
                         maxValue:[[LOScore sharedManager] movementHealthAndEnvironmentThisWeekMaxValue]];

    }
    
    if (self.isLastWeek) {
        [self setupChartWithScore:[[LOScore sharedManager] lastWeekHealthAndEnvironmentCurrentScoreDataWithFoodItems:NO withActivityItems:YES]
                        barColors:@[kDEEP_BLUE_COLOR,
                                    kGREEN_COLOR]
                         maxValue:[[LOScore sharedManager] movementHealthAndEnvironmentLastWeekMaxValue]];

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
    
    if (self.isThisWeek) {
        [self setupChartWithScore:[[LOScore sharedManager] thisWeekHealthAndEnvironmentCurrentScoreDataWithFoodItems:NO withActivityItems:NO]
                        barColors:@[kDEEP_BLUE_COLOR,
                                    kGREEN_COLOR]
                         maxValue:[[LOScore sharedManager] lifestyleHealthAndEnvironmentThisWeekMaxValue]];

    }
    
    if (self.isLastWeek) {
        [self setupChartWithScore:[[LOScore sharedManager] lastWeekHealthAndEnvironmentCurrentScoreDataWithFoodItems:NO withActivityItems:NO]
                        barColors:@[kDEEP_BLUE_COLOR,
                                    kGREEN_COLOR]
                         maxValue:[[LOScore sharedManager] lifestyleHealthAndEnvironmentLastWeekMaxValue]];
    }
}


- (void)setupChartWithScore:(NSArray *)score barColors:(NSArray *)barColors maxValue:(CGFloat )maxValue
{
    // Line chart, the code way
    TEABarChart *thisWeekBarChart = [[TEABarChart alloc] initWithFrame:CGRectMake(0, 0, 50, 128)];
    thisWeekBarChart.data = score;
    
  //  if (maxValue > 128) {
  //      maxValue = 128;
  //  }
    
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
