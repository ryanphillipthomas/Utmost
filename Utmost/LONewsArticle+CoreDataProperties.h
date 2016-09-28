//
//  LONewsArticle+CoreDataProperties.h
//  
//
//  Created by Ryan Thomas on 8/10/16.
//
//

#import "LONewsArticle.h"


NS_ASSUME_NONNULL_BEGIN

@interface LONewsArticle (CoreDataProperties)

+ (NSFetchRequest<LONewsArticle *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *articleID;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *imageURL;
@property (nullable, nonatomic, copy) NSString *link;

@end

NS_ASSUME_NONNULL_END
