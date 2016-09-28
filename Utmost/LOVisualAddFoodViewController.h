//
//  LOVisualAddFoodViewController.h
//  Loop
//
//  Created by Ryan Phillip Thomas on 4/17/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCGoogleSearch.h"
#import "SCGoogleImage.h"
#import "LORootItem.h"

@interface LOVisualAddFoodViewController : UIViewController

@property (nonatomic, strong) SCGoogleSearch *search;
@property(nonatomic, strong) NSNumber *screenNumber;
@property(nonatomic, strong) NSArray *screenOptions;
@property(nonatomic, strong) NSArray *screenSecondaryOptions;
@property(nonatomic, strong) NSMutableDictionary *screenAwnsers;
@property(nonatomic, strong) NSString *screenQuestion;
@property(nonatomic, strong) NSString *screenMediaURL;

@property(nonatomic, strong) LORootItem *rootItem;

@property(nonatomic, strong) NSString *screenFoodName;
@property(nonatomic, strong) NSString *screenSecondaryTitle;
@property(nonatomic)  bool shouldEnforceSingleSelection;


@property(nonatomic, weak) IBOutlet UILabel *questionLabel;
@property(nonatomic, weak) IBOutlet UILabel *subQuestionLabel;
@property(nonatomic, weak) IBOutlet UIButton *continueButton;
@property(nonatomic, weak) IBOutlet UITextField *dateTextField;
@property(nonatomic, weak) IBOutlet UIImageView *screenImageView;
@property(nonatomic, weak) IBOutlet UIView *dividerView;
@property(nonatomic, weak) IBOutlet UILabel *dividerLabel;



@property(nonatomic, strong) IBOutletCollection (UIButton) NSArray *awnswerButtons;
@property(nonatomic, strong) IBOutletCollection (UIButton) NSArray *awnswerSecondaryButtons;


- (void)setupWithScreenAwnswers:(NSMutableDictionary *)screenAwnswers
                 screenQuestion:(NSString *)screenQuestion
                  screenOptions:(NSArray *)screenOptions
                  screenSecondaryOptions:(NSArray *)screenSecondaryOptions
                   screenNumber:(NSNumber *)screenNumber
                 screenFoodName:(NSString *)screenFoodName
                 screenMediaURL:(NSString *)screenMediaURL
           screenSecondaryTitle:(NSString *)screenSecondaryTitle
                       rootItem:(LORootItem *)rootItem
   shouldEnforceSingleSelection:(bool)shouldEnforceSingleSelection;


@end
