//
//  CTMasterViewController.m
//  Chataan
//
//  Created by Fahd Rafi on 10/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import "CTMasterViewController.h"

#import "CTDetailViewController.h"
#import "CTChartViewController.h"

#import "DDXML.h"

@interface CTMasterViewController () {
//    NSMutableArray *_entities;
//    NSMutableDictionary *_chartControllers;
}
//@property (strong, nonatomic, readonly) NSMutableDictionary *chartControllers;
@property (strong, nonatomic) NSMutableArray* entities;

@end

@implementation CTMasterViewController

- (NSMutableArray*)entities {
    if (!_entities) {
        _entities = [[NSMutableArray alloc] init];
    }
    return _entities;
}

//-(NSMutableDictionary*)chartControllers {
//    if (!_chartControllers)
//        _chartControllers = [[NSMutableDictionary alloc] init];
//    return _chartControllers;
//}

//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
//    self.detailViewController.detailItem = _objects[indexPath.row];
////    self.detailViewController.detailDescriptionLabel.text = [self.detailViewController.detailItem description];
//}

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    self.depth = 0;
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (!self.depth)
        self.navigationItem.leftBarButtonItem = self.editButtonItem;

//    self.detailViewController = (CTDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    DDXMLDocument *xmlDoc = [[DDXMLDocument alloc]
                             initWithXMLString:
                             [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://news.google.com/?output=rss"]
                                                      encoding:NSASCIIStringEncoding
                                                         error:nil]
                             options:DDXMLDocumentXMLKind
                             error:nil];
    
    NSArray *titles = [xmlDoc nodesForXPath:@"/rss/channel/item/title/text()" error:nil];
    for (NSString *title in titles) {
        [self insertNewObject:title];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)insertNewObject:(id)sender
{
    [self.entities insertObject:[sender description] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.entities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.textLabel.text = [self.entities[indexPath.row] description];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.entities removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EntityClicked" object:nil];
    
    if (self.depth>0) return;
    
    CTMasterViewController *newController = [self.storyboard instantiateViewControllerWithIdentifier:@"MasterController"];
    newController.title = self.entities[indexPath.row];
    newController.depth = self.depth + 1;
    newController.tableView.delegate = newController;
    newController.tableView.dataSource = newController;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddNewList" object:newController];
    
//    self.detailViewController.entityLinks = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:0.3], @"United States", [NSNumber numberWithFloat:0.7], @"Death", [NSNumber numberWithFloat:1.0], @"Thatcher", nil];
}

@end
