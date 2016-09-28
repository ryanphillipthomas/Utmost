//
//  AppDelegate.h
//  Loop
//
//  Created by Ryan Phillip Thomas on 11/1/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LORootItemData.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) LORootItemData *rootItemsData;

@end

