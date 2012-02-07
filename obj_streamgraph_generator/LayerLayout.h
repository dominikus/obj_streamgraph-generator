//
//  LayerLayout.h
//
//  Created by Dominikus Baur on 2/3/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import <Foundation/Foundation.h>

@interface LayerLayout : NSObject

-(void)layout:(NSArray*)layers;
-(NSString*)getName;

-(void)stackOnBaseline:(NSArray*)layers AndBaseline:(NSArray*)baseline;

@end
