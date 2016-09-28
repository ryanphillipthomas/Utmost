//
//  ORGDetailViewController.h
//  HorizontalCollectionViews
//
//  Created by James Clark on 4/22/13.
//  Copyright (c) 2013 OrgSync, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LONewsArticle.h"

@interface LONewsDetailViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingText;

@end
