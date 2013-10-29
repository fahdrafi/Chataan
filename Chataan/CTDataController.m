//
//  CTDataController.m
//  Chataan
//
//  Created by Fahd Rafi on 26/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import "CTDataController.h"
#import "DDXML.h"

@interface CTDataController () {
    NSMutableDictionary* _dataCache;
    dispatch_queue_t _queue;
}

@property (nonatomic, readonly) NSMutableDictionary* dataCache;

@end

static CTDataController* _dataController = nil;

@implementation CTDataController

- (dispatch_queue_t)queue {
    if (!_queue)
        _queue = dispatch_queue_create("dataCacheQueue", NULL);
    return _queue;
}

- (void)setXMLForEntity:(NSString*)entity XML:(NSString*)xml {
    dispatch_sync(self.queue, ^{
        NSError* err;
        DDXMLNode* xmlNode = [[DDXMLElement alloc] initWithXMLString:xml error:&err];
        [self.dataCache setObject:xmlNode
                           forKey:entity];
    });
}

- (id)nodesForXPath:(NSString*)xPath forEntity:(NSString*)entity {
    __block id response = nil;
    dispatch_sync(self.queue, ^{
        DDXMLDocument* xmlDoc = self.dataCache[entity];
        response = [xmlDoc nodesForXPath:xPath error:nil];
    });
    return response;
}

- (NSMutableDictionary*)dataCache {
    if (!_dataCache) {
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"DummyData" ofType:@"plist"];
        _dataCache = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    }
    return _dataCache;
}

+ (CTDataController*)sharedController {
    if (!_dataController)
        _dataController = [[CTDataController alloc] init];
    return _dataController;
}


// key = @"Entities/EntityID/RDF/c:name"

- (id)objectForKeyedSubscript:(NSString*)key {
    NSArray* keysArray = [key componentsSeparatedByString:@"/"];
    
    __block id currentObject = self.dataCache;
    
    dispatch_sync(self.queue, ^(void){
        for (NSString* key in keysArray) {
            currentObject = [currentObject objectForKey:key];
        }
    });
    return currentObject;
}

@end
