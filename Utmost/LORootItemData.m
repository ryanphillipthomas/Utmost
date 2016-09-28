//
//  LORootItemData.m
//  Utmost
//
//  Created by Ryan Thomas on 8/15/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LORootItemData.h"
#import "LORootItem.h"
#import "LOFood.h"

@implementation LORootItemData
- (void)startParsingWithCompletion:(void (^)(BOOL performed))completionBlock;

{
    __block NSMutableArray *localRootItems = [NSMutableArray new];
    __block NSMutableArray *updatedRootItems = [NSMutableArray new];
    
    NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://dothemovement.com/rootItems.xml"]];
    [xmlparser setDelegate:self];
    [xmlparser parse];
    
    if (self.marrXMLData.count > 0) {
        NSUInteger counter = 0;
        for (NSDictionary *dic in self.marrXMLData) {
            ++ counter;
            
            NSString *baseActivityType = [dic objectForKey:@"baseActivityType"];
            NSString *baseFoodType = [dic objectForKey:@"baseFoodType"];
            
            [LORootItem createOrUpdateObject:[dic objectForKey:@"title"]
                                rootItemType:[dic objectForKey:@"type"]
                                  rootItemID:[dic objectForKey:@"id"]
                                    imageURL:[dic objectForKey:@"image"]
                            baseActivityType:[self activityTypeForString:baseActivityType]
                                baseFoodType:[self foodTypeForString:baseFoodType]
                   environmentFrequencyLimit:@([[dic objectForKey:@"environmentFrequencyLimit"] integerValue])
                        healthFrequencyLimit:@([[dic objectForKey:@"healthFrequencyLimit"] integerValue])
                                  completion:^(BOOL success, NSManagedObjectID *objectID, NSError *error) {
                                         
                                         [updatedRootItems addObject:[dic objectForKey:@"id"]];
                                         
                                         //if we are complete
                                         //compare api return vs local return and resolve..
                                         
                                         if (counter == self.marrXMLData.count) {
                                             for (LORootItem *rootItem in [LORootItem MR_findAll]) {
                                                 [localRootItems addObject:rootItem.rootItemID];
                                             }
                                             
                                             NSMutableArray *rootItemsToRemove = [NSMutableArray arrayWithArray:localRootItems];
                                             [rootItemsToRemove removeObjectsInArray:updatedRootItems];
                                             
                                             if (rootItemsToRemove.count > 0) {
                                                 //trigger deletions
                                                 NSUInteger pendingDeleteCounter = 0;
                                                 
                                                 for (NSString *rootItemID in rootItemsToRemove) {
                                                     ++pendingDeleteCounter;
                                                     [LORootItem deleteObjectWithRootItemID:rootItemID completion:^(BOOL success, NSManagedObjectID *objectID, NSError *error) {
                                                         if (pendingDeleteCounter == rootItemsToRemove.count) {
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
//    NSLog(@"%@", elementName);
    
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
//    NSLog(@"Element Name: %@", elementName);
    
    if ([elementName isEqualToString:@"title"]
        || [elementName isEqualToString:@"baseFoodType"]
        || [elementName isEqualToString:@"environmentFrequencyLimit"]
        || [elementName isEqualToString:@"healthFrequencyLimit"]
        || [elementName isEqualToString:@"id"]
        || [elementName isEqualToString:@"type"]
        || [elementName isEqualToString:@"baseActivityType"]
        || [elementName isEqualToString:@"image"]) {
        
        NSCharacterSet *charToRemove = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        [self.mdictXMLPart setObject: [self.mstrXMLString stringByTrimmingCharactersInSet:charToRemove] forKey:elementName];
        
     //   NSLog(@"Element Data: %@", self.mstrXMLString);
    }
    
    if ([elementName isEqualToString:@"item"]) {
        [self.marrXMLData addObject:self.mdictXMLPart];
    }
    
    self.mstrXMLString = nil;
}

//TODO
- (NSInteger)activityTypeForString:(NSString *)activityTypeString {
    if ([activityTypeString isEqualToString:@"LOActivityTypeOther"]) {
        return LOActivityTypeOther;
    }
    if ([activityTypeString isEqualToString:@"LOActivityTypeStrength"]) {
        return LOActivityTypeStrength;
    }
    if ([activityTypeString isEqualToString:@"LOActivityTypeCardio"]) {
        return LOActivityTypeCardio;
    }
    if ([activityTypeString isEqualToString:@"LOActivityTypeFlexibility"]) {
        return LOActivityTypeFlexibility;
    }
    
    return LOActivityTypeOther;
}

//TODO
- (NSInteger)foodTypeForString:(NSString *)foodTypeString {
    if ([foodTypeString isEqualToString:@"LOFoodTypeOther"]) {
        return LOFoodTypeOther;
    }
    if ([foodTypeString isEqualToString:@"LOFoodTypeRedProtein"]) {
        return LOFoodTypeRedProtein;
    }
    if ([foodTypeString isEqualToString:@"LOFoodTypeWhiteProtein"]) {
        return LOFoodTypeWhiteProtein;
    }
    if ([foodTypeString isEqualToString:@"LOFoodTypeNut"]) {
        return LOFoodTypeNut;
    }
    if ([foodTypeString isEqualToString:@"LOFoodTypeFruit"]) {
        return LOFoodTypeFruit;
    }
    if ([foodTypeString isEqualToString:@"LOFoodTypeVegetable"]) {
        return LOFoodTypeVegetable;
    }
    if ([foodTypeString isEqualToString:@"LOFoodTypePlantProtein"]) {
        return LOFoodTypePlantProtein;
    }
    
    return LOFoodTypeOther;
}

@end
