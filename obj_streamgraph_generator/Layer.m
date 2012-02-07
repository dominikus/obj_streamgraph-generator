//
//  Layer.m
//
//  Created by Dominikus Baur on 2/3/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import "Layer.h"
#import "stream_util.h"

@implementation Layer

@synthesize name;
@synthesize size;
@synthesize yBottom;
@synthesize yTop;
@synthesize rgb;
@synthesize onset;
@synthesize end;
@synthesize sum;
@synthesize volatility;

-(id)initWithName:(NSString*)n AndArray:(NSArray*)siz {
    self = [super init];
    
    for(int i = 0; i < siz.count; i++){
        if([siz objectAtIndex:i] < 0){
            [NSException raise:@"No negative sizes allowed." format:@""];
        }
    }
    
    self.name = n;
    self.size = siz;
    self.yBottom = [[NSMutableArray alloc] initWithCapacity:size.count];
    for(int i = 0; i < size.count; i++){
        [self.yBottom addObject:[NSNumber numberWithFloat:0]];
    }
    self.yTop = [[NSMutableArray alloc] initWithCapacity:size.count];
    for(int i = 0; i < size.count; i++){
        [self.yTop addObject:[NSNumber numberWithFloat:0]];
    }
    self.sum = 0;
    self.volatility = 0;
    self.onset = -1;
    
    self.rgb = [UIColor whiteColor];
    
    for(int i = 0; i < siz.count; i++){
        // sum is the summation of all points
        self.sum = self.sum + [[siz objectAtIndex:i] floatValue];
        
        // onset is the first non-zero point
        // end is the last non-zero point
        if([[siz objectAtIndex:i] floatValue] > 0){
            if (self.onset == -1) {
                self.onset = i;
            } else {
                self.end = i;
            }
        }
        
        // volatility is the maximum change between any two consecutive points
        if (i > 0) {
            self.volatility = maxf(self.volatility, absf([[siz objectAtIndex:i] floatValue] - [[siz objectAtIndex:(i-1)] floatValue]));
        }
    }
    
    return self;
}

@end
