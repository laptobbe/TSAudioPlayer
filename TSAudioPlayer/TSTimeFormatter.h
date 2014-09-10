//
// Created by Tobias Sundstrand on 14-09-08.
//

#import <Foundation/Foundation.h>

typedef enum {
    TSTimeFormatterAdoptiveStyle,
    TSTimeFormatterShortStyle,
    TSTimeFormatterFullStyle
} TSTimeFormatterStyle;

@interface TSTimeFormatter : NSObject

@property (assign) TSTimeFormatterStyle formattingStyle;

- (instancetype)initWithFormattingStyle:(TSTimeFormatterStyle)style;

- (NSString *)formattedTimeFromTimeInterval:(NSTimeInterval)timeInterval;

- (NSString *)formattedSecondsFromTimeInterval:(NSTimeInterval)interval;

- (NSString *)formattedMinutesFromTimeInterval:(NSTimeInterval)timeInterval;

- (NSString *)formattedHoursFromTimeInterval:(NSTimeInterval)timeInterval;
@end