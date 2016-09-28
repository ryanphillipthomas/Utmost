//
//  LOCategorySourcingChartTableViewCell.h
//  Utmost
//
//  Created by Ryan Thomas on 8/25/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEAChart.h"

@interface LOCategorySourcingChartTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *chartLabel;

@property (weak, nonatomic) IBOutlet UIView  *otherChartView;
@property (weak, nonatomic) IBOutlet UIView  *redProteinChartView;
@property (weak, nonatomic) IBOutlet UIView  *whiteProteinChartView;
@property (weak, nonatomic) IBOutlet UIView  *nutsChartView;
@property (weak, nonatomic) IBOutlet UIView  *fruitChartView;
@property (weak, nonatomic) IBOutlet UIView  *vegetableChartView;
@property (weak, nonatomic) IBOutlet UIView  *vegetableproteinChartView;

@property (weak, nonatomic) IBOutlet UIView  *movementOtherChartView;
@property (weak, nonatomic) IBOutlet UIView  *movementStrengthChartView;
@property (weak, nonatomic) IBOutlet UIView  *movementCardioChartView;
@property (weak, nonatomic) IBOutlet UIView  *movementFlexibilityChartView;

@property (nonatomic) BOOL isLastWeek;
@property (nonatomic) BOOL isThisWeek;

@property (strong, nonatomic) UIView  *blurView;

- (void)configureCellForNutritionWithLabel:(NSString *)label;
- (void)configureCellForMovementWithLabel:(NSString *)label;
- (void)configureCellForLifestyleWithLabel:(NSString *)label;

@end
