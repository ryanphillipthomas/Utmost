//
//  LOWeekDetailTableViewCell.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 3/26/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOWeekDetailTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "LOScore.h"

@implementation LOWeekDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureCellForNutritionWithLabel:(NSString *)label
{
    [self.categoryLabel setText:label];
    [self.categoryLabel setTextColor:[UIColor whiteColor]];
    
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
    [self.categoryLabel setText:label];
    [self.categoryLabel setTextColor:[UIColor whiteColor]];
    
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
    [self.categoryLabel setText:label];
    [self.categoryLabel setTextColor:[UIColor whiteColor]];
    
    if (self.isThisWeek) {
        [self setupChartWithScore:[[LOScore sharedManager] thisWeekHealthAndEnvironmentCurrentScoreDataWithFoodItems:NO withActivityItems:NO]
                        barColors:@[kDEEP_BLUE_COLOR,
                                    kGREEN_COLOR]
                         maxValue:0.0f];

    }
    
    if (self.isLastWeek) {
        [self setupChartWithScore:[[LOScore sharedManager] lastWeekHealthAndEnvironmentCurrentScoreDataWithFoodItems:NO withActivityItems:NO]
                        barColors:@[kDEEP_BLUE_COLOR,
                                    kGREEN_COLOR]
                         maxValue:0.0f];
    }
}


- (void)setupChartWithScore:(NSArray *)score barColors:(NSArray *)barColors maxValue:(CGFloat )maxValue
{
    // Line chart, the code way
    TEABarChart *thisWeekBarChart = [[TEABarChart alloc] initWithFrame:CGRectMake(0, 0, 40, 128)];
    thisWeekBarChart.data = score;
    thisWeekBarChart.max = maxValue;
    thisWeekBarChart.barColors = barColors;
    thisWeekBarChart.backgroundColor = kCHART_BACKROUND_COLOR_WITH_ALPHA;
    self.thisWeekChartView.backgroundColor = [UIColor clearColor];
    [self.thisWeekChartView addSubview:thisWeekBarChart];
}

- (void)configureCellWithImage:(UIImage *)image forDescription:(NSString *)description
{
    [self.categoryImage setImage:image];
    [self.categoryLabel setText:description];
    [self.categoryLabel setTextColor:[UIColor whiteColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    self.categoryImage.layer.cornerRadius = 8;
    self.categoryImage.layer.masksToBounds = YES;
}


@end
