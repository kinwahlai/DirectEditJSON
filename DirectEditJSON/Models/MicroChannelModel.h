//
//  MicroChannelModel.h
//  CouchbaseModel
//
//  Created by kazaana_developer on 6/20/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import "CrazeModel.h"

@class CategoryModel;

@interface MicroChannelModel : CrazeModel
@property (strong) NSString *name;
@property (strong) NSString *description;
@property (strong) NSString *coverphotoURL;
@property NSInteger userId;
@property (assign) CategoryModel *category;
@property bool personalChannel;
@property NSInteger channelId; /* Need more discussion */
@end
