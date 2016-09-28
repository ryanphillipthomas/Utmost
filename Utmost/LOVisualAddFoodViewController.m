//
//  LOVisualAddFoodViewController.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 4/17/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOVisualAddFoodViewController.h"
#import "LOFood.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation LOVisualAddFoodViewController

- (void)setupWithScreenAwnswers:(NSMutableDictionary *)screenAwnswers
                        screenQuestion:(NSString *)screenQuestion
                         screenOptions:(NSArray *)screenOptions
                         screenSecondaryOptions:(NSArray *)screenSecondaryOptions
                          screenNumber:(NSNumber *)screenNumber
                        screenFoodName:(NSString *)screenFoodName
                        screenMediaURL:(NSString *)screenMediaURL
                  screenSecondaryTitle:(NSString *)screenSecondaryTitle
                              rootItem:(LORootItem *)rootItem
                        shouldEnforceSingleSelection:(bool)shouldEnforceSingleSelection

{
        _screenAwnsers = screenAwnswers;
        _screenOptions = screenOptions;
        _screenNumber = screenNumber;
        _screenQuestion = screenQuestion;
        _screenFoodName = screenFoodName;
        _screenMediaURL = screenMediaURL;
        _screenSecondaryOptions = screenSecondaryOptions;
        _screenSecondaryTitle = screenSecondaryTitle;
        _shouldEnforceSingleSelection = shouldEnforceSingleSelection;
        _shouldEnforceSingleSelection = shouldEnforceSingleSelection;
        _rootItem = rootItem;
}

- (void)viewDidLoad
{
    [self setUpView];
    
    self.title = @"Add Food Item";
    self.navigationItem.rightBarButtonItem = [self closeButtonItem];
    
    self.search = [[SCGoogleSearch alloc]initWithKey:KEY2 withCx:CX2];
    
    if ([self.screenNumber isEqualToNumber:@1]) {
        if (!(self.screenMediaURL.length > 0)) {
            [self.search loadPicturesWithName:self.screenFoodName complition:^(NSArray<SCGoogleImage *> *objects, SCGooglePagination *pagination, NSError *failure) {
                if (objects.count > 0) {
                    SCGoogleImage *googleImage = (SCGoogleImage *)[objects firstObject];
                    [self setFoodMediaImageFromGoogleImage:googleImage];
                }
            }];
        }
    }
}

- (void)setUpView
{
    [self hideAllButtons];
    [self setupDefaultQuestion];
    [self setupDefaultScreenNumber];
    [self setupDefaultScreenOptions];
    [self setupDefaultScreenAwnswers];
    [self setDatePicker];
    [self tryToEnableContinueButton];
    
    [self layoutScreenForCurrentPosition];
}

- (void)setDatePicker
{
    UIDatePicker *picker = [[UIDatePicker alloc]init];
    [picker setDate:[NSDate date]];
    [picker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [picker setDatePickerMode:UIDatePickerModeDate];
    [self.dateTextField setInputView:picker];
    [self.dateTextField setInputAccessoryView:[self pickerInputAccessory]];
    [self.dateTextField setPlaceholder:[self stringDateForDate:picker.date]];
}

- (UIView *)pickerInputAccessory
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(dismissPicker:)];
    [toolbar setItems:@[spacer, doneButton]];
    
    return toolbar;
}

- (void)dismissPicker:(id)sender
{
    [self.dateTextField resignFirstResponder];
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.dateTextField.inputView;
    self.dateTextField.text = [self stringDateForDate:picker.date];
}

- (void)setupDefaultScreenNumber
{
    if (!self.screenNumber) {
        self.screenNumber = @1;
    }
}

- (void)setupDefaultQuestion
{
    [self.questionLabel setText:[NSString stringWithFormat:@"%@", self.screenQuestion]];
}

- (void)selectAwnserOption:(NSString *)awnswer selected:(bool)selected
{
    if (selected) {
        NSMutableArray *awnswers = [NSMutableArray new];
        NSArray *currentAwnswers = [self.screenAwnsers valueForKey:[self.screenNumber stringValue]];
        if (currentAwnswers.count > 0) {
            awnswers = [NSMutableArray arrayWithArray:currentAwnswers];
        }
        [awnswers addObject:awnswer];
        
        [self.screenAwnsers setObject:awnswers forKey:[self.screenNumber stringValue]];
    } else {
        //remove it
        NSMutableArray *awnswers = [NSMutableArray new];
        NSArray *currentAwnswers = [self.screenAwnsers valueForKey:[self.screenNumber stringValue]];
        if (currentAwnswers.count > 0) {
            awnswers = [NSMutableArray arrayWithArray:currentAwnswers];
            for (NSString *thisAwnswer in currentAwnswers) {
                if ([thisAwnswer isEqualToString:awnswer]) {
                    [awnswers removeObject:awnswer];
                }
            }
        }
        
        [self.screenAwnsers setObject:awnswers forKey:[self.screenNumber stringValue]];
    }
}

- (void)tryToEnableContinueButton
{
    if (![self validateCurrentScreenAwnsers]) {
        [self.continueButton setEnabled:NO];
    } else {
        [self.continueButton setEnabled:YES];
    }
}

- (void)hideAllButtons
{
    for (UIButton *button in self.awnswerButtons) {
        [button setHidden:YES];
    }
    
    for (UIButton *button in self.awnswerSecondaryButtons) {
        [button setHidden:YES];
    }
}

- (void)layoutScreenForCurrentPosition
{
    for (int i = 0; i < self.screenOptions.count; ++i) {
        UIButton *button = [self.awnswerButtons objectAtIndex:i];
        if ([self.screenNumber isEqualToNumber:@3]) {
            [button setHidden:YES];
        } else {
            [button setHidden:NO];
            [button setTitle:[self.screenOptions objectAtIndex:i] forState:UIControlStateNormal];
        }
    }
    
    for (UIButton *button in self.awnswerButtons) {
        if ([button.titleLabel.text isEqualToString:@"Button"]) {
            [button setHidden:YES];
        }
    }
    
    int b = 0;
    
    if ([self.screenNumber isEqualToNumber:@2]) {
        for (UIButton *button in self.awnswerSecondaryButtons) {
            if (self.screenSecondaryOptions.count > 0) {
                [button setHidden:NO];
                [button setTitle:[self.screenSecondaryOptions objectAtIndex:b] forState:UIControlStateNormal];
                ++b;
            }
        }
    }
    
    if ([self.screenNumber isEqualToNumber:@1]) {
        self.shouldEnforceSingleSelection = YES; //only applicable on first screen
        [self.dateTextField setHidden:YES];
        [self.subQuestionLabel setHidden:YES];
        [self.dividerView setHidden:YES];
        [self.dividerLabel setHidden:YES];
        [self.continueButton setTitle:@"Continue" forState:UIControlStateNormal];
    }
    
    if ([self.screenNumber isEqualToNumber:@2]) {
        [self.dateTextField setHidden:YES];
        [self.subQuestionLabel setHidden:NO];
        
        [self.dividerLabel setHidden:YES];
        [self.dividerView setHidden:YES];

        if (self.screenSecondaryOptions.count > 0) {
            [self.dividerView setHidden:NO];
            [self.dividerLabel setHidden:NO];
            [self.dividerLabel setText:self.screenSecondaryTitle];
        }

        [self.continueButton setTitle:@"Continue" forState:UIControlStateNormal];
    }
    
    if ([self.screenNumber isEqualToNumber:@3]) {
        [self.dateTextField setHidden:NO];
        [self.subQuestionLabel setHidden:YES];
        [self.dividerView setHidden:YES];
        [self.dividerLabel setHidden:YES];

        [self.continueButton setTitle:[NSString stringWithFormat:@"Save %@", self.screenFoodName] forState:UIControlStateNormal];
    }
}

- (void)setupDefaultScreenAwnswers
{
    if (!self.screenAwnsers) {
        self.screenAwnsers = [NSMutableDictionary new];
    }
}

- (void)setupDefaultScreenOptions
{
    if (!self.screenOptions) {
        self.screenOptions = @[@"home cooked",
                               @"delivery",
                               @"from a restaurant"];
    }
    
    if (!self.screenSecondaryOptions) {
        self.screenSecondaryOptions = @[];
    }
    
    if (!self.screenSecondaryTitle) {
        self.screenSecondaryTitle = @"";
    }
}

- (IBAction)continueTapped:(id)sender
{
    //NSLog(@"Tapped");
    if ([self.screenNumber isEqualToNumber:@1]) {
        [self showScreenTwo];
    } else if ([self.screenNumber isEqualToNumber:@2]) {
        [self showScreenThree];
    } else if ([self.screenNumber isEqualToNumber:@3]) {
        [self saveAndCloseView];
    }
}

- (IBAction)selectButton:(id)sender
{
    UIButton* button = (UIButton*)sender;
    button.selected = !button.selected;
    
    if (self.shouldEnforceSingleSelection) {
        for (UIButton *arrayButton in self.awnswerButtons) {
            if (![arrayButton.titleLabel.text isEqualToString:button.titleLabel.text]) {
                [arrayButton setSelected:NO];
                [self selectAwnserOption:arrayButton.titleLabel.text selected:NO];
            }
        }
    }
    // update title...
    [self selectAwnserOption:button.titleLabel.text selected:button.selected];
    
    [self tryToEnableContinueButton];
}

- (bool)validateCurrentScreenAwnsers
{
    if (self.screenNumber.intValue == 1) {
        if ([[self.screenAwnsers objectForKey:[self.screenNumber stringValue]] count] < 1) {
            return NO;
        }
    }
    
    return YES;
}

- (UIBarButtonItem *)closeButtonItem
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                         target:self
                                                         action:@selector(closeView:)];
}

- (void)displayUnsavedChangesAlert
{
    UIAlertController *view = [UIAlertController
                               alertControllerWithTitle:@"Warning!"
                               message:@"Changes you have made will not be saved. Press OK to discard changes or Cancel to continue editing."
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction
                           actionWithTitle:@"Cancel"
                           style:UIAlertActionStyleCancel
                           handler:^(UIAlertAction * action)
                           {
                               [view dismissViewControllerAnimated:YES completion:nil];
                               
                           }];
    
    UIAlertAction *ok = [UIAlertAction
                           actionWithTitle:@"Ok"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
                           {
                               [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                               
                           }];
    
    [view addAction:cancel];
    [view addAction:ok];
    
    [self presentViewController:view animated:YES completion:nil];
}

- (void)closeView:(id)selector
{
    [self displayUnsavedChangesAlert];
}

- (void)showScreenTwo
{
    bool shouldShowResturantScreen = NO;
    NSString *screenQuestion;
    NSArray *screenOptions;
    NSArray *screenSecondaryOptions;
    NSString *screenSecondaryTitle;
    NSInteger screenNumber = [self.screenNumber integerValue];
    
    NSArray *screenAwnswersForFirstScreen = [self.screenAwnsers valueForKey:@"1"];
    for (NSString *awnswer in screenAwnswersForFirstScreen) {
        if ([awnswer isEqualToString:@"from a restaurant"] || [awnswer isEqualToString:@"delivery"]) {
            shouldShowResturantScreen = YES;
        }
    }
    
    if (shouldShowResturantScreen) {
        screenQuestion = @"The restaurant was";
        screenOptions = @[@"farm to table",
                          @"I dont know",
                          @"a chain",
                          @"locally owned"];
        
        screenSecondaryTitle = @"and my meal was";
        
        screenSecondaryOptions = @[@"organic",
                                   @"locally sourced"];
    } else {
        screenQuestion = [NSString stringWithFormat:@"The %@ was from a", self.screenFoodName];
        screenOptions = @[@"supermarket",
                          @"farmers market",
                          @"csa",
                          @"vendor"];
        
        screenSecondaryTitle = @"and was";
        
        screenSecondaryOptions = @[@"organic",
                                   @"locally sourced"];
    }
    
    //display the second screen
    LOVisualAddFoodViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"visualAddView"];
    
    [newView setupWithScreenAwnswers:self.screenAwnsers
                  screenQuestion:screenQuestion
                   screenOptions:screenOptions
                    screenSecondaryOptions:screenSecondaryOptions
                    screenNumber:[NSNumber numberWithInteger:++screenNumber]
                  screenFoodName:_screenFoodName
                      screenMediaURL:_screenMediaURL
                screenSecondaryTitle:screenSecondaryTitle
                            rootItem:_rootItem
                    shouldEnforceSingleSelection:NO];
    
    [self.navigationController pushViewController:newView animated:YES];
}

- (void)showScreenThree
{
    NSString *screenQuestion;
    NSArray *screenOptions;
    NSArray *screenSecondaryOptions;
    NSString *screenSecondaryTitle;

    NSInteger screenNumber = [self.screenNumber integerValue];
    
    screenQuestion = [NSString stringWithFormat:@"You ate the %@", self.screenFoodName];
    
    //display the second screen
    LOVisualAddFoodViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"visualAddView"];
    
    [newView setupWithScreenAwnswers:self.screenAwnsers
                      screenQuestion:screenQuestion
                       screenOptions:screenOptions
                       screenSecondaryOptions:screenSecondaryOptions
                        screenNumber:[NSNumber numberWithInteger:++screenNumber]
                      screenFoodName:_screenFoodName
                      screenMediaURL:_screenMediaURL
                screenSecondaryTitle:screenSecondaryTitle
                            rootItem:_rootItem
                      shouldEnforceSingleSelection:NO];

    
    [self.navigationController pushViewController:newView animated:YES];
}

- (NSString *)stringDateForDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    
    return [dateFormatter stringFromDate:date];
}


- (void)saveAndCloseView
{
    UIDatePicker *picker = (UIDatePicker*)self.dateTextField.inputView;
    NSDate *foodDate = picker.date;

    if (!foodDate) {
        foodDate = [NSDate date];
    }
    
    [LOFood createOrUpdateObject:self.screenFoodName
                            type:[self typeForFoodItem]
                        categories:[self categoriesForFoodItem]
                        location:[self locationForFoodItem]
                        mediaURL:[self mediaURLForFoodItem]
                            date:foodDate
                      rootItemID:self.rootItem.rootItemID
                      completion:^(BOOL success, NSManagedObjectID *objectID, NSError *error) {
                          [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                      }];
}

- (NSInteger)typeForFoodItem
{
    return [self.rootItem.baseFoodType integerValue];
}

- (NSArray *)categoriesForFoodItem
{
    NSMutableArray *holderArray = [NSMutableArray new];
    
    for (NSString *string in [self.screenAwnsers valueForKey:@"2"]) {
        [holderArray addObject:[self numberForAwnser:string]];
    }
    
    return holderArray;
}

- (NSInteger)locationForFoodItem
{
    NSInteger locationForFoodItem = 0;
    
    for (NSString *string in [self.screenAwnsers valueForKey:@"1"]) {
        locationForFoodItem = [[self numberForAwnser:string] integerValue];
    }
    
    return locationForFoodItem;
}

- (NSString *)mediaURLForFoodItem
{
    return self.screenMediaURL;
}

- (void)setFoodMediaImageFromGoogleImage:(SCGoogleImage *)mediaImage
{
    self.screenMediaURL = mediaImage.link;
}


- (NSNumber *)numberForAwnser:(NSString *)awnswer
{
    if ([awnswer isEqualToString:@"from a restaurant"]) {
        return [NSNumber numberWithInteger:LOFoodLocationRestaurant];
    }
    
    if ([awnswer isEqualToString:@"delivery"]) {
        return [NSNumber numberWithInteger:LOFoodLocationRestaurant];
    }
    
    if ([awnswer isEqualToString:@"home cooked"]) {
        return [NSNumber numberWithInteger:LOFoodLocationHome];
    }
    
    if ([awnswer isEqualToString:@"farm to table"]) {
        return [NSNumber numberWithInteger:LOFoodCategoryFarmToTable];
    }
    
    if ([awnswer isEqualToString:@"a chain"]) {
        return [NSNumber numberWithInteger:LOFoodCategoryConventional];
    }
    
    if ([awnswer isEqualToString:@"locally owned"]) {
        return [NSNumber numberWithInteger:LOFoodCategoryLocal];
    }
    
    if ([awnswer isEqualToString:@"organic"]) {
        return [NSNumber numberWithInteger:LOFoodCategoryOrganic];
    }
    
    if ([awnswer isEqualToString:@"locally sourced"]) {
        return [NSNumber numberWithInteger:LOFoodCategoryLocal];
    }
    
    if ([awnswer isEqualToString:@"supermarket"]) {
        return [NSNumber numberWithInteger:LOFoodCategoryConventional];
    }
    
    if ([awnswer isEqualToString:@"farmers market"]) {
        return [NSNumber numberWithInteger:LOFoodCategoryFarmersMarket];
    }
    
    if ([awnswer isEqualToString:@"csa"]) {
        return [NSNumber numberWithInteger:LOFoodCategoryCSA];
    }
    
    if ([awnswer isEqualToString:@"vendor"]) {
        return [NSNumber numberWithInteger:LOFoodCategoryVendor];
    }
    
    return @0;
}



@end
