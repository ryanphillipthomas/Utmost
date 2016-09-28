//
//  LOItem+CoreDataClass.m
//  Loop
//
//  Created by Ryan Thomas on 8/1/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOItem.h"
#import "LOActivity.h"
#import "LOFood.h"
@implementation LOItem

+ (void)deleteObjectWithDate:(NSDate *)date
                  completion:(LOSaveCompletionBlock)completionBlock; {
    
    __block LOItem *itemToDelete;
    __block LOItem *fetchedItemToDelete;
    
    __block LOFood *foodToDelete;
    __block LOActivity *activityToDelete;

    
    if (date) {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            @autoreleasepool {
                fetchedItemToDelete = [[LOItem MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"date = %@", date] inContext:localContext] firstObject];
                if (fetchedItemToDelete) {
                    itemToDelete = [localContext objectWithID:fetchedItemToDelete.objectID];
                    foodToDelete = itemToDelete.food;
                    activityToDelete = itemToDelete.activity;

                    
                    if (foodToDelete) {
                        [foodToDelete.rootItem removeFoodsObject:foodToDelete];
                        [foodToDelete MR_deleteEntityInContext:localContext];
                    }
                    
                    if (activityToDelete) {
                        [activityToDelete.rootItem removeActivitiesObject:activityToDelete];
                        [activityToDelete MR_deleteEntityInContext:localContext];
                    }
                    
                    [itemToDelete MR_deleteEntityInContext:localContext];

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
