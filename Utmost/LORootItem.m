//
//  LORootItem+CoreDataClass.m
//  Utmost
//
//  Created by Ryan Thomas on 8/15/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LORootItem.h"

@implementation LORootItem

+ (void)createOrUpdateObject:(NSString *)title
                rootItemType:(NSString *)rootItemType
                  rootItemID:(NSString *)rootItemID
                    imageURL:(NSString *)imageURL
            baseActivityType:(enum LOActivityType)baseActivityType
                baseFoodType:(enum LOFoodType)baseFoodType
   environmentFrequencyLimit:(NSNumber *)environmentFrequencyLimit
        healthFrequencyLimit:(NSNumber *)healthFrequencyLimit
                  completion:(LOSaveCompletionBlock)completionBlock;
{
    __block LORootItem *rootItem;
    __block LORootItem *fetchedRootItem;
    __block NSString *newRootItemID = rootItemID;
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        @autoreleasepool {
            if (!newRootItemID) {
                newRootItemID = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterFullStyle];
            }
            fetchedRootItem = [[LORootItem MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"rootItemID = %@", newRootItemID] inContext:localContext] firstObject];
            
            if (!fetchedRootItem) {
                rootItem = [LORootItem MR_createEntityInContext:localContext];
            } else {
                rootItem = [fetchedRootItem MR_inContext:localContext];
            }
            
            rootItem.title = [title capitalizedString];
            rootItem.baseFoodType = [NSNumber numberWithInteger:(LOFoodType)baseFoodType];
            rootItem.baseActivityType = [NSNumber numberWithInteger:(LOActivityType)baseActivityType];
            rootItem.environmentFrequencyLimit = environmentFrequencyLimit;
            rootItem.healthFrequencyLimit = healthFrequencyLimit;
            rootItem.image = imageURL;
            rootItem.rootItemID = newRootItemID;
            rootItem.itemTypeString = rootItemType;
        }
        
    } completion:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(),^{
            if (completionBlock != nil) completionBlock(YES, nil, nil);
        });
    }];
}

+ (void)deleteObjectWithRootItemID:(NSString *)rootItemID
                       completion:(LOSaveCompletionBlock)completionBlock; {
    
    __block LORootItem *rootItemToDelete;
    __block LORootItem *fetchedRootItemToDelete;
    
    if (rootItemID) {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            @autoreleasepool {
                fetchedRootItemToDelete = [[LORootItem MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"rootItemID = %@", rootItemID] inContext:localContext] firstObject];
                if (fetchedRootItemToDelete) {
                    rootItemToDelete = [localContext objectWithID:fetchedRootItemToDelete.objectID];
                    [rootItemToDelete MR_deleteEntityInContext:localContext];
                } else {
                    // could not delete
                    dispatch_async(dispatch_get_main_queue(),^{
                        if (completionBlock != nil) completionBlock(YES, nil, nil);
                    });
                }
            }
        } completion:^(BOOL success, NSError *error) {
            dispatch_async(dispatch_get_main_queue(),^{
                if (completionBlock != nil) completionBlock(success, nil, error);
            });
        }];
    } else {
        dispatch_async(dispatch_get_main_queue(),^{
            if (completionBlock != nil) completionBlock(YES, nil, nil);
        });
    }
}

@end
