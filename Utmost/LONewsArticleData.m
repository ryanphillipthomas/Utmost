//
//  LONewsArticleData.m
//  Utmost
//
//  Created by Ryan Thomas on 8/10/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LONewsArticleData.h"
#import "LONewsArticle.h"


@implementation LONewsArticleData

- (void)startParsingWithCompletion:(void (^)(BOOL performed))completionBlock;

{
    __block NSMutableArray *localNewsArticles = [NSMutableArray new];
    __block NSMutableArray *updatedNewsArticles = [NSMutableArray new];
    
    //sustainability //blog //movement
    NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://www.dothemovement.com/category/movement/feed/rss2/"]];
    [xmlparser setDelegate:self];
    [xmlparser parse];
    
    if (self.marrXMLData.count > 0) {
        NSUInteger counter = 0;
        for (NSDictionary *dic in self.marrXMLData) {
            ++ counter;
            [LONewsArticle createOrUpdateObject:[dic objectForKey:@"title"]
                                      articleID:[dic objectForKey:@"pubDate"]
                                       imageURL:[dic objectForKey:@"image"]
                                    articleLink:[dic objectForKey:@"link"]
                                     completion:^(BOOL success, NSManagedObjectID *objectID, NSError *error) {
                                         
                                         [updatedNewsArticles addObject:[dic objectForKey:@"pubDate"]];
                                         
                                         //if we are complete
                                         //compare api return vs local return and resolve..

                                         if (counter == self.marrXMLData.count) {
                                             for (LONewsArticle *newsArticle in [LONewsArticle MR_findAll]) {
                                                 [localNewsArticles addObject:newsArticle.articleID];
                                             }
                                             
                                             NSMutableArray *newsArticlesToRemove = [NSMutableArray arrayWithArray:localNewsArticles];
                                             [newsArticlesToRemove removeObjectsInArray:updatedNewsArticles];
                                             
                                             if (newsArticlesToRemove.count > 0) {
                                                 //trigger deletions
                                                 NSUInteger pendingDeleteCounter = 0;
                                                 
                                                 for (NSString *articleID in newsArticlesToRemove) {
                                                     ++pendingDeleteCounter;
                                                     [LONewsArticle deleteObjectWithArticleID:articleID completion:^(BOOL success, NSManagedObjectID *objectID, NSError *error) {
                                                         if (pendingDeleteCounter == newsArticlesToRemove.count) {
                                                             if (completionBlock != nil) completionBlock(YES);
                                                         }
                                                     }];
                                                 }
                                                 
                                             } else {
                                                 if (completionBlock != nil) completionBlock(YES);
                                             }
                                         }
                                     }];
        }
    } else {
        if (completionBlock != nil) completionBlock(YES);
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //NSLog(@"%@", elementName);

    if ([elementName isEqualToString:@"rss"]) {
        self.marrXMLData = [[NSMutableArray alloc] init];
    }
    if ([elementName isEqualToString:@"item"]) {
        self.mdictXMLPart = [[NSMutableDictionary alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (!self.mstrXMLString) {
        self.mstrXMLString = [[NSMutableString alloc] initWithString:string];
    }
    else {
        [self.mstrXMLString appendString:string];
    }
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"Element Name: %@", elementName);
    
    if ([elementName isEqualToString:@"title"] || [elementName isEqualToString:@"description"]  || [elementName isEqualToString:@"link"] || [elementName isEqualToString:@"pubDate"]) {
        
        NSCharacterSet *charToRemove = [NSCharacterSet whitespaceAndNewlineCharacterSet];

        if ([elementName isEqualToString:@"description"]) {
            NSString *descriptionToImageString = [self findFirstImgUrlInString:self.mstrXMLString];
            
            if (descriptionToImageString.length > 0) {
                [self.mdictXMLPart setObject: [[self findFirstImgUrlInString:self.mstrXMLString] stringByTrimmingCharactersInSet:charToRemove] forKey:@"image"];
            } else {
                [self.mdictXMLPart setObject: @"" forKey:@"image"]; //empty image string
            }

        } else {
            [self.mdictXMLPart setObject: [self.mstrXMLString stringByTrimmingCharactersInSet:charToRemove] forKey:elementName];
        }

        
        //NSLog(@"Element Data: %@", self.mstrXMLString);
    }
    
    if ([elementName isEqualToString:@"item"]) {
        [self.marrXMLData addObject:self.mdictXMLPart];
    }
    self.mstrXMLString = nil;
}


- (NSString *)findFirstImgUrlInString:(NSMutableString *)string
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(<img\\s[\\s\\S]*?src\\s*?=\\s*?['\"](.*?)['\"][\\s\\S]*?>)+?"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSTextCheckingResult *result = [regex firstMatchInString:string
                                                     options:0
                                                       range:NSMakeRange(0, [string length])];
    
    if (result)
        return [string substringWithRange:[result rangeAtIndex:2]];
    
    return nil;
}


@end
