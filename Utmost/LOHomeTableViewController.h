//
//  LOHomeTableViewController.h
//  Loop
//
//  Created by Ryan Phillip Thomas on 11/1/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LOHomeChartTableViewCell.h"
#import "LOHomeLoopTableViewCell.h"
#import "LONewsContainerCell.h"
#import "LOHomeMapTableViewCell.h"
#import "LONewsArticleData.h"
#import "LOMapLocationData.h"
#import "LOMapDetailViewController.h"

#import "LONewsDetailViewController.h"

@interface LOHomeTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,LOHomeChartTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) LONewsArticleData *newsData;
@property (nonatomic, strong) LOMapLocationData *mapData;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end
