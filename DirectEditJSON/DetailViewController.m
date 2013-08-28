//
//  DetailViewController.m
//  DirectEditJSON
//
//  Created by developer on 7/3/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import "DetailViewController.h"
#import <CouchbaseLite/CouchbaseLite.h>
#import <CouchbaseLite/CBLJSON.h>
#import "CBLJSONValidator.h"
#import "CouchbaseHelper.h"

@interface DetailViewController ()
{
    NSString *originalJSONString;
}
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        CBLQueryRow *row = (CBLQueryRow *)self.detailItem;
        self.jsonTextView.text = [CBLJSON stringWithJSONObject: row.documentProperties options: CBLJSONWritingAllowFragments error: nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [self configureView];
    self.jsonTextView.editable = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    if (self.detailItem) {
        [super setEditing:editing animated:animated];
        if (editing) {
            CBLQueryRow *row = (CBLQueryRow *)self.detailItem;
            originalJSONString = [CBLJSON stringWithJSONObject: row.documentProperties options: CBLJSONWritingAllowFragments error: nil];
            
            UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEdit)];
            UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveEdit)];
            
            self.navigationItem.rightBarButtonItems = @[cancel,save];
            
            self.jsonTextView.editable = YES;
        } else {
            originalJSONString = nil;
            self.navigationItem.rightBarButtonItems = nil;
            
            self.jsonTextView.editable = NO;
        }
    }
}

-(void)cancelEdit
{
    if (self.detailItem) {
        CBLQueryRow *row = (CBLQueryRow *)self.detailItem;
        self.jsonTextView.text = [CBLJSON stringWithJSONObject: row.documentProperties options: CBLJSONWritingAllowFragments error: nil];
    }
    originalJSONString = nil;
}

-(void)saveEdit
{
    NSError *error;
    NSDictionary *jsonDict = [CBLJSON JSONObjectWithData:[self.jsonTextView.text dataUsingEncoding:NSUTF8StringEncoding]
                                                 options: CBLJSONReadingAllowFragments
                                                   error: &error];
    if (!error) {
        error = nil;
        CBLQueryRow *row = (CBLQueryRow *)self.detailItem;
        [row.document putProperties:jsonDict error:&error];
        if (!error) {
            NSLog(@"new revision added");
        }
    }
}

@end
