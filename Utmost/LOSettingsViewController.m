//
//  LOSettingsViewController.m
//  Utmost
//
//  Created by Ryan Thomas on 8/9/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOSettingsViewController.h"
#import "LOSettingsHeaderTableViewCell.h"
#import "LOSettingsNewsFeedCell.h"
#import "LOSettingsPinsFeedCell.h"
#import "LOSettingsFoodDeleteCell.h"
#import "LOSettingsPinsDeleteCell.h"
#import "LOSettingsNewsDeleteCell.h"

@interface LOSettingsViewController ()

@end

@implementation LOSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 140;
    }

    return 85;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    LOSettingsHeaderTableViewCell *settingsHeaderCell;
    LOSettingsNewsFeedCell *newsFeedCell;
    LOSettingsPinsFeedCell *pinsFeedCell;
    LOSettingsFoodDeleteCell *foodDeleteCell;
    LOSettingsPinsDeleteCell *pinsDeleteCell;
    LOSettingsNewsDeleteCell *newsDeleteCell;

    if (indexPath.row == 0) {
        settingsHeaderCell = (LOSettingsHeaderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"settingsCell" forIndexPath:indexPath];
        [settingsHeaderCell configureCellWithUserImage:[UIImage imageNamed:@"Ryan"]
                                       firstName:@"Ryan"
                                        lastName:@"Thomas"
                                           email:@"ryanphillipthomas@mac.com"];
        cell = settingsHeaderCell;
    } else  if (indexPath.row == 1) {
        newsFeedCell = (LOSettingsNewsFeedCell *)[tableView dequeueReusableCellWithIdentifier:@"settingsNewsFeed" forIndexPath:indexPath];
        
        cell = newsFeedCell;
    } else if (indexPath.row == 2) {
        pinsFeedCell = (LOSettingsPinsFeedCell *)[tableView dequeueReusableCellWithIdentifier:@"settingsPinsFeed" forIndexPath:indexPath];

         cell = pinsFeedCell;
    } else if (indexPath.row == 3) {
        foodDeleteCell = (LOSettingsFoodDeleteCell *)[tableView dequeueReusableCellWithIdentifier:@"settingsFoodDelete" forIndexPath:indexPath];

        cell = foodDeleteCell;
    } else if (indexPath.row == 4) {
        pinsDeleteCell = (LOSettingsPinsDeleteCell *)[tableView dequeueReusableCellWithIdentifier:@"settingsPinsDelete" forIndexPath:indexPath];

        cell = pinsDeleteCell;
    } else if (indexPath.row == 5) {
        newsDeleteCell = (LOSettingsNewsDeleteCell *)[tableView dequeueReusableCellWithIdentifier:@"settingsNewsDelete" forIndexPath:indexPath];

        cell = newsDeleteCell;
    }
    
    
    return cell;
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
