//
//  ThemeRiverLayout.m
//
//  Created by Dominikus Baur on 2/3/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import "ThemeRiverLayout.h"
#import "Layer.h"

@implementation ThemeRiverLayout

-(NSString*)getName{
    return @"ThemeRiver";
}

-(void)layout:(NSArray *)layers{
    // Set shape of baseline values.
    int n = ((Layer*)[layers objectAtIndex:0]).size.count;
    int m = layers.count;
    NSMutableArray* baseline = [[NSMutableArray alloc] initWithCapacity:n];
    for(int i = 0; i < n; i++){
        [baseline addObject:[NSNumber numberWithFloat:0]];
    }
    
    // ThemeRiver is perfectly symmetrical
    // the baseline is 1/2 of the total height at any point
    for (int i = 0; i < n; i++) {
        [baseline replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:0]];
        for (int j = 0; j < m; j++) {
            float nuvalue = [[baseline objectAtIndex:i] floatValue];
            nuvalue += [[((Layer*)[layers objectAtIndex:j]).size objectAtIndex:i] floatValue];
            [baseline replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:nuvalue]];
        }
        [baseline replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:([[baseline objectAtIndex:i] floatValue] * 0.5f)]];
    }
    
    // Put layers on top of the baseline.
    [self stackOnBaseline:layers AndBaseline:baseline];
}

@end
