//
//  LOAddTableViewCell.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 12/5/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import "LOAddTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation LOAddTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)configureCellWithImageString:(NSString *)imageString forTitle:(NSString *)title withSubtitle:(NSString *)subtitle
{
    [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:nil];
    [self.title setText:title];
    [self.subtitle setText:subtitle];
}

@end
