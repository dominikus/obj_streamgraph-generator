//
//  NoLayerSort.m
//
//  Created by Dominikus Baur on 2/3/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import "NoLayerSort.h"

@implementation NoLayerSort

-(NSString*)getName{
    return @"No Sorting";
}

-(NSArray*) sort:(NSArray*) layers {
    return layers;
}

@end
