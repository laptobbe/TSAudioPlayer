//
// Created by Tobias Sundstrand on 14-09-08.
//

#import "TSTimeFormatter.h"


@implementation TSTimeFormatter

- (instancetype)initWithFormattingStyle:(TSTimeFormatterStyle)style {
    self = [super init];
    if(self) {
        _formattingStyle = style;
    }
    return self;
}

- (NSString *)formattedTimeFromTimeInterval:(NSTimeInterval)timeInterval {
    NSString *formattedSeconds = [self formattedSecondsFromTimeInterval:timeInterval];
    NSString *formattedMinutes = [self formattedMinutesFromTimeInterval:timeInterval];
    NSString *formattedHours = [self formattedHoursFromTimeInterval:timeInterval];
    NSMutableString *timeString = [NSMutableString new];
    if(formattedHours) {
        [timeString appendFormat:@"%@:",formattedHours];
    }
    if(formattedMinutes) {
        [timeString appendFormat:@"%@:", formattedMinutes];
    }
    if(formattedSeconds) {
        [timeString appendString:formattedSeconds];
    }

    return timeString;
}

- (NSString *)formattedSecondsFromTimeInterval:(NSTimeInterval)interval {
    int seconds = (int)interval % 60;
    switch(self.formattingStyle) {
        case TSTimeFormatterShortStyle:
            return [NSString stringWithFormat:@"%d", seconds];
        case TSTimeFormatterAdoptiveStyle:
        case TSTimeFormatterFullStyle:
        default:
            return [NSString stringWithFormat:@"%02d", seconds];

    }
}

- (NSString *)formattedMinutesFromTimeInterval:(NSTimeInterval)timeInterval {
    int minutes = ((int) timeInterval / 60) % 60 ;
    switch(self.formattingStyle) {

        case TSTimeFormatterShortStyle:
            return [NSString stringWithFormat:@"%d", minutes];
        case TSTimeFormatterAdoptiveStyle:
            if(timeInterval < 60) {
                return nil;
            }
        case TSTimeFormatterFullStyle:
        default:
            return [NSString stringWithFormat:@"%02d", minutes];

    }
}

- (NSString *)formattedHoursFromTimeInterval:(NSTimeInterval)timeInterval {
    int hours = (int) timeInterval / 3600;
    switch(self.formattingStyle) {

        case TSTimeFormatterShortStyle:
            return [NSString stringWithFormat:@"%d", hours];
        case TSTimeFormatterAdoptiveStyle:
            if(timeInterval < 3600) {
                return nil;
            }
        case TSTimeFormatterFullStyle:
        default:
            return [NSString stringWithFormat:@"%02d", hours];

    }
}
@end