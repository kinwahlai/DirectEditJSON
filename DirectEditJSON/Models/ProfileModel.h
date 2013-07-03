//
//  ProfileModel.h
//  CouchbaseModel
//
//  Created by developer on 6/24/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import "CrazeModel.h"

@interface ProfileModel : CrazeModel
@property (strong) NSString *name;
@property (strong) NSString *username;
@property (strong) NSString *email;
@property (strong) NSString *password;
@property NSInteger userId;
@property (strong) NSString *avatar;
@property (strong) NSString *thumbnailAvatar;
@end
