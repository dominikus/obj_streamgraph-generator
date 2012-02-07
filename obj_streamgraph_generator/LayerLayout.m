//
//  LayerLayout.m
//
//  Created by Dominikus Baur on 2/3/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import "LayerLayout.h"
#import "Layer.h"

@implementation LayerLayout

/**
 *  abstract
 */
-(void)layout:(NSArray*)layers{
}

/**
 *  abstract
 */
-(NSString*)getName{
    return @"";
}

/**
 * We define our stacked graphs by layers atop a baseline.
 * This method does the work of assigning the positions of each layer in an
 * ordered array of layers based on an initial baseline.
 */
-(void)stackOnBaseline:(NSArray*)layers AndBaseline:(NSMutableArray*)baseline{    
    // Put layers on top of the baseline.
    for (int i = 0; i < layers.count; i++) {
        Layer* l = [layers objectAtIndex:i];
        l.yBottom = [[NSMutableArray alloc] initWithArray:baseline];
        for(int j = 0; j < baseline.count; j++){
            float nuvalue = [[baseline objectAtIndex:j] floatValue] - [[l.size objectAtIndex:j] floatValue];
            [baseline replaceObjectAtIndex:j withObject:[NSNumber numberWithFloat:nuvalue]];
        }
        l.yTop = [[NSMutableArray alloc] initWithArray:baseline];
    }
}

@end
