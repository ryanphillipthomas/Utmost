//
//  LOHomeTableViewCell.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 11/1/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import "LOHomeChartTableViewCell.h"
#import "LOScore.h"

@implementation LOHomeChartTableViewCell

- (void)updateChartsWithData:(NSArray *)data
{
    
//    if (maxValue > 128) {
//        maxValue = 128;
//    }
    
    // Line chart, the code way
    TEABarChart *lastWeekBarChart = [[TEABarChart alloc] initWithFrame:CGRectMake(0, 0, 50, 128)];
    lastWeekBarChart.max = [[LOScore sharedManager] homeLastWeekVSThisWeekHealthAndEnvironmentMaxValue_LastWeek];
    lastWeekBarChart.data = [[LOScore sharedManager] lastWeekHealthAndEnvironmentCurrentScoreDataWithFoodItems:YES withActivityItems:YES];
    lastWeekBarChart.barColors = @[kDEEP_BLUE_COLOR, kGREEN_COLOR];
    lastWeekBarChart.backgroundColor = kCHART_BACKROUND_COLOR;
    self.lastWeekChartView.backgroundColor = [UIColor clearColor];
    [self.lastWeekChartView addSubview:lastWeekBarChart];
    
    
    TEABarChart *thisWeekBarChart = [[TEABarChart alloc] initWithFrame:CGRectMake(0, 0, 50, 128)];
    thisWeekBarChart.max = [[LOScore sharedManager] homeLastWeekVSThisWeekHealthAndEnvironmentMaxValue_ThisWeek];
    thisWeekBarChart.data = [[LOScore sharedManager] thisWeekHealthAndEnvironmentCurrentScoreDataWithFoodItems:YES withActivityItems:YES];
    thisWeekBarChart.barColors = @[kDEEP_BLUE_COLOR, kGREEN_COLOR];
    thisWeekBarChart.backgroundColor = kCHART_BACKROUND_COLOR;
    
    self.thisWeekChartView.backgroundColor = [UIColor clearColor];
    [self.thisWeekChartView addSubview:thisWeekBarChart];
    
    self.backroundRoundedView.layer.cornerRadius = 8;
    self.backroundRoundedView.layer.masksToBounds = YES;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellWithData:(NSArray *)data withLabel:(NSString *)label;
{
    [self.chartLabel setText:label];
    [self updateChartsWithData:data];
}

- (IBAction)didSelectLastWeekAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectLastWeek:)]) {
        [self.delegate didSelectLastWeek:sender];
    }
}

- (IBAction)didSelectThisWeekAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectThisWeek:)]) {
        [self.delegate didSelectThisWeek:sender];
    }
}


@end
