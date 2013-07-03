//
//  PostModel.m
//  CouchbaseModel
//
//  Created by kazaana_developer on 6/21/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import "PostModel.h"

@interface PostModel ()
@property (strong) NSString *type;
@property (strong) NSDate *datetime;
@end

@implementation PostModel
@dynamic type, datetime, microChannel, postId, postText, userId, assetType, originalAssetURL, thumbnailAssetURL, postSeqId, parentPost, deleteDatetime, hasAttachment;

- (id)initWithNewDocumentInDatabase:(CBLDatabase *)database
{
    self = [super initWithNewDocumentInDatabase:database];
    if (self) {
        self.type = @"post";
        self.datetime = [NSDate date];
    }
    return self;
}
@end
