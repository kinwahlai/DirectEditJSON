//
//  FollowChannelModel.h
//  CouchbaseModel
//
//  Created by developer on 6/26/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import "CrazeModel.h"

@class MicroChannelModel;

@interface FollowChannelModel : CrazeModel
@property NSInteger userId;
@property NSInteger channelUserId;
@property (nonatomic, strong) MicroChannelModel *channel;
@end
