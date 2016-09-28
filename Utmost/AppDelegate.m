//
//  AppDelegate.m
//  Loop
//
//  Created by Ryan Phillip Thomas on 11/1/15.
//  Copyright © 2015 Ryan Phillip Thomas. All rights reserved.
//

#import "AppDelegate.h"
#import <MagicalRecord/MagicalRecord.h>
#import "LORootItem.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

//initalize app with root food items

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupCoreData];
    [self refreshData];
    [Fabric with:@[[Crashlytics class]]];
    //style
    
   //GE Inspira
   //    GEInspira-Bold
    //   GEInspira-Italic
    //   GEInspira
    //   GEInspira-BoldItalic
    
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }

    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : kDARK_GREY_COLOR,
                                                           NSFontAttributeName : [UIFont fontWithName:@"GEInspira-Bold" size:18]}];
    [[UINavigationBar appearance] setTintColor:kLIGHT_BLUE_COLOR];

    
    
    return YES;
}

- (void)setupCoreData
{
    [MagicalRecord cleanUp];
    
    MagicalRecordStack *stack = [[ClassicWithBackgroundCoordinatorSQLiteMagicalRecordStack alloc] initWithStoreNamed:@"LODataModel.momd"];
    [MagicalRecordStack setDefaultStack:stack];
    [MagicalRecord setLoggingLevel:MagicalRecordLoggingLevelOff];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
}

- (void)refreshData
{
    [self performSelectorInBackground:@selector(refreshRootItems) withObject:nil];
}

- (void)refreshRootItems {
    [[self rootItemsData] startParsingWithCompletion:^(BOOL performed) {
        //  [self.tableView reloadData];
        //todo check items for count and display empty status if applicable
    }];
}

- (LORootItemData *)rootItemsData
{
    if (!_rootItemsData) {
        _rootItemsData = [[LORootItemData alloc] init];
    }
    
    return _rootItemsData;
}

@end
