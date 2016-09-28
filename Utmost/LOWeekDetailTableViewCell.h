//
//  LOWeekDetailTableViewCell.h
//  Loop
//
//  Created by Ryan Phillip Thomas on 3/26/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEAChart.h"

@interface LOWeekDetailTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *categoryImage;
@property (nonatomic, weak) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UIView  *thisWeekChartView;

@property (nonatomic) BOOL isLastWeek;
@property (nonatomic) BOOL isThisWeek;

- (void)configureCellForNutritionWithLabel:(NSString *)label;
- (void)configureCellForMovementWithLabel:(NSString *)label;
- (void)configureCellForLifestyleWithLabel:(NSString *)label;


@end
