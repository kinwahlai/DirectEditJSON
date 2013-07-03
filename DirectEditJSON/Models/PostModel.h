//
//  PostModel.h
//  CouchbaseModel
//
//  Created by kazaana_developer on 6/21/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import "CrazeModel.h"

@class MicroChannelModel;

@interface PostModel : CrazeModel
@property (strong) MicroChannelModel *microChannel;
@property NSInteger postId; /* Need more discussion */
@property (strong) NSString *postText;
@property NSInteger userId;
@property NSInteger assetType;
@property (strong) NSString *originalAssetURL;
@property (strong) NSString *thumbnailAssetURL;
@property NSInteger postSeqId;
@property (strong) PostModel *parentPost;
@property (strong) NSDate *deleteDatetime;
@property bool hasAttachment;
@end
