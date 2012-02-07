//
//  LateOnsetSort.m
//
//  Created by Dominikus Baur on 2/3/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import "LateOnsetSort.h"
#import "Layer.h"

@implementation LateOnsetSort

-(NSString*)getName{
    return @"Late Onset Sorting, Evenly Weighted";
}

-(NSArray*) sort:(NSArray*) layers{
    layers = [layers sortedArrayUsingComparator:^NSComparisonResult(id p, id q) {
        return 1 * (((Layer*)p).onset - ((Layer*)q).onset);
    }];
    
    return [self orderToOutside:layers];
}

@end
