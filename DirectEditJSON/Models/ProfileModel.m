//
//  ProfileModel.m
//  CouchbaseModel
//
//  Created by developer on 6/24/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import "ProfileModel.h"

@interface ProfileModel ()
@property (strong) NSString *type;
@property (strong) NSDate *datetime;
@end

@implementation ProfileModel
@dynamic type, datetime, name, username, email, password, userId, avatar, thumbnailAvatar;
- (id)initWithNewDocumentInDatabase:(CBLDatabase *)database
{
    self = [super initWithNewDocumentInDatabase:database];
    if (self) {
        self.type = @"profile";
        self.datetime = [NSDate date];
    }
    return self;
}
@end
