//
//  PostLikeModel.m
//  CouchbaseModel
//
//  Created by developer on 6/24/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import "PostLikeModel.h"

@interface PostLikeModel ()
@property (strong) NSString *type;
@property (strong) NSDate *datetime;
@end

@implementation PostLikeModel
@dynamic type, userId, datetime, postUserId, post;
- (id)initWithNewDocumentInDatabase:(CBLDatabase *)database
{
    self = [super initWithNewDocumentInDatabase:database];
    if (self) {
        self.type = @"postlike";
        self.datetime = [NSDate date];
    }
    return self;
}
@end
