//
//  CouchbaseHelper.m
//  CouchbaseModel
//
//  Created by kazaana_developer on 6/20/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import "CouchbaseHelper.h"
#import <CouchbaseLite/CouchbaseLite.h>
#import "SyncManager.h"


//#define kServerDBURLString @"http://ec2-54-215-77-94.us-west-1.compute.amazonaws.com:4444/crazestage"
#define kServerDBURLString @"http://kinwahlai.iriscouch.com/grocery-sync"

@interface CouchbaseHelper () <SyncManagerDelegate>
{
    SyncManager* _syncManager;
}
@end

@implementation CouchbaseHelper
static CouchbaseHelper *_sharedInstance = nil;
static dispatch_once_t once_token = 0;
- (id)init
{
    self = [super init];
    if (self) {
        NSError* error;
        _database = [[CBLManager sharedInstance] createDatabaseNamed:@"craze" error:&error];
        if (!self.database) {
            NSLog(@"Couldn't open database - %@",error.localizedDescription);
        }
        [self setupViews];
        [self setupSync];
    }
    return self;
}
+(instancetype)sharedInstance {
    dispatch_once(&once_token, ^{
        if (_sharedInstance == nil) {
            _sharedInstance = [[CouchbaseHelper alloc] init];
        }
    });
    return _sharedInstance;
}

+(void)setSharedInstance:(CouchbaseHelper *)instance {
    once_token = 0; // resets the once_token so dispatch_once will run again
    _sharedInstance = instance;
}

#pragma mark -
#pragma mark setup views for our db
- (void) setupViews
{
    // all categories
    [[self.database viewNamed:@"allDocuments"] setMapBlock:MAPBLOCK({
        emit(doc[@"id"],doc);
    }) reduceBlock:nil version:@"0.1"];
}

#pragma mark -
#pragma mark queries
- (CBLQuery*)queryAllDocuments
{
    CBLQuery* query = [[self.database viewNamed: @"allDocuments"] query];
    query.descending = YES;
    return query;
}



#pragma mark -
#pragma mark SyncManager
- (void) setupSync {
    _syncManager = [[SyncManager alloc] initWithDatabase: _database];
    _syncManager.delegate = self;
    // Configure replication:
    _syncManager.continuous = YES;
    _syncManager.syncURL = [NSURL URLWithString: kServerDBURLString];
}

-(bool)syncManagerShouldPromptForLogin:(SyncManager *)manager
{
    [manager setUsername:@"admin" password:@"p@ssword!"];
    return false;
}

#pragma mark -
#pragma mark Handle auto login

- (void) saveLocalStateForUsername:(NSString*)username password:(NSString*)password {
    NSError* error;
    if (![self.database putLocalDocument: @{@"username": username, @"password":password}
                                  withID: @"loginState"
                                   error: &error])
        NSLog(@"Warning: Couldn't save local doc: %@", error);
}

- (NSDictionary*) loadLocalState {
    return [self.database getLocalDocumentWithID: @"loginState"];
}

- (void) deleteLocalState
{
    NSError *error;
    [self.database deleteLocalDocumentWithID:@"loginState" error:&error];
}
@end
