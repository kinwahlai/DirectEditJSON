//
//  MasterViewController.m
//  DirectEditJSON
//
//  Created by developer on 7/3/13.
//  Copyright (c) 2013 OnCraze. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "CouchbaseHelper.h"
#import <CouchbaseLite/CouchbaseLite.h>
#import <CouchbaseLite/CBLUITableSource.h>

@interface MasterViewController () <CBLUITableDelegate> {
    NSMutableArray *_objects;
}
@property (strong,nonatomic) CBLUITableSource *liveDataSource;
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];

    self.liveDataSource = (CBLUITableSource *)self.tableView.dataSource;
    self.liveDataSource.query = [[[CouchbaseHelper sharedInstance] queryAllDocuments] asLiveQuery];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
 */

#pragma mark - Table View
-(void)couchTableSource:(CBLUITableSource *)source willUseCell:(UITableViewCell *)cell forRow:(CBLQueryRow *)row
{
    cell.textLabel.text = [NSString stringWithFormat:@"%@ [%@]",[row document].abbreviatedID,[row document].properties[@"type"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBLQueryRow *row = [self.liveDataSource.query.rows rowAtIndex:indexPath.row];
    self.detailViewController.detailItem = row;
}

@end
