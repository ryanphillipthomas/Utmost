//
//  LOCategoryHealthQuanitiesChartTableViewCell.h
//  Utmost
//
//  Created by Ryan Thomas on 8/25/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEAChart.h"

@interface LOCategoryHealthQuanitiesChartTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *leftLabel;
@property (nonatomic, weak) IBOutlet UILabel *rightLabel;

@property (weak, nonatomic) IBOutlet UIView  *lastWeekChartView;
@property (weak, nonatomic) IBOutlet UIView  *thisWeekChartView;
@property (strong, nonatomic) UIView  *blurView;


@property (nonatomic) BOOL isLastWeek;
@property (nonatomic) BOOL isThisWeek;

- (void)configureCellForNutritionWithRightLabel:(NSString *)rightlabel leftLabel:(NSString *)leftLabel;
- (void)configureCellForMovementWithRightLabel:(NSString *)rightlabel leftLabel:(NSString *)leftLabel;
- (void)configureCellForLifestyleWithRightLabel:(NSString *)rightlabel leftLabel:(NSString *)leftLabel;

@end
