//
//  LOHomeTableViewCell.h
//  Loop
//
//  Created by Ryan Phillip Thomas on 11/1/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEAChart.h"

@protocol LOHomeChartTableViewCellDelegate <NSObject>
- (void)didSelectLastWeek:(id)sender;
- (void)didSelectThisWeek:(id)sender;
@end

@interface LOHomeChartTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *chartLabel;
@property (nonatomic, weak) id<LOHomeChartTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *lastWeekChartView;
@property (weak, nonatomic) IBOutlet UIView *thisWeekChartView;

@property (weak, nonatomic) IBOutlet UIButton *lastWeekChartButton;
@property (weak, nonatomic) IBOutlet UIButton *thisWeekChartButton;

@property (weak, nonatomic) IBOutlet UIView *backroundRoundedView;

- (void)configureCellWithData:(NSArray *)data withLabel:(NSString *)label;

@end
