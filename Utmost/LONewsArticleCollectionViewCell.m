//
//  ORGArticleCollectionViewCell.m
//  HorizontalCollectionViews
//
//  Created by James Clark on 4/23/13.
//  Copyright (c) 2013 OrgSync, LLC. All rights reserved.
//

#import "LONewsArticleCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation LONewsArticleCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
   //     self.articleImage.frame = CGRectMake(10.0f, 00.0f, frame.size.width - (10.0f * 2), frame.size.height);

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
 //   self.layer.borderColor = [[UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0] CGColor];
//    self.layer.borderWidth = 1.0;
   self.articleImage.layer.cornerRadius = 8;
    self.articleImage.layer.masksToBounds = YES;
}


@end
