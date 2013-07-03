//
//  PostShareModel.m
//  CouchbaseModel
//
//  Created by developer on 6/24/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import "PostShareModel.h"

@interface PostShareModel ()
@property (strong) NSString *type;
@property (strong) NSDate *datetime;
@end

@implementation PostShareModel
@dynamic type, datetime, userId,postUserId,post;
- (id)initWithNewDocumentInDatabase:(CBLDatabase *)database
{
    self = [super initWithNewDocumentInDatabase:database];
    if (self) {
        self.type = @"postshare";
        self.datetime = [NSDate date];
    }
    return self;
}
@end
