//
//  LOSettingsHeaderTableViewCell.m
//  Utmost
//
//  Created by Ryan Thomas on 8/9/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOSettingsHeaderTableViewCell.h"

@implementation LOSettingsHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    [self setupTextFields];
}

- (void)setupTextFields {

    [self setInputAccessoryForTextfield:self.userFirstNameField];
    [self.userFirstNameField setDelegate:self];
    
    [self setInputAccessoryForTextfield:self.userLastNameField];
    [self.userLastNameField setDelegate:self];
    
    [self setInputAccessoryForTextfield:self.userEmailField];
    [self.userEmailField setDelegate:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


- (void)configureCellWithUserImage:(UIImage *)userImage
                         firstName:(NSString *)firstName
                          lastName:(NSString *)lastName
                            email:(NSString *)email
{
    [self.userImage setImage:userImage];
    [self.userFirstNameField setText:firstName];
    [self.userLastNameField setText:lastName];
    [self.userEmailField setText:email];
}

- (void)setInputAccessoryForTextfield:(UITextField *)textfield
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(dismiss)];
    [toolbar setItems:@[spacer, doneButton]];
    [textfield setInputAccessoryView:toolbar];
}

- (void)dismiss
{
    [self.userFirstNameField resignFirstResponder];
    [self.userLastNameField resignFirstResponder];
    [self.userEmailField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}

@end
