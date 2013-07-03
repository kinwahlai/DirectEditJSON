    //
//  FollowChannelModel.m
//  CouchbaseModel
//
//  Created by developer on 6/26/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import "FollowChannelModel.h"

@interface FollowChannelModel ()
@property (strong) NSString *type;
@property (strong) NSDate *datetime;
@end

@implementation FollowChannelModel
@dynamic type, datetime, userId, channelUserId, channel;
- (id)initWithNewDocumentInDatabase:(CBLDatabase *)database
{
    self = [super initWithNewDocumentInDatabase:database];
    if (self) {
        self.type = @"follow";
        self.datetime = [NSDate date];
    }
    return self;
}
@end