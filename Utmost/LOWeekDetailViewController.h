//
//  LOWeekDetailViewController.h
//  Loop
//
//  Created by Ryan Phillip Thomas on 3/26/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LOWeekDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) BOOL isLastWeek;
@property (nonatomic) BOOL isThisWeek;

@end
