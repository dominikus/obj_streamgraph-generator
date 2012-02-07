//
//  ColorPicker.h
//
//  Created by Dominikus Baur on 2/3/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import <Foundation/Foundation.h>

@protocol ColorPicker <NSObject>

-(void) colorize:(NSArray*) layers;
-(NSString*) getName;

@end
