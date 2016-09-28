//
//  LOCategorySummaryDetailTableViewCell.h
//  Loop
//
//  Created by Ryan Phillip Thomas on 3/26/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LOScore.h"

@interface LOCategorySummaryDetailTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *label;
@property (strong, nonatomic) UIView  *blurView;

@property (nonatomic) BOOL isLastWeek;
@property (nonatomic) BOOL isThisWeek;

@property (nonatomic) BOOL isHealthWhatWeLike;
@property (nonatomic) BOOL isHealthHowToImprove;

@property (nonatomic) BOOL isEnvironmenthWhatWeLike;
@property (nonatomic) BOOL isEnvironmenthHowToImprove;

- (void)configureCellForNutritionWithLabel:(NSString *)label;
- (void)configureCellForMovementWithLabel:(NSString *)label;
- (void)configureCellForLifestyleWithLabel:(NSString *)label;

@end
