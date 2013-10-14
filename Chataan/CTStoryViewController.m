//
//  CTStoryViewController.m
//  Chataan
//
//  Created by Fahd Rafi on 14/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import "CTStoryViewController.h"
#import "DDXML.h"
#import "CTArticle.h"
#import "CTStoryViewCell.h"

@interface CTStoryViewController ()

@property (strong, nonatomic) NSArray* articles;

@end

@implementation CTStoryViewController

- (NSArray*)articles {
    if (!_articles) {
        _articles = [[NSArray alloc] init];
    }
    return _articles;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    DDXMLDocument *xmlDoc = [[DDXMLDocument alloc]
                             initWithXMLString:
                             [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://feeds.bbci.co.uk/news/rss.xml"]
                                                      encoding:NSASCIIStringEncoding
                                                         error:nil]
                             options:DDXMLDocumentXMLKind
                             error:nil];
    
    NSArray *items = [xmlDoc nodesForXPath:@"/rss/channel/item" error:nil];
    
    NSMutableArray* tempStories = [[NSMutableArray alloc] init];
    
    for (DDXMLElement* item in items) {
        CTArticle *article = [[CTArticle alloc] init];
        article.title = [[[item nodesForXPath:@"title/text()" error:nil] objectAtIndex:0] stringValue];
        article.description = [[[item nodesForXPath:@"description/text()" error:nil] objectAtIndex:0] stringValue];
        article.url = [[[item nodesForXPath:@"link/text()" error:nil] objectAtIndex:0] stringValue];
        assert([[[item children][6] name] isEqualToString:@"media:thumbnail"]);
        article.imageURL = [[[item children][6] attributeForName:@"url"] stringValue];
        
        [tempStories addObject:article];
    }

    self.articles = [NSArray arrayWithArray:tempStories];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ArticleCell";
    CTStoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CTArticle *article = self.articles[indexPath.row];
    
    cell.storyTitle.text = article.title;
    cell.storyDetail.text = article.description;
    cell.storyImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:article.imageURL]]];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
