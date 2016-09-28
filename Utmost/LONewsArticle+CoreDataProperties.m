//
//  LONewsArticle+CoreDataProperties.m
//  
//
//  Created by Ryan Thomas on 8/10/16.
//
//

#import "LONewsArticle+CoreDataProperties.h"

@implementation LONewsArticle (CoreDataProperties)

+ (NSFetchRequest<LONewsArticle *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LONewsArticle"];
}

@dynamic articleID;
@dynamic title;
@dynamic imageURL;
@dynamic link;

@end
