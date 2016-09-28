//
//  LOCategoryNutritionDetailViewController.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 3/26/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOCategoryNutritionDetailViewController.h"
#import "UIScrollView+APParallaxHeader.h"
#import "LOCategoryWeekScoreChartHeaderTableViewCell.h"
#import "LOCategoryHealthQuanitiesChartTableViewCell.h"
#import "LOCategorySourcingChartTableViewCell.h"
#import "LOCategorySummaryDetailTableViewCell.h"
#import "LOScore.h"

@interface LOCategoryNutritionDetailViewController () <APParallaxViewDelegate>

@end

@implementation LOCategoryNutritionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [self closeButtonItem];
    
    [self setupParalaxView];
    
    self.tableView.estimatedRowHeight = 162.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
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

- (void)setupParalaxView
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageName]];
    [imageView setFrame:CGRectMake(0, 0, 320, screenHeight - 250)];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.tableView addParallaxWithView:imageView andHeight:screenHeight - 250];
    self.tableView.parallaxView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1) {
        return 186;
    }
    
    if (indexPath.row == 4) {
        return 298;
    }
    
    return UITableViewAutomaticDimension;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    LOCategoryWeekScoreChartHeaderTableViewCell *weekScoreChartHeader;
    LOCategorySourcingChartTableViewCell *sourcingChart;
    LOCategoryHealthQuanitiesChartTableViewCell *quanitiesChart;
    LOCategorySummaryDetailTableViewCell *categorySummaryCell;

    if (indexPath.row == 0) {
        weekScoreChartHeader = (LOCategoryWeekScoreChartHeaderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"weekScoreChart" forIndexPath:indexPath];
        [weekScoreChartHeader setIsThisWeek:self.isThisWeek];
        [weekScoreChartHeader setIsLastWeek:self.isLastWeek];
        weekScoreChartHeader.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.isThisWeek) {
            [weekScoreChartHeader configureCellForNutritionWithLabel:@"This Week"];
        }
        
        if (self.isLastWeek) {
            [weekScoreChartHeader configureCellForNutritionWithLabel:@"Last Week"];
        }
        
        cell = weekScoreChartHeader;

    } else if (indexPath.row == 1) {
        quanitiesChart = (LOCategoryHealthQuanitiesChartTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"quanitiesChart" forIndexPath:indexPath];
        [quanitiesChart setIsThisWeek:self.isThisWeek];
        [quanitiesChart setIsLastWeek:self.isLastWeek];
        quanitiesChart.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.isThisWeek) {
            [quanitiesChart configureCellForNutritionWithRightLabel:@"This Week" leftLabel:@"Last Week"];
        }
        
        if (self.isLastWeek) {
            [quanitiesChart configureCellForNutritionWithRightLabel:@"Last Week" leftLabel:@"The Week Before Last Week"];
        }
        
        cell = quanitiesChart;
        
    } else if (indexPath.row == 2) {
        categorySummaryCell = (LOCategorySummaryDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"WhatWeLikeHealthCell" forIndexPath:indexPath];
        categorySummaryCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [categorySummaryCell setIsThisWeek:self.isThisWeek];
        [categorySummaryCell setIsLastWeek:self.isLastWeek];
        [categorySummaryCell setIsHealthWhatWeLike:YES];
        
        [categorySummaryCell configureCellForNutritionWithLabel:@"What We Like"];
        
        cell = categorySummaryCell;
        
    } else if (indexPath.row == 3) {
        categorySummaryCell = (LOCategorySummaryDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"HowToImproveHealthCell" forIndexPath:indexPath];
        categorySummaryCell.selectionStyle = UITableViewCellSelectionStyleNone;

        [categorySummaryCell setIsThisWeek:self.isThisWeek];
        [categorySummaryCell setIsLastWeek:self.isLastWeek];
        [categorySummaryCell setIsHealthHowToImprove:YES];

        [categorySummaryCell configureCellForNutritionWithLabel:@"How To Improve"];
        
        cell = categorySummaryCell;

    } else if (indexPath.row == 4) {
        sourcingChart = (LOCategorySourcingChartTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"weekSourcingChart" forIndexPath:indexPath];
        sourcingChart.selectionStyle = UITableViewCellSelectionStyleNone;
        [sourcingChart setIsThisWeek:self.isThisWeek];
        [sourcingChart setIsLastWeek:self.isLastWeek];

        [sourcingChart configureCellForNutritionWithLabel:@"Nutrition Sourcing"];
        
        cell = sourcingChart;
        
    } else if (indexPath.row == 5) {
        categorySummaryCell = (LOCategorySummaryDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"WhatWeLikeEnvironmentCell" forIndexPath:indexPath];
        categorySummaryCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [categorySummaryCell setIsThisWeek:self.isThisWeek];
        [categorySummaryCell setIsLastWeek:self.isLastWeek];
        [categorySummaryCell setIsEnvironmenthWhatWeLike:YES];

        [categorySummaryCell configureCellForNutritionWithLabel:@"What We Like"];
        
        cell = categorySummaryCell;
        
    } else if (indexPath.row == 6) {
        categorySummaryCell = (LOCategorySummaryDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"HowToImproveEnvironmentCell" forIndexPath:indexPath];
        categorySummaryCell.selectionStyle = UITableViewCellSelectionStyleNone;

        [categorySummaryCell setIsThisWeek:self.isThisWeek];
        [categorySummaryCell setIsLastWeek:self.isLastWeek];
        [categorySummaryCell setIsEnvironmenthHowToImprove:YES];

        [categorySummaryCell configureCellForNutritionWithLabel:@"How To Improve"];
        
        cell = categorySummaryCell;
    }
    
    return cell;
}


- (UIBarButtonItem *)closeButtonItem
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                         target:self
                                                         action:@selector(closeView:)];
}

- (void)closeView:(id)selector
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - APParallaxViewDelegate

- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview before its frame changes
//    NSLog(@"parallaxView:willChangeFrame: %@", NSStringFromCGRect(frame));
}

- (void)parallaxView:(APParallaxView *)view didChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview after its frame changed
//    NSLog(@"parallaxView:didChangeFrame: %@", NSStringFromCGRect(frame));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
