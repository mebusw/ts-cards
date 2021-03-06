//
//  ts_cardsTests.m
//  ts-cardsTests
//
//  Created by mebusw on 12-3-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "constants.h"
#import "MasterVCTest.h"
#import "OCMock/OCMock.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "TSCard.h"
#import "TSCardDao.h"

@implementation MasterVCTest {
    MasterViewController *controller;
}

- (void)setUp
{
    [super setUp];
    
     controller = [[MasterViewController alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)test_commitEditingStyle_forRowAtIndexPath {
    NSIndexPath *dummyIndexPath = [NSIndexPath indexPathForRow:3 inSection:1];
    id tableViewMock = [OCMockObject mockForClass:[UITableView class]];
    [[tableViewMock expect] deleteRowsAtIndexPaths:[NSArray arrayWithObject:dummyIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [controller tableView:tableViewMock commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:dummyIndexPath];
    
    [tableViewMock verify];
}


- (void)test_cellForRowAtIndexPath {
    NSIndexPath *dummyIndexPath = [NSIndexPath indexPathForRow:3 inSection:1];
    id tableViewMock = [OCMockObject mockForClass:[UITableView class]];
    [[tableViewMock expect] dequeueReusableCellWithIdentifier:@"Cell"];
    
    [controller tableView:tableViewMock cellForRowAtIndexPath:dummyIndexPath];
    
    [tableViewMock verify];
}

- (void) test_insertNewCard {
    NSString *number = @"30";
    id tableViewMock = [OCMockObject partialMockForObject:controller.tableView];
    [[tableViewMock expect] insertRowsAtIndexPaths:[OCMArg any] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    TSCard *card = [[TSCard alloc] init];
    card.number = number;
    [controller insertNewCard:card];

    [tableViewMock verify];
    TSCard *card0 = [controller._objects objectAtIndex:0];
    STAssertEquals(1u, [controller._objects count], @"");
    STAssertEqualStr(number, card0.number, @"");
}

- (void) test_prepareForSegue {
    TSCard *card = [[TSCard alloc] init];
    controller._objects = [[NSMutableArray alloc] init];
    [controller._objects addObject:card];
    id segue = [OCMockObject mockForClass:[UIStoryboardSegue class]];
    [[[segue stub] andReturn:@"showDetail"] identifier]; 
    id destination = [OCMockObject mockForClass:[DetailViewController class]];
    [[[segue stub] andReturn:destination] destinationViewController];
    [[destination expect] setDetailItem:card];
    
    id tableViewMock = [OCMockObject partialMockForObject:controller.tableView];
    [[[tableViewMock stub] andReturn:0] indexPathForSelectedRow];
    
    
    [controller prepareForSegue:segue sender:nil];
    
    [destination verify];
   
}

-(void) test_actionButton_firstButtonWhenPurchased {
    id userDefaultsMock = [OCMockObject partialMockForObject:[NSUserDefaults standardUserDefaults]];
    BOOL isFullVersionUnlocked = YES;
    [[[userDefaultsMock expect] andReturnValue:OCMOCK_VALUE(isFullVersionUnlocked)] boolForKey:kFullVersionUnlocked]; 
    id controllerMock = [OCMockObject partialMockForObject:controller];
    [[controllerMock stub] appendAllCards];
    
    [controller actionSheet:[[UIActionSheet alloc] init] clickedButtonAtIndex:0];
    
    [userDefaultsMock verify];
    [controllerMock verify];
}


@end
