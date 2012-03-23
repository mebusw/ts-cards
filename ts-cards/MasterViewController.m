//
//  MasterViewController.m
//  ts-cards
//
//  Created by mebusw on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "TSCard.h"
#import "TSCardDao.h"

#define btnCancel   0
#define btnOK   1
@interface MasterViewController () {
    UITextField *numberField;
}
- (void) addButtonTapped:(id)sender;
@end

@implementation MasterViewController
@synthesize _objects, _searchResults;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonTapped:)];
    self.navigationItem.rightBarButtonItem = addButton;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning {
    [_objects removeAllObjects];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void) addButtonTapped:(id)sender {
    UIAlertView* dialog = [[UIAlertView alloc] init];
    [dialog setDelegate:self];

    NSLog(@"%@", [[NSBundle mainBundle] localizations]);
    NSLog(@"%@", [NSLocale preferredLanguages]);
    [dialog setTitle:NSLocalizedString(@"Enter Card Number", nil)];
    [dialog setMessage:@" "];
    [dialog addButtonWithTitle:NSLocalizedString(@"Cancel", nil)];
    [dialog addButtonWithTitle:NSLocalizedString(@"OK", nil)];
    
    numberField = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 45.0, 245.0, 25.0)];
    [numberField setBackgroundColor:[UIColor whiteColor]];
    numberField.keyboardType = UIKeyboardTypeNumberPad;
    
    [dialog addSubview:numberField];
    CGAffineTransform moveUp = CGAffineTransformMakeTranslation(0.0, -50.0);
    [dialog setTransform: moveUp];
    [dialog show];
    [numberField becomeFirstResponder];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (btnOK == buttonIndex) {
        [self insertNewCard:[numberField.text intValue]];
    }
}


-(void) insertNewCard:(int)number {
    TSCardDao *dao = [[TSCardDao alloc] init];
    
    
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    
    @try {
        TSCard *card = (TSCard*)[[dao selectByNumber:number] objectAtIndex:0];
        [_objects insertObject:card atIndex:0];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
    }
    @finally {
        
    }

    

}




#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return _objects.count;
    } else if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_searchResults count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    TSCard *card;
    if (tableView == self.tableView) {
        card = [_objects objectAtIndex:indexPath.row];
    } else if (tableView == self.searchDisplayController.searchResultsTableView) {
        card = [_searchResults objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = card.title;
    cell.detailTextLabel.text = card.number;

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
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        TSCard *card = [_searchResults objectAtIndex:[indexPath row]];
        
        [self insertNewCard:[card.number intValue]];

        [self.searchDisplayController setActive:NO animated:YES];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TSCard *object = [_objects objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - search view controller

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    TSCardDao *dao = [[TSCardDao alloc] init];
    if (![searchString isEqualToString:@""]) {
        _searchResults = [dao selectByTitle:searchString];
        NSLog(@"%@", _searchResults);
        return YES;
    }
    return NO;
}


@end
