//
//  MinimizedWiggleLayout.m
//
//  Created by Dominikus Baur on 2/3/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import "MinimizedWiggleLayout.h"
#import "Layer.h"

@implementation MinimizedWiggleLayout

-(NSString*)getName{
    return @"Minimized Wiggle Layout";
}

-(void)layout:(NSArray*)layers{
    int n = ((Layer*)[layers objectAtIndex:0]).size.count;
    int m = layers.count;
    NSMutableArray* baseline = [[NSMutableArray alloc] initWithCapacity:n];
    for(int i = 0; i < n; i++){
        [baseline addObject:[NSNumber numberWithFloat:0]];
    }
    
    // Set shape of baseline values.
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            float nuvalue = [[baseline objectAtIndex:i] floatValue];
            nuvalue += (m - j - 0.5f) * [[((Layer*)[layers objectAtIndex:j]).size objectAtIndex:i] floatValue];
            [baseline replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:nuvalue]];
        }
        [baseline replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:([[baseline objectAtIndex:i] floatValue] / m)]];
    }

    // Put layers on top of the baseline.
    [self stackOnBaseline:layers AndBaseline:baseline];
}

@end
