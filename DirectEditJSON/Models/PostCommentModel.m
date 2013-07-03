//
//  PostCommentModel.m
//  CouchbaseModel
//
//  Created by developer on 6/24/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import "PostCommentModel.h"

@interface PostCommentModel ()
@property (strong) NSString *type;
@property (strong) NSDate *datetime;
@end

@implementation PostCommentModel
@dynamic type, datetime, commentText, userId, post, postUserId;
- (id)initWithNewDocumentInDatabase:(CBLDatabase *)database
{
    self = [super initWithNewDocumentInDatabase:database];
    if (self) {
        self.type = @"postcomment";
        self.datetime = [NSDate date];
    }
    return self;
}
@end
