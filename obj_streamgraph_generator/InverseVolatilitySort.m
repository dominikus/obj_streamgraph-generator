//
//  InverseVolatilitySort.m
//
//  Created by Dominikus Baur on 2/3/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import "InverseVolatilitySort.h"
#import "Layer.h"

@implementation InverseVolatilitySort

-(NSString*)getName{
    return @"Inverse Volatility Sorting, Evenly Weighted";
}

-(NSArray*) sort:(NSArray*) layers {
    // first sort by volatility
    layers = [layers sortedArrayUsingComparator:^NSComparisonResult(id p, id q) {
        float volatilityDifference = ((Layer*)p).volatility - ((Layer*)q).volatility;
        return -1 * (10000000 * volatilityDifference);
    }];
    
    return [self orderToOutside:layers];    
}

@end
