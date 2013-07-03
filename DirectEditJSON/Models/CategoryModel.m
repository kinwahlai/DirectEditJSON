//
//  CBLCategory.m
//  CouchbaseModel
//
//  Created by kazaana_developer on 6/20/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import "CategoryModel.h"

@interface CategoryModel ()
@property (strong) NSString *type;
@end

@implementation CategoryModel
@dynamic type, name, description, placeholderURL;

- (id)initWithNewDocumentInDatabase:(CBLDatabase *)database
{
    self = [super initWithNewDocumentInDatabase:database];
    if (self) {
        self.type = @"category";
    }
    return self;
}

-(BOOL)isImage { return YES;}
-(NSString *)getImageURLString {return self.placeholderURL;}
-(NSString *)caption {return self.name;}
@end
