//
//  BasicLateOnsetSort.m
//
//  Created by Dominikus Baur on 2/3/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import "BasicLateOnsetSort.h"
#import "Layer.h"

@implementation BasicLateOnsetSort

-(NSString*) getName{
    return @"Late Onset Sorting, Top to Bottom";
}

-(NSArray*) sort:(NSArray*) layers{
    return [layers sortedArrayUsingComparator:^NSComparisonResult(id p, id q) {
        return 1 * (((Layer*)p).onset - ((Layer*)q).onset);
    }];
}

@end
