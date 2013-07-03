//
//  PostLikeModel.h
//  CouchbaseModel
//
//  Created by developer on 6/24/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import "CrazeModel.h"

@class PostModel;

@interface PostLikeModel : CrazeModel
@property NSInteger userId;
@property NSInteger postUserId;
@property (strong) PostModel *post;
@end
