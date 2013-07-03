//
//  CrazeModelAssets.h
//  Craze
//
//  Created by developer on 7/3/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CrazeModelAssets <NSObject>
@required
-(BOOL)isImage;
-(BOOL)isVideo;
-(NSString*)getImageURLString;
-(NSString*)getVideoURLString;
@optional
-(NSString*)type;
-(NSString*)caption;
@end
