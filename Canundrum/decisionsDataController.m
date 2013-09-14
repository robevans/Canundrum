//
//  decisionsDataController.m
//  Canundrum
//
//  Created by Robert Evans on 27/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import "decisionsDataController.h"
#import "decision.h"

@interface decisionsDataController ()
//- (void)initializeDefaultDataList;
@end

@implementation decisionsDataController

@synthesize masterDecisionsList=_masterDecisionsList;

- (id)init {
    if (self = [super init]) {
        return self;
    }
    return nil;
}

- (NSMutableArray *)masterDecisionsList {
    if (!_masterDecisionsList) {
        _masterDecisionsList = [[NSMutableArray alloc] init];
    }
    return _masterDecisionsList;
}

- (void)setMasterDecisionsList:(NSMutableArray *)newList {
    if (self.masterDecisionsList != newList) {
        _masterDecisionsList = newList;
    }
}

- (NSUInteger)countOfList {
    return [self.masterDecisionsList count];
}

- (decision *)objectInListAtIndex:(NSUInteger)theIndex {
    return [self.masterDecisionsList objectAtIndex:theIndex];
}

- (void)addDecision:(decision *)decision{
    [self.masterDecisionsList insertObject:[decision mutableCopy] atIndex:0];
}

@end
