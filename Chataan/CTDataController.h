//
//  CTDataController.h
//  Chataan
//
//  Created by Fahd Rafi on 26/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CTEntityModel.h"
#import "CTArticle.h"

@interface CTDataController : NSObject

+ (CTDataController*)sharedController;

- (NSArray*)topEntities;
- (NSArray*)storiesForEntity:(NSString*)entity;
- (NSArray*)entitiesForEntity:(NSString*)entity;

//- (id)objectForKeyedSubscript:(NSString*)key;
//- (void)setXMLForEntity:(NSString*)entity XML:(NSString*)xml;
//- (id)nodesForXPath:(NSString*)xPath forEntity:(NSString*)entity;

@end
