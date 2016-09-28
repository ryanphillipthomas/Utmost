//
//  ORGDetailViewController.m
//  HorizontalCollectionViews
//
//  Created by James Clark on 4/22/13.
//  Copyright (c) 2013 OrgSync, LLC. All rights reserved.
//

#import "LONewsDetailViewController.h"

@implementation LONewsDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        LONewsArticle *article = (LONewsArticle *)self.detailItem;
        NSURL *url = [NSURL URLWithString:article.link];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        
        NSString *title = article.title;
        self.title = title;
    }
}

- (void)hideLoadingIndicator
{
    [self.loadingIndicator setAlpha:0.0f];
    [self.loadingText setAlpha:0.0f];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [self.webView setDelegate:self];
    [self.webView setAlpha:0.0f];
    [self configureView];
    
    self.navigationItem.leftBarButtonItem = [self closeButtonItem];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self performSelector:@selector(fadeInWebView) withObject:nil afterDelay:1.0];
}

- (void)fadeInWebView
{
    [self hideLoadingIndicator];

    [UIView transitionWithView:self.webView
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.webView.alpha = 1.0;
                    } completion:NULL];
}

- (UIBarButtonItem *)closeButtonItem
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                         target:self
                                                         action:@selector(closeView:)];
}

- (void)closeView:(id)selector
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (self.detailItem) {
            LONewsArticle *article = (LONewsArticle *)self.detailItem;
            NSString *title = article.title;
            self.title = title;
        }
    }
    return self;
}
							
@end
