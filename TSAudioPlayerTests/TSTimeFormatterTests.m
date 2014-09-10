//
//  TSTimeFormatterTests.m
//  TSAudioPlayer
//
//  Created by Tobias Sundstrand on 14-09-08.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TSTimeFormatter.h"

@interface TSTimeFormatterTests : XCTestCase

@property TSTimeFormatter *formatter;

@end

@implementation TSTimeFormatterTests

- (void)setUp {
    [super setUp];
    self.formatter = [TSTimeFormatter new];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSecondFormattingShortStyle{
    self.formatter.formattingStyle = TSTimeFormatterShortStyle;
    NSString *formatted = [self.formatter formattedSecondsFromTimeInterval:7];
    XCTAssertEqualObjects(formatted, @"7");
}

- (void)testSecondFormattingFullStyle {
    self.formatter.formattingStyle= TSTimeFormatterFullStyle;
    NSString *formatted = [self.formatter formattedSecondsFromTimeInterval:7];
    XCTAssertEqualObjects(formatted, @"07");
}

- (void)testSecondFormattingAdoptiveStyle {
    self.formatter.formattingStyle = TSTimeFormatterAdoptiveStyle;
    NSString *formatted = [self.formatter formattedSecondsFromTimeInterval:7];
    XCTAssertEqualObjects(formatted, @"07");
}

- (void)testSecondsMoreThenOneMinute {
    self.formatter.formattingStyle = TSTimeFormatterFullStyle;
    NSString *formatted = [self.formatter formattedSecondsFromTimeInterval:96];
    XCTAssertEqualObjects(formatted, @"36");
}

- (void)testMinutesFormattingStyleShortLessThenMinute {
    self.formatter.formattingStyle = TSTimeFormatterShortStyle;
    NSString *formatted = [self.formatter formattedMinutesFromTimeInterval:7];
    XCTAssertEqualObjects(formatted, @"0");
}

- (void)testMinutesFormattingFullStyleLessThenMinute {
    self.formatter.formattingStyle = TSTimeFormatterFullStyle;
    NSString *formatted = [self.formatter formattedMinutesFromTimeInterval:7];
    XCTAssertEqualObjects(formatted, @"00");
}

- (void)testMinutesFormattingLessThenMinute {
    self.formatter.formattingStyle = TSTimeFormatterAdoptiveStyle;
    NSString *formatted = [self.formatter formattedMinutesFromTimeInterval:7];
    XCTAssertNil(formatted);
}

- (void)testMinutesFormattingStyleShortMoreThenMinute {
    self.formatter.formattingStyle = TSTimeFormatterShortStyle;
    NSString *formatted = [self.formatter formattedMinutesFromTimeInterval:96];
    XCTAssertEqualObjects(formatted, @"1");
}

- (void)testMinutesFormattingFullStyleMoreThenMinute {
    self.formatter.formattingStyle = TSTimeFormatterFullStyle;
    NSString *formatted = [self.formatter formattedMinutesFromTimeInterval:96];
    XCTAssertEqualObjects(formatted, @"01");
}

- (void)testMinutesFormattingMoreThenMinute {
    self.formatter.formattingStyle = TSTimeFormatterAdoptiveStyle;
    NSString *formatted = [self.formatter formattedMinutesFromTimeInterval:96];
    XCTAssertEqualObjects(formatted, @"01");
}

- (void)testMinutesFormattingStyleShortMoreThenHour {
    self.formatter.formattingStyle = TSTimeFormatterShortStyle;
    NSString *formatted = [self.formatter formattedMinutesFromTimeInterval:4000];
    XCTAssertEqualObjects(formatted, @"6");
}

- (void)testMinutesFormattingFullStyleMoreThenHour {
    self.formatter.formattingStyle = TSTimeFormatterFullStyle;
    NSString *formatted = [self.formatter formattedMinutesFromTimeInterval:4000];
    XCTAssertEqualObjects(formatted, @"06");
}

- (void)testMinutesFormattingAdoptiveMoreThenHour {
    self.formatter.formattingStyle = TSTimeFormatterAdoptiveStyle;
    NSString *formatted = [self.formatter formattedMinutesFromTimeInterval:4000];
    XCTAssertEqualObjects(formatted, @"06");
}

- (void)testHoursFormattingStyleShortLessThenMinute {
    self.formatter.formattingStyle = TSTimeFormatterShortStyle;
    NSString *formatted = [self.formatter formattedHoursFromTimeInterval:7];
    XCTAssertEqualObjects(formatted, @"0");
}

- (void)testHourssFormattingFullStyleLessThenMinute {
    self.formatter.formattingStyle = TSTimeFormatterFullStyle;
    NSString *formatted = [self.formatter formattedHoursFromTimeInterval:7];
    XCTAssertEqualObjects(formatted, @"00");
}

- (void)testHoursFormattingLessThenMinute {
    self.formatter.formattingStyle = TSTimeFormatterAdoptiveStyle;
    NSString *formatted = [self.formatter formattedHoursFromTimeInterval:7];
    XCTAssertNil(formatted);
}

- (void)testHoursFormattingStyleShortMoreThenMinute {
    self.formatter.formattingStyle = TSTimeFormatterShortStyle;
    NSString *formatted = [self.formatter formattedHoursFromTimeInterval:96];
    XCTAssertEqualObjects(formatted, @"0");
}

- (void)testHoursFormattingFullStyleMoreThenMinute {
    self.formatter.formattingStyle = TSTimeFormatterFullStyle;
    NSString *formatted = [self.formatter formattedHoursFromTimeInterval:96];
    XCTAssertEqualObjects(formatted, @"00");
}

- (void)testHoursFormattingMoreThenMinute {
    self.formatter.formattingStyle = TSTimeFormatterAdoptiveStyle;
    NSString *formatted = [self.formatter formattedHoursFromTimeInterval:96];
    XCTAssertNil(formatted);
}

- (void)testHoursFormattingStyleShortMoreThenHour {
    self.formatter.formattingStyle = TSTimeFormatterShortStyle;
    NSString *formatted = [self.formatter formattedHoursFromTimeInterval:4000];
    XCTAssertEqualObjects(formatted, @"1");
}

- (void)testHoursFormattingFullStyleMoreThenHour {
    self.formatter.formattingStyle = TSTimeFormatterFullStyle;
    NSString *formatted = [self.formatter formattedHoursFromTimeInterval:4000];
    XCTAssertEqualObjects(formatted, @"01");
}

- (void)testHoursFormattingAdoptiveMoreThenHour {
    self.formatter.formattingStyle = TSTimeFormatterAdoptiveStyle;
    NSString *formatted = [self.formatter formattedHoursFromTimeInterval:4000];
    XCTAssertEqualObjects(formatted, @"01");
}

- (void)testHoursFormattingAdoptiveMoreThen60Hours {
    self.formatter.formattingStyle = TSTimeFormatterAdoptiveStyle;
    NSString *formatted = [self.formatter formattedHoursFromTimeInterval:219600];
    XCTAssertEqualObjects(formatted, @"61");
}

- (void)testHoursFormattingShorteMoreThen60Hours {
    self.formatter.formattingStyle = TSTimeFormatterShortStyle;
    NSString *formatted = [self.formatter formattedHoursFromTimeInterval:219600];
    XCTAssertEqualObjects(formatted, @"61");
}

- (void)testHoursFormattingFullMoreThen60Hours {
    self.formatter.formattingStyle = TSTimeFormatterAdoptiveStyle;
    NSString *formatted = [self.formatter formattedHoursFromTimeInterval:219600];
    XCTAssertEqualObjects(formatted, @"61");
}

- (void)testCompleteFormattingStyleShortLessThenMinute {
    self.formatter.formattingStyle = TSTimeFormatterShortStyle;
    NSString *formatted = [self.formatter formattedTimeFromTimeInterval:7];
    XCTAssertEqualObjects(formatted, @"0:0:7");
}

- (void)testCompleteFormattingFullStyleLessThenMinute {
    self.formatter.formattingStyle = TSTimeFormatterFullStyle;
    NSString *formatted = [self.formatter formattedTimeFromTimeInterval:7];
    XCTAssertEqualObjects(formatted, @"00:00:07");
}

- (void)testCompleteFormattingAdoptiveLessThenMinute {
    self.formatter.formattingStyle = TSTimeFormatterAdoptiveStyle;
    NSString *formatted = [self.formatter formattedTimeFromTimeInterval:7];
    XCTAssertEqualObjects(formatted, @"07");
}

- (void)testCompleteFormattingStyleShortMoreThenMinute {
    self.formatter.formattingStyle = TSTimeFormatterShortStyle;
    NSString *formatted = [self.formatter formattedTimeFromTimeInterval:96];
    XCTAssertEqualObjects(formatted, @"0:1:36");
}

- (void)testCompleteFormattingFullStyleMoreThenMinute {
    self.formatter.formattingStyle = TSTimeFormatterFullStyle;
    NSString *formatted = [self.formatter formattedTimeFromTimeInterval:96];
    XCTAssertEqualObjects(formatted, @"00:01:36");
}

- (void)testCompleteFormattingAdoptiveMoreThenMinute {
    self.formatter.formattingStyle = TSTimeFormatterAdoptiveStyle;
    NSString *formatted = [self.formatter formattedTimeFromTimeInterval:96];
    XCTAssertEqualObjects(formatted, @"01:36");
}

- (void)testCompleteFormattingStyleShortMoreThenHour {
    self.formatter.formattingStyle = TSTimeFormatterShortStyle;
    NSString *formatted = [self.formatter formattedTimeFromTimeInterval:4000];
    XCTAssertEqualObjects(formatted, @"1:6:40");
}

- (void)testCompleteFormattingFullStyleMoreThenHour {
    self.formatter.formattingStyle = TSTimeFormatterFullStyle;
    NSString *formatted = [self.formatter formattedTimeFromTimeInterval:4000];
    XCTAssertEqualObjects(formatted, @"01:06:40");
}

- (void)testCompleteFormattingNoMoreThenHour {
    self.formatter.formattingStyle = TSTimeFormatterAdoptiveStyle;
    NSString *formatted = [self.formatter formattedTimeFromTimeInterval:4000];
    XCTAssertEqualObjects(formatted, @"01:06:40");
}

@end
