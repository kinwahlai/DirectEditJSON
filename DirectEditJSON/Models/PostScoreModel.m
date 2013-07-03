//
//  PostScore.m
//  CouchbaseModel
//
//  Created by developer on 6/24/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import "PostScoreModel.h"

@interface PostScoreModel ()
@property (strong) NSString *type;
@end

@implementation PostScoreModel
@dynamic type, post, score, lastActionDate;
- (id)initWithNewDocumentInDatabase:(CBLDatabase *)database
{
    self = [super initWithNewDocumentInDatabase:database];
    if (self) {
        self.type = @"postscore";
    }
    return self;
}
@end
