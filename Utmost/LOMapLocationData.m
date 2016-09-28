//
//  LOMapLocationData.m
//  Utmost
//
//  Created by Ryan Thomas on 8/11/16.
//  Copyright © 2016 Ryan Phillip Thomas. All rights reserved.
//

#import "LOMapLocationData.h"

@implementation LOMapLocationData

- (void)startParsingWithCompletion:(void (^)(BOOL performed))completionBlock;

{
    __block NSMutableArray *localLocations = [NSMutableArray new];
    __block NSMutableArray *updatedLocations = [NSMutableArray new];
    
    NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://dothemovement.com/mapLocations.xml"]];
    [xmlparser setDelegate:self];
    [xmlparser parse];
    
    if (self.marrXMLData.count > 0) {
        NSUInteger counter = 0;
        
        for (NSDictionary *dic in self.marrXMLData) {
            ++ counter;
            [LOLocation createOrUpdateObject:[dic objectForKey:@"title"]
                                  locationID:[dic objectForKey:@"id"]
                                     address:[dic objectForKey:@"address"]
                                    latitude:[dic objectForKey:@"latitude"]
                                   longitude:[dic objectForKey:@"longitude"]
                                   image:[dic objectForKey:@"image"]
                                  completion:^(BOOL success, NSManagedObjectID *objectID, NSError *error) {
                                      
                                      [updatedLocations addObject:[dic objectForKey:@"id"]];
                                      
                                      //if we are complete
                                      //compare api return vs local return and resolve..

                                      if (counter == self.marrXMLData.count) {
                                          for (LOLocation *location in [LOLocation MR_findAll]) {
                                              [localLocations addObject:location.locationID];
                                          }
                                          
                                          NSMutableArray *locationsToRemove = [NSMutableArray arrayWithArray:localLocations];
                                          [locationsToRemove removeObjectsInArray:updatedLocations];
                                          
                                          if (locationsToRemove.count > 0) {
                                              //trigger deletions
                                              NSUInteger pendingDeleteCounter = 0;

                                              for (NSString *locationID in locationsToRemove) {
                                                  ++pendingDeleteCounter;
                                                  [LOLocation deleteObjectWithLocationID:locationID completion:^(BOOL success, NSManagedObjectID *objectID, NSError *error) {
                                                      if (pendingDeleteCounter == locationsToRemove.count) {
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
    
    if ([elementName isEqualToString:@"title"]
        || [elementName isEqualToString:@"description"]
        || [elementName isEqualToString:@"latitude"]
        || [elementName isEqualToString:@"longitude"]
        || [elementName isEqualToString:@"address"]
        || [elementName isEqualToString:@"id"]
        || [elementName isEqualToString:@"image"]) {
        
        NSCharacterSet *charToRemove = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        [self.mdictXMLPart setObject: [self.mstrXMLString stringByTrimmingCharactersInSet:charToRemove] forKey:elementName];
        
        //NSLog(@"Element Data: %@", self.mstrXMLString);
    }
    
    if ([elementName isEqualToString:@"item"]) {
        [self.marrXMLData addObject:self.mdictXMLPart];
    }
    self.mstrXMLString = nil;
}


@end
