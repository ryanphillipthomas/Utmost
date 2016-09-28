//
//  LONewsArticle+CoreDataClass.h
//  
//
//  Created by Ryan Thomas on 8/10/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecord.h>

NS_ASSUME_NONNULL_BEGIN

@interface LONewsArticle : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (void)createOrUpdateObject:(NSString *)title
                   articleID:(NSString *)articleID
                    imageURL:(NSString *)imageURL
                 articleLink:(NSString *)articleLink
                  completion:(LOSaveCompletionBlock)completionBlock;

+ (void)deleteObjectWithArticleID:(NSString *)articleID
                       completion:(LOSaveCompletionBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END

#import "LONewsArticle+CoreDataProperties.h"
