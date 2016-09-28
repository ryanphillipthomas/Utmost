//
//  LOSettingsPinsDeleteCell.m
//  Utmost
//
//  Created by Ryan Thomas on 8/11/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOSettingsPinsDeleteCell.h"
#import "LOLocation.h"

@implementation LOSettingsPinsDeleteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)didSelectDelete:(id)sender {
    [self clearDBWithCompletion:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)clearDBWithCompletion:(void (^)(BOOL success))completionBlock
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        [LOLocation MR_truncateAllInContext:localContext];
        
    } completion:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock != nil) completionBlock(YES);
        });
        
    }];
}

@end
