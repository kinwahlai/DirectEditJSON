//
//  CouchbaseHelper.h
//  CouchbaseModel
//
//  Created by kazaana_developer on 6/20/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CBLDatabase,CBLQuery,CategoryModel;

@interface CouchbaseHelper : NSObject
+(instancetype)sharedInstance;
+(void)setSharedInstance:(CouchbaseHelper*)instance;
#pragma mark -
#pragma mark queries
- (CBLQuery*)queryAllDocuments;
#pragma mark -
#pragma mark Properties
@property (nonatomic, strong, readonly) CBLDatabase *database;
@end
