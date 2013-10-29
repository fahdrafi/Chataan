//
//  CTDataController.h
//  Chataan
//
//  Created by Fahd Rafi on 26/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTDataController : NSObject

+ (CTDataController*)sharedController;
- (id)objectForKeyedSubscript:(NSString*)key;

- (void)setXMLForEntity:(NSString*)entity XML:(NSString*)xml;
- (id)nodesForXPath:(NSString*)xPath forEntity:(NSString*)entity;

@end
