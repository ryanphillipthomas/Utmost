//
//  LOSettingsNewsDeleteCell.m
//  Utmost
//
//  Created by Ryan Thomas on 8/11/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOSettingsNewsDeleteCell.h"
#import "LONewsArticle.h"

@implementation LOSettingsNewsDeleteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didSelectDelete:(id)sender {
    [self clearDBWithCompletion:nil];
}

- (void)clearDBWithCompletion:(void (^)(BOOL success))completionBlock
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        [LONewsArticle MR_truncateAllInContext:localContext];
        
    } completion:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock != nil) completionBlock(YES);
        });
        
    }];
}

@end
