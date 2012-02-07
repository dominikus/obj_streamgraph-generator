//
//  VolatilitySort.m
//
//  Created by Dominikus Baur on 2/3/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import "VolatilitySort.h"
#import "Layer.h"

@implementation VolatilitySort : LayerSort

-(NSString*) getName{
    return @"Volatility Sorting, Evenly Weighted";
}

-(NSArray*) sort:(NSArray*) layers {
    layers = [layers sortedArrayUsingComparator:^NSComparisonResult(id p, id q) {
        float volatilityDifference = ((Layer*)p).volatility - ((Layer*)q).volatility;
        return 1 * (10000000 * volatilityDifference);
    }];
    
    return [self orderToOutside:layers];
}

@end
