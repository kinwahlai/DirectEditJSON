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

@interface MasterViewController () <UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray *_objects;
}
//@property (strong,nonatomic) CBLUITableSource *liveDataSource;
@property (strong) CBLQuery *allDocQuery;
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
    _objects = [NSMutableArray array];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];

    self.allDocQuery = [[CouchbaseHelper sharedInstance] queryAllDocuments];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshFromQuery)
             forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self refreshFromQuery];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshFromQuery
{
    CBLQueryEnumerator *rowEnum = self.allDocQuery.rows;
    if (rowEnum) {
        [_objects removeAllObjects];
        [_objects addObjectsFromArray:rowEnum.allObjects];
    }
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}


#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
   CBLQueryRow *row = [_objects objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ [%@]",[row document].abbreviatedID,[row document].properties[@"type"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBLQueryRow *row = [_objects objectAtIndex:indexPath.row];
    self.detailViewController.detailItem = row;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CBLQueryRow *row = [_objects objectAtIndex:indexPath.row];
        [_objects removeObjectAtIndex:indexPath.row];
        NSError *error;
        [row.document deleteDocument:&error];
        if (!error) {
            row = nil;
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
@end
