//
//  LOWeekDetailViewController.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 3/26/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOWeekDetailViewController.h"
#import "LOWeekDetailTableViewCell.h"
#import "LOCategoryNutritionDetailViewController.h"
#import "LOCategoryMovementDetailViewController.h"
#import "LOCategoryLifestyleDetailViewController.h"

@interface LOWeekDetailViewController ()

@end

@implementation LOWeekDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [self closeButtonItem];
    
    self.tableView.separatorColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 238;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    LOWeekDetailTableViewCell *categoryCell;
    
    if (indexPath.row == 0) {
        categoryCell = (LOWeekDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MovementCell" forIndexPath:indexPath];
        [categoryCell setIsLastWeek:self.isLastWeek];
        [categoryCell setIsThisWeek:self.isThisWeek];

        [categoryCell configureCellForMovementWithLabel:@"Movement"];
        categoryCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = categoryCell;
    } else if (indexPath.row == 1) {
        categoryCell = (LOWeekDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"NutritionCell" forIndexPath:indexPath];
        [categoryCell setIsLastWeek:self.isLastWeek];
        [categoryCell setIsThisWeek:self.isThisWeek];
        
        [categoryCell configureCellForNutritionWithLabel:@"Nutrition"];
        categoryCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = categoryCell;
    } else if (indexPath.row == 2) {
        categoryCell = (LOWeekDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LifestyleCell" forIndexPath:indexPath];
        [categoryCell setIsLastWeek:self.isLastWeek];
        [categoryCell setIsThisWeek:self.isThisWeek];
        
        [categoryCell configureCellForLifestyleWithLabel:@"Lifestyle"];
        categoryCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = categoryCell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"Movement Detail" sender:nil];
    } else if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"Nutrition Detail" sender:nil];
    } else if (indexPath.row == 2) {
        [self performSegueWithIdentifier:@"Lifestyle Detail" sender:nil];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    UINavigationController *navController = [segue destinationViewController];
    if ([segue.identifier isEqualToString:@"Movement Detail"]) {
        
        LOCategoryMovementDetailViewController *detailView = [[navController viewControllers] objectAtIndex:0];
        [detailView setImageName:@"movement"];
        [detailView setIsThisWeek:self.isThisWeek];
        [detailView setIsLastWeek:self.isLastWeek];

    } else if ([segue.identifier isEqualToString:@"Nutrition Detail"]) {
        
        LOCategoryNutritionDetailViewController *detailView = [[navController viewControllers] objectAtIndex:0];
        [detailView setImageName:@"nutrition"];
        [detailView setIsThisWeek:self.isThisWeek];
        [detailView setIsLastWeek:self.isLastWeek];

    } else if ([segue.identifier isEqualToString:@"Lifestyle Detail"]) {
        
        LOCategoryLifestyleDetailViewController *detailView = [[navController viewControllers] objectAtIndex:0];
        [detailView setImageName:@"lifestyle"];
        [detailView setIsThisWeek:self.isThisWeek];
        [detailView setIsLastWeek:self.isLastWeek];
    }
}




@end
