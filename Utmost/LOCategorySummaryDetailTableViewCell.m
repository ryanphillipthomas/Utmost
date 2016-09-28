//
//  LOCategorySummaryDetailTableViewCell.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 3/26/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOCategorySummaryDetailTableViewCell.h"
#import "LOScore.h"

@implementation LOCategorySummaryDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.blurView = [[UIView alloc] initWithFrame:self.contentView.frame];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellForNutritionWithLabel:(NSString *)label;
{
    [self.label setText:label];
    
    if (![self.contentView.subviews containsObject:self.blurView]) {
        [self.blurView setFrame:self.contentView.frame];
        //[self addBlurToView:self.blurView];
        
        [self.contentView addSubview:self.blurView];
        [self.contentView sendSubviewToBack:self.blurView];
    }
    
    if (self.isHealthWhatWeLike) {
        if (self.isThisWeek) {
            [self.label setText:[[LOScore sharedManager] healthWhatWeLikeNutritionDataStringThisWeek]];
        }
        
        if (self.isLastWeek) {
            [self.label setText:[[LOScore sharedManager] healthWhatWeLikeNutritionDataStringLastWeek]];
        }
    }
    
    if (self.isHealthHowToImprove) {
        if (self.isThisWeek) {
            [self.label setText:[[LOScore sharedManager] healthHowToImproveNutritionDataStringThisWeek]];
        }
        
        if (self.isLastWeek) {
            [self.label setText:[[LOScore sharedManager] healthHowToImproveNutritionDataStringLastWeek]];
        }
    }
    
    if (self.isEnvironmenthWhatWeLike) {
        if (self.isThisWeek) {
            [self.label setText:[[LOScore sharedManager] environmentWhatWeLikeNutritionThisWeekDataString]];
        }
        
        if (self.isLastWeek) {
            [self.label setText:[[LOScore sharedManager] environmentWhatWeLikeNutritionLastWeekDataString]];
        }
    }
    
    if (self.isEnvironmenthHowToImprove) {
        if (self.isThisWeek) {
            [self.label setText:[[LOScore sharedManager] environmentHowToImproveNutritionThisWeekDataString]];
        }
        
        if (self.isLastWeek) {
            [self.label setText:[[LOScore sharedManager] environmentHowToImproveNutritionLastWeekDataString]];
        }
    }
}

- (void)configureCellForMovementWithLabel:(NSString *)label;
{
    
    [self.label setText:label];

    if (![self.contentView.subviews containsObject:self.blurView]) {
        [self.blurView setFrame:self.contentView.frame];
        //[self addBlurToView:self.blurView];
        
        [self.contentView addSubview:self.blurView];
        [self.contentView sendSubviewToBack:self.blurView];
    }
    
    if (self.isHealthWhatWeLike) {
        if (self.isThisWeek) {
            [self.label setText:[[LOScore sharedManager] healthWhatWeLikeMovementDataStringThisWeek]];
        }
        
        if (self.isLastWeek) {
            [self.label setText:[[LOScore sharedManager] healthWhatWeLikeMovementDataStringLastWeek]];
        }
    }
    
    if (self.isHealthHowToImprove) {
        if (self.isThisWeek) {
            [self.label setText:[[LOScore sharedManager] healthHowToImproveMovementDataStringThisWeek]];
        }
        
        if (self.isLastWeek) {
            [self.label setText:[[LOScore sharedManager] healthHowToImproveMovementDataStringLastWeek]];
        }
    }
    
    if (self.isEnvironmenthWhatWeLike) {
        if (self.isThisWeek) {
            [self.label setText:[[LOScore sharedManager] environmentWhatWeLikeMovementThisWeekDataString]];
        }
        
        if (self.isLastWeek) {
            [self.label setText:[[LOScore sharedManager] environmentWhatWeLikeMovementLastWeekDataString]];
        }
    }
    
    if (self.isEnvironmenthHowToImprove) {
        if (self.isThisWeek) {
            [self.label setText:[[LOScore sharedManager] environmentHowToImproveMovementThisWeekDataString]];
        }
        
        if (self.isLastWeek) {
            [self.label setText:[[LOScore sharedManager] environmentHowToImproveMovementLastWeekDataString]];
        }
    }
}

- (void)configureCellForLifestyleWithLabel:(NSString *)label;
{
    [self.label setText:label];

    if (![self.contentView.subviews containsObject:self.blurView]) {
        [self.blurView setFrame:self.contentView.frame];
        //[self addBlurToView:self.blurView];
        
        [self.contentView addSubview:self.blurView];
        [self.contentView sendSubviewToBack:self.blurView];
    }
    
    [self.label setText:@""];
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
