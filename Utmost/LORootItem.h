//
//  LORootItem+CoreDataClass.h
//  Utmost
//
//  Created by Ryan Thomas on 8/15/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "LOFood.h"
#import "LOActivity.h"

@class LOActivity, LOFood;

NS_ASSUME_NONNULL_BEGIN

@interface LORootItem : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (void)createOrUpdateObject:(NSString *)title
                rootItemType:(NSString *)rootItemType
                  rootItemID:(NSString *)rootItemID
                    imageURL:(NSString *)imageURL
            baseActivityType:(enum LOActivityType)baseActivityType
                baseFoodType:(enum LOFoodType)baseFoodType
   environmentFrequencyLimit:(NSNumber *)environmentFrequencyLimit
        healthFrequencyLimit:(NSNumber *)healthFrequencyLimit
                  completion:(LOSaveCompletionBlock)completionBlock;

+ (void)deleteObjectWithRootItemID:(NSString *)rootItemID
                        completion:(LOSaveCompletionBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END

#import "LORootItem+CoreDataProperties.h"
