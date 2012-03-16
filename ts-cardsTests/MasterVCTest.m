//
//  ts_cardsTests.m
//  ts-cardsTests
//
//  Created by mebusw on 12-3-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MasterVCTest.h"
#import "OCMock/OCMock.h"
#import "MasterViewController.h"
#import "TSCard.h"
#import "TSCardDao.h"

@implementation MasterVCTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)test_commitEditingStyle_forRowAtIndexPath {
    MasterViewController *controller = [[MasterViewController alloc] init];
    NSIndexPath *dummyIndexPath = [NSIndexPath indexPathForRow:3 inSection:1];
    id tableViewMock = [OCMockObject mockForClass:[UITableView class]];
    [[tableViewMock expect] deleteRowsAtIndexPaths:[NSArray arrayWithObject:dummyIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [controller tableView:tableViewMock commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:dummyIndexPath];
    
    [tableViewMock verify];
}


- (void)test_cellForRowAtIndexPath {
    MasterViewController *controller = [[MasterViewController alloc] init];

    NSIndexPath *dummyIndexPath = [NSIndexPath indexPathForRow:3 inSection:1];
    id tableViewMock = [OCMockObject mockForClass:[UITableView class]];
    [[tableViewMock expect] dequeueReusableCellWithIdentifier:@"Cell"];
    
    [controller tableView:tableViewMock cellForRowAtIndexPath:dummyIndexPath];
    
    [tableViewMock verify];
}

- (void) test_insertNewObject {
    MasterViewController *controller = [[MasterViewController alloc] init];
    int number = 30;
    
    [controller viewDidLoad];
    [controller insertNewCard:number];
       
    TSCard *card = [controller._objects objectAtIndex:0];
    STAssertEquals(1u, [controller._objects count], @"");
    STAssertEquals(number, card.number, @"");
}

@end
