//
//  CTDataController.m
//  Chataan
//
//  Created by Fahd Rafi on 26/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import "CTDataController.h"

@interface CTDataController () {
    NSArray* _topEntities;
    NSArray* _articles;
    NSDictionary* _dataCache;
//    dispatch_queue_t _queue;
}

@property (nonatomic, readonly) NSDictionary* dataCache;

@end

static CTDataController* _dataController = nil;

@implementation CTDataController

+ (CTDataController*)sharedController {
    if (!_dataController)
        _dataController = [[CTDataController alloc] init];
    return _dataController;
}

- (NSDictionary*)dataCache {
    if (!_dataCache) {
        NSArray* topEntities = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"top" ofType:@"plist"]][@"TopEntities"];
        NSArray* storiesForTopEntity = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StoryLinks" ofType:@"plist"]][@"Stories"];

        _dataCache = [[NSDictionary alloc] initWithObjectsAndKeys:topEntities, @"TopEntities", storiesForTopEntity, @"Stories", nil];
    }
    return _dataCache;
}

- (NSArray*)topEntities {
    if (_topEntities) return _topEntities;
    
    NSArray* entitiesDicts = self.dataCache[@"TopEntities"];
    NSMutableArray* topEntities = [[NSMutableArray alloc] init];
    
    for (NSDictionary* entityDict in entitiesDicts) {
        CTEntityModel* entity = [[CTEntityModel alloc] init];
        entity.entityID = entityDict[@"_id"];
        entity.displayName = entityDict[@"EntityName"];
        [topEntities addObject:entity];
    }
    
    _topEntities = [NSArray arrayWithArray:topEntities];
    return _topEntities;
}

- (NSArray*)storiesForEntity:(NSString*)entity {
    if (_articles) return _articles;
    
    NSArray* stories = self.dataCache[@"Stories"];
    NSMutableArray* tempArticles = [[NSMutableArray alloc] init];
    
    for (NSDictionary* story in stories) {
        CTArticle* article = [[CTArticle alloc] init];
        article.title = story[@"Title"];
        article.description = story[@"Description"];
        article.imageURL = nil;
        article.url = story[@"Link"];
        [tempArticles addObject:article];
    }
    _articles = [NSArray arrayWithArray:tempArticles];
    
    return _articles;
}

- (NSArray*)entitiesForEntity:(NSString*)entity {
    return [NSArray array];
}

//- (dispatch_queue_t)queue {
//    if (!_queue)
//        _queue = dispatch_queue_create("dataCacheQueue", NULL);
//    return _queue;
//}
//
//
//- (void)setXMLForEntity:(NSString*)entity XML:(NSString*)xml {
//    dispatch_sync(self.queue, ^{
//        NSError* err;
//        DDXMLNode* xmlNode = [[DDXMLElement alloc] initWithXMLString:xml error:&err];
//        [self.dataCache setObject:xmlNode
//                           forKey:entity];
//    });
//}
//
//- (id)nodesForXPath:(NSString*)xPath forEntity:(NSString*)entity {
//    __block id response = nil;
//    dispatch_sync(self.queue, ^{
//        DDXMLDocument* xmlDoc = self.dataCache[entity];
//        response = [xmlDoc nodesForXPath:xPath error:nil];
//    });
//    return response;
//}
//
//// key = @"Entities/EntityID/RDF/c:name"
//
//- (id)objectForKeyedSubscript:(NSString*)key {
//    NSArray* keysArray = [key componentsSeparatedByString:@"/"];
//    
//    __block id currentObject = self.dataCache;
//    
//    dispatch_sync(self.queue, ^(void){
//        for (NSString* key in keysArray) {
//            currentObject = [currentObject objectForKey:key];
//        }
//    });
//    return currentObject;
//}

@end
