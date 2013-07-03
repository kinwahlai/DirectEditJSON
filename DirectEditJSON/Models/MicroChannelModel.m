//
//  MicroChannelModel.m
//  CouchbaseModel
//
//  Created by kazaana_developer on 6/20/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import "MicroChannelModel.h"

@interface MicroChannelModel ()
@property (strong) NSString *type;
@end

@implementation MicroChannelModel
@dynamic type, name, description, coverphotoURL, userId, category, personalChannel, channelId;

- (id)initWithNewDocumentInDatabase:(CBLDatabase *)database
{
    self = [super initWithNewDocumentInDatabase:database];
    if (self) {
        self.type = @"channel";
    }
    return self;
}
-(BOOL)isImage { return YES;}
-(NSString *)getImageURLString {return self.coverphotoURL;}
@end
