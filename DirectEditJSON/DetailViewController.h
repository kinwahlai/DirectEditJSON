//
//  DetailViewController.h
//  DirectEditJSON
//
//  Created by developer on 7/3/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UITextView *jsonTextView;
@end
