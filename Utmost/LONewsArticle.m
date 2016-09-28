//
//  LONewsArticle+CoreDataClass.m
//  
//
//  Created by Ryan Thomas on 8/10/16.
//
//

#import "LONewsArticle.h"

@implementation LONewsArticle

+ (void)createOrUpdateObject:(NSString *)title
                   articleID:(NSString *)articleID
                    imageURL:(NSString *)imageURL
                 articleLink:(NSString *)articleLink
                  completion:(LOSaveCompletionBlock)completionBlock
{
    __block LONewsArticle *article;
    __block LONewsArticle *fetchedArticle;
    __block NSString *newArticleID = articleID;
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        @autoreleasepool {
            if (!newArticleID) {
                newArticleID = [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                           dateStyle:NSDateFormatterShortStyle
                                                           timeStyle:NSDateFormatterFullStyle];
            }
            fetchedArticle = [[LONewsArticle MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"articleID = %@", newArticleID] inContext:localContext] firstObject];
            
            if (!fetchedArticle) {
                article = [LONewsArticle MR_createEntityInContext:localContext];
            } else {
                article = [fetchedArticle MR_inContext:localContext];
            }
            
            article.title = [title capitalizedString];;
            article.articleID = articleID;
            article.imageURL = imageURL;
            article.link = articleLink;
        }
        
    } completion:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(),^{
            if (completionBlock != nil) completionBlock(YES, nil, nil);
        });
    }];
}

+ (void)deleteObjectWithArticleID:(NSString *)articleID
                  completion:(LOSaveCompletionBlock)completionBlock; {
    
    __block LONewsArticle *articleToDelete;
    __block LONewsArticle *fetchedArticleToDelete;
    
    if (articleID) {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            @autoreleasepool {
                fetchedArticleToDelete = [[LONewsArticle MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"articleID = %@", articleID] inContext:localContext] firstObject];
                if (fetchedArticleToDelete) {
                    articleToDelete = [localContext objectWithID:fetchedArticleToDelete.objectID];
                    [articleToDelete MR_deleteEntityInContext:localContext];
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
