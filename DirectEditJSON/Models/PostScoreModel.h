//
//  PostScore.h
//  CouchbaseModel
//
//  Created by developer on 6/24/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import "CrazeModel.h"

@class PostModel;

@interface PostScoreModel : CrazeModel
@property (strong) PostModel *post;
@property NSInteger score;
@property (strong) NSDate *lastActionDate;
@end
