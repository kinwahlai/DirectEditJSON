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

@interface CouchbaseHelper () <SyncManagerDelegate>
{
    SyncManager* _syncManager;
    NSDictionary *_serverInfo;
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
        _database = [[CBLManager sharedInstance] createDatabaseNamed:@"grocery" error:&error];
        if (!self.database) {
            NSLog(@"Couldn't open database - %@",error.localizedDescription);
        }
        [self loadServerInfoFromPlist];
        if ([[_serverInfo objectForKey:@"kServerDBURLString"] hasPrefix:@"ENTER"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Missing DB URL" message:@"Please enter your db url in serverinfo.plist" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        } else {
            [self setupSync];
        }
        [self setupViews];
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

-(void)loadServerInfoFromPlist
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"ServerInfo" ofType:@"plist"];
    _serverInfo = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
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
    _syncManager.syncURL = [NSURL URLWithString: [_serverInfo objectForKey:@"kServerDBURLString"]];
}

-(bool)syncManagerShouldPromptForLogin:(SyncManager *)manager
{
    [manager setUsername:[_serverInfo objectForKey:@"kServerUsername"] password:[_serverInfo objectForKey:@"kServerPassword"]];
    return false;
}
@end
