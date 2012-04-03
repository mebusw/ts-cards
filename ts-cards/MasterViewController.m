//
//  MasterViewController.m
//  ts-cards
//
//  Created by mebusw on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "GADBannerView.h"

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "TSCard.h"
#import "TSCardDao.h"

#define btnCancel   0
#define btnOK   1
#define GAD_PUBLISHER_ID @"a14f791eb38987e"

@interface MasterViewController () {
    UITextField *numberField;
    GADBannerView *gAdBanner;
}


@end

@implementation MasterViewController
@synthesize _objects, _searchResults;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)addNavButtons
{
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionButtonTapped:)];
    self.navigationItem.rightBarButtonItem = actionButton;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addNavButtons];
    [self addGAD];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    gAdBanner.delegate = nil;

}

- (void)didReceiveMemoryWarning {
    [_objects removeAllObjects];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Action Button


- (void) actionButtonTapped:(id)sender {
    UIActionSheet *actions = [[UIActionSheet alloc] initWithTitle:STR(NSLocalizedString(@"Only Avaliable in Full Version", nil)) delegate:self cancelButtonTitle:STR(NSLocalizedString(@"Cancel", nil)) destructiveButtonTitle:nil otherButtonTitles:STR(NSLocalizedString(@"Remove All Results", nil)), STR(NSLocalizedString(@"Add All Cards", nil)), nil];
    [actions showInView:self.view];
    
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
        
        [self insertNewCard:card];

        [self.searchDisplayController setActive:NO animated:YES];
    }
}

-(void) insertNewCard:(TSCard*)card {   
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    
    @try {
        [_objects insertObject:card atIndex:0];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
    }
    @finally {
        
    }
    
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TSCard *object = [_objects objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Search view controller

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    TSCardDao *dao = [[TSCardDao alloc] init];
    if (![searchString isEqualToString:@""]) {
        _searchResults = [dao selectByTitleOrNumber:searchString];
        DLog(@"%@", _searchResults);
        return YES;
    }
    return NO;
}

#pragma mark - Google Ad
-(void) addGAD {
    gAdBanner = [[GADBannerView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height, GAD_SIZE_320x50.width, GAD_SIZE_320x50.height)];
    gAdBanner.adUnitID = GAD_PUBLISHER_ID;
    gAdBanner.delegate = (id)self;
    [gAdBanner setRootViewController:self.navigationController];
    [self.navigationController.view addSubview:gAdBanner];
    
    GADRequest *request = [GADRequest request];

    /*Make the request for a test ad*/
    //request.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID, nil];
    [gAdBanner loadRequest:request];
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    [UIView beginAnimations:@"BannerSlide" context:nil];
    bannerView.frame = CGRectMake(0.0,
                                  self.navigationController.view.frame.size.height -
                                  bannerView.frame.size.height,
                                  bannerView.frame.size.width,
                                  bannerView.frame.size.height);
    [UIView commitAnimations];
    DLog(@"gAd: hasAutoRefreshed=%d", [bannerView hasAutoRefreshed]);
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"gAd: adView:didFailToReceiveAdWithError:%@", [error localizedDescription]);

}




@end
