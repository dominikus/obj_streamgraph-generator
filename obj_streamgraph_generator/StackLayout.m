//
//  StackLayout.m
//
//  Created by Dominikus Baur on 2/3/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import "StackLayout.h"
#import "Layer.h"

@implementation StackLayout

-(NSString*)getName{
    return @"Stacked Layout";
}

-(void)layout:(NSArray*)layers{
    int n = ((Layer*)[layers objectAtIndex:0]).size.count;
    
    // lay out layers, top to bottom.
    NSMutableArray* baseline = [[NSMutableArray alloc] initWithCapacity:n];
    for(int i = 0; i < n; i++){
        [baseline addObject:[NSNumber numberWithFloat:0]];
    }
    
    // Put layers on top of the baseline.
    [self stackOnBaseline:layers AndBaseline:baseline];
}

@end
