//
//  decision.m
//  Canundrum
//
//  Created by Robert Evans on 27/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import "decision.h"
#import "option.h"

@interface decision ()
    -(void)sortOptionsList;
@end

@implementation decision

@synthesize sortedOptionsList = _sortedOptionsList;

-(void)sortOptionsList
{
    NSComparator compareOptions = ^(option * a, option * b) {
        double aScore = [self percentageScoreOfoption:a];
        double bScore = [self percentageScoreOfoption:b];
        return aScore < bScore ? NSOrderedDescending
        : aScore > bScore ? NSOrderedAscending
        : NSOrderedSame;
    };
    _sortedOptionsList = [_sortedOptionsList sortedArrayUsingComparator:compareOptions].mutableCopy;
}

-(NSMutableArray *)sortedOptionsList
{
    [self sortOptionsList];
    return _sortedOptionsList;
}

-(void)setSortedOptionsList:(NSMutableArray *)optionsList
{
    _sortedOptionsList = optionsList;
    [self sortOptionsList];
}

-(double)percentageScoreOfoption:(option *)option
{
    NSAssert(self.weightingsList.count == option.attributeScores.count, @"FATAL: Number of attributes does not match number of attribute scores");
    
    double maxScore = ((NSNumber *)[self.weightingsList valueForKeyPath:@"@sum.self"]).doubleValue;
    
    double score = 0.0;
    for (int i = 0; i < self.weightingsList.count; i++) {
        score += ((NSNumber *)self.weightingsList[i]).doubleValue * ((NSNumber *)option.attributeScores[i]).doubleValue;
    }
    
    double percentageScore = 100*score/maxScore;
    NSLog(@"Scored option %@ %lf%%",option.name,percentageScore);
    
    return percentageScore;
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    decision *copy = [[decision alloc] init];
    copy.attributesList = [[NSMutableArray alloc] initWithArray:_attributesList copyItems:YES];
    copy.weightingsList = [[NSMutableArray alloc] initWithArray:_weightingsList copyItems:YES];
    copy.sortedOptionsList = [[NSMutableArray alloc] initWithArray:_sortedOptionsList copyItems:YES];
    copy.name = [_name mutableCopyWithZone: zone];
    
    return copy;
}

@end
