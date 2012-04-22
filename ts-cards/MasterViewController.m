//
//  MasterViewController.m
//  ts-cards
//
//  Created by mebusw on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "GADBannerView.h"

#import "constants.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "TSCard.h"
#import "TSCardDao.h"



@interface MasterViewController () {
    UITextField *numberField;
    GADBannerView *gAdBanner;
    UIActivityIndicatorView *_indicator;
}


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
    [self addNavButtons];
    [self addGAD];
    [self addIndicator];

    // it is not proper to automatic restore, because it will ask user input password even for a new install
    //[self restorePurchasedProducts];
}

-(void) addIndicator {
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _indicator.frame = CGRectMake(120.0f, 120.0f, 57.0f, 57.0f);
    _indicator.color = [UIColor blueColor];
    [self.view addSubview:_indicator];   
}

- (void)addNavButtons
{
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    

    UIBarButtonItem *actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionButtonTapped:)];
    self.navigationItem.rightBarButtonItem = actionButton;
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
    bool isFullVersionUnlocked = [[NSUserDefaults standardUserDefaults] boolForKey:kFullVersionUnlocked];
    
    if (isFullVersionUnlocked) {
        UIActionSheet *actions = [[UIActionSheet alloc] initWithTitle:I18N(@"You've unlocked Full Version") delegate:self cancelButtonTitle:I18N(@"Cancel") destructiveButtonTitle:nil otherButtonTitles:I18N(@"Add All Cards"), I18N(@"Remove All Collections"), nil];
        [actions showInView:self.view];
    } else {
        UIActionSheet *actions = [[UIActionSheet alloc] initWithTitle:I18N(@"Unlock Full Version for more functions") delegate:self cancelButtonTitle:I18N(@"Cancel") destructiveButtonTitle:I18N(@"Unlock Full Version") otherButtonTitles:nil];
        [actions showInView:self.view];
    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    DLog(@"buttonIndex = %d", buttonIndex);
    bool isFullVersionUnlocked = [[NSUserDefaults standardUserDefaults] boolForKey:kFullVersionUnlocked];
    
    if (isFullVersionUnlocked) {
        switch (buttonIndex) {
            case btnAppendAllCards:
                [self appendAllCards];
                break;
            case btnClearAllCollections:
                [self clearAllCollections];
                break;
            default:
                break;
        }
    } else {
        if (btnUnlockFullVersion == buttonIndex) {
            if ([SKPaymentQueue canMakePayments]) {
                [self requestProductData];
            } else {
                UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:I18N(@"Alert") message:I18N(@"You disabled to purchase in app store") delegate:nil cancelButtonTitle:I18N(@"OK") otherButtonTitles:nil];    
                [alerView show];
            }
        }
    }
    
}


#pragma mark - In-App Purchase
- (void) restorePurchasedProducts {
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void) requestProductData {
    SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:
                                 [NSSet setWithObjects:PRODUCT_ID_FULL_VERSION, nil]];
    request.delegate = (id)self;
    [_indicator startAnimating];
    [request start];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *myProducts = response.products;
    
    DLog(@"product count=%d", [myProducts count]);
    [_indicator stopAnimating];
    
    /*     DLog(@"invalid products: %@", response.invalidProductIdentifiers);
     
     for(SKProduct *product in myProducts){
     DLog(@"product info");
     DLog(@"desc= %@", [product description]);
     DLog(@"title= %@" , product.localizedTitle);
     DLog(@"desc of error= %@" , product.localizedDescription);
     DLog(@"price= %@" , product.price);
     DLog(@"Product id= %@" , product.productIdentifier);
     }
     */
    
    // Populate your UI from the products list.
    // Save a reference to the products list.
    
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:(id)self];  
    @try {
        SKProduct *selectedProduct = [myProducts objectAtIndex:0];
        SKPayment *payment = [SKPayment paymentWithProduct:selectedProduct];
        //payment.quantity = 1;
        [[SKPaymentQueue defaultQueue] addPayment:payment];
        
    }
    @catch (NSException *exception) {
        DLog(@"exception when add payment %@", [exception reason]);
    }
}

-(void) request:(SKRequest*)request didFailWithError:(NSError *)error {
    ELog(@"%@", [error localizedDescription]);
    [_indicator stopAnimating];
    UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:I18N(@"Alert") message:I18N(@"Can't connect to iTunes") delegate:nil cancelButtonTitle:I18N(@"OK") otherButtonTitles:nil];    
    [alerView show];
}

-(void) requestDidFinish:(SKRequest*)request {
    DLog(@"");
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        DLog(@"%d", transaction.transactionState);
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                break;
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    }
}

- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
    // Your application should implement these two methods.
    [self recordTransaction:transaction];
    [self provideContent:transaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}


- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
    [self recordTransaction: transaction];
    [self provideContent: transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];

}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled) {
        ELog(@"Failed to make transaction: %@", transaction.error.localizedDescription);
        UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:I18N(@"Alert") message:I18N(@"Failed to make transaction") delegate:nil cancelButtonTitle:I18N(@"OK") otherButtonTitles:nil];    
        [alerView show];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

-(void) recordTransaction: (SKPaymentTransaction *)transaction {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kFullVersionUnlocked];
}

-(void) provideContent:(NSString*) productId {
    DLog(@"%@", productId);
}

-(void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue*)queue {
    DLog(@"");
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return I18N(@"My Collections");
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
   
}

-(void) clearAllCollections {
    [_objects removeAllObjects];
    [self.tableView reloadData];
}

-(void) appendAllCards {

    @try {
        NSArray *allCards = [[[TSCardDao alloc] init] selectAll];
        _objects = [NSMutableArray arrayWithArray:allCards];
        [self.tableView reloadData];
    }
    @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
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
    
    /* Make the request for a test ad when running on simulator */
    request.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID, nil];
    
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
    DLog(@"gAd: adView:didFailToReceiveAdWithError:%@", [error localizedDescription]);
    
}





@end
