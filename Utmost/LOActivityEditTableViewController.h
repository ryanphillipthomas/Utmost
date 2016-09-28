//
//  LOFoodEditTableViewController.h
//  Loop
//
//  Created by Ryan Phillip Thomas on 12/30/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LOActivity.h"
#import "LORootItem.h"
#import "LOActivityPrototype.h"

@interface LOActivityEditTableViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *activityName;
@property (weak, nonatomic) IBOutlet UILabel *activityTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rootItemLabel;
@property(nonatomic, strong) NSString *mediaURL;

@property (weak, nonatomic) IBOutlet UITextField *activityCategory;
@property (weak, nonatomic) IBOutlet UITextField *activityLocation;

@property (strong, nonatomic) UIPickerView *activityTypePickerView;
@property (strong, nonatomic) UIPickerView *activityCategoryPickerView;
@property (strong, nonatomic) UIPickerView *activityLocationPickerView;

@property (weak, nonatomic) IBOutlet UIImageView *activityMediaItem;

@property (weak, nonatomic) IBOutlet UIButton *createActivityButton;

@property (strong, nonatomic) LORootItem *rootItem;
@property (strong, nonatomic) LOActivity *activityItem;
@property (strong, nonatomic) LOActivityPrototype *activityItemPrototype;

@property (nonatomic) BOOL isModifyAndReUse;

@end
