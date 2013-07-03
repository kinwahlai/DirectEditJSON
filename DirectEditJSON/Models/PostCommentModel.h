//
//  PostCommentModel.h
//  CouchbaseModel
//
//  Created by developer on 6/24/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import "CrazeModel.h"

@class PostModel;

@interface PostCommentModel : CrazeModel
@property (strong) NSString *commentText;
@property NSInteger userId;
@property (strong) PostModel *post;
@property NSInteger postUserId;
@end
