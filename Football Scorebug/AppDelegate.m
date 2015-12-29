//
//  AppDelegate.m
//  Football Scorebug
//
//  Created by Andrew Shackelford on 5/9/15.
//  Copyright (c) 2015 Andrew Shackelford. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()


@property (weak) IBOutlet NSWindow *window;

@end

@implementation AppDelegate

NSTimer *replayTimer;
NSTimer *resetTimer;

bool replayDone;

bool timeoutShowing;
bool touchdownShowing;
bool flagShowing;
bool replayShowing;
bool clockShowing;
bool downShowing;
bool scorebugShowing;
bool locatorShowing;
bool scoreboardShowing;

bool validSeeds;

int homeScore;
int awayScore;
int quarter;
int timeSeconds;
int down;
int distance;
int awaySeed;
int homeSeed;

bool andGoal;
bool justDown;

bool optText;

bool clockRunning;

NSTimer *clockTimer;

NSColor *blue;
NSColor *red;
NSColor *yellow;
NSColor *green;
NSColor *black;

NSString *homeName;
NSString *awayName;

NSString *homeRecord;
NSString *awayRecord;

NSString *location;

NSString *replayHide;

NSString *dateText;

NSString *optionalText;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [_displayWindow close];
    
    // Insert code here to initialize your application
    [self setStartingValues];
    [_displayWindow setCollectionBehavior:NSWindowCollectionBehaviorFullScreenPrimary];
    [_controlWindow makeKeyAndOrderFront:self];
    [_displayWindow setFrame:NSMakeRect(100.f, 100.f, 640.f, 480.f) display:YES animate:NO];
    [_displayWindow makeKeyAndOrderFront:self]; 
    
    validSeeds = false;
    
    NSDateFormatter *fullDate = [[NSDateFormatter alloc] init];
    [fullDate setDateFormat:@"LLLL d, y"];
    dateText = [fullDate stringFromDate:[NSDate date]];
    
    scoreboardShowing = true;
    [self concealScoreboard];
    scoreboardShowing = false;
    
    replayShowing = true;
    //[self showReplay:self];
    [_replayImage setHidden:YES];
    replayShowing = false;
    
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Enter in the away name below"];
    [alert addButtonWithTitle:@"Ok"];
    NSTextField *input = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 24)];
    [input setStringValue:@""];
    [alert setAccessoryView:input];
    NSInteger button = [alert runModal];
    if (button == NSAlertFirstButtonReturn) {
        awayName = [input stringValue];
    }
    
    NSAlert *alert3 = [[NSAlert alloc] init];
    [alert3 setMessageText:@"Enter in the away record below"];
    [alert3 addButtonWithTitle:@"Ok"];
    NSTextField *input3 = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 24)];
    [input3 setStringValue:@""];
    [alert3 setAccessoryView:input3];
    NSInteger button3 = [alert3 runModal];
    if (button3 == NSAlertFirstButtonReturn) {
        awayRecord = [input3 stringValue];
    }
    
    NSAlert *alert6 = [[NSAlert alloc] init];
    [alert6 setMessageText:@"Enter in the away seed below (if desired). If not, don't enter anything."];
    [alert6 addButtonWithTitle:@"Ok"];
    NSTextField *input6 = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 24)];
    [input6 setStringValue:@""];
    [alert6 setAccessoryView:input6];
    NSInteger button6 = [alert6 runModal];
    if (button6 == NSAlertFirstButtonReturn) {
        awaySeed = [[input6 stringValue] intValue];
    }
    
    
    NSAlert *alert2 = [[NSAlert alloc] init];
    [alert2 setMessageText:@"Enter in the home name below"];
    [alert2 addButtonWithTitle:@"Ok"];
    NSTextField *input2 = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 24)];
    [input2 setStringValue:@""];
    [alert2 setAccessoryView:input2];
    NSInteger button2 = [alert2 runModal];
    if (button2 == NSAlertFirstButtonReturn) {
        homeName = [input2 stringValue];
    }

    NSAlert *alert4 = [[NSAlert alloc] init];
    [alert4 setMessageText:@"Enter in the home record below"];
    [alert4 addButtonWithTitle:@"Ok"];
    NSTextField *input4 = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 24)];
    [input4 setStringValue:@""];
    [alert4 setAccessoryView:input4];
    NSInteger button4 = [alert4 runModal];
    if (button4 == NSAlertFirstButtonReturn) {
        homeRecord = [input4 stringValue];
    }
    
    NSAlert *alert7 = [[NSAlert alloc] init];
    [alert7 setMessageText:@"Enter in the home seed below (if desired). If not, don't enter anything."];
    [alert7 addButtonWithTitle:@"Ok"];
    NSTextField *input7 = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 24)];
    [input7 setStringValue:@""];
    [alert7 setAccessoryView:input7];
    NSInteger button7 = [alert7 runModal];
    if (button7 == NSAlertFirstButtonReturn) {
        homeSeed = [[input7 stringValue] intValue];
    }
    
    NSAlert *alert5 = [[NSAlert alloc] init];
    [alert5 setMessageText:@"Enter in the location name below"];
    [alert5 addButtonWithTitle:@"Ok"];
    NSTextField *input5 = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 24)];
    [input5 setStringValue:@""];
    [alert5 setAccessoryView:input5];
    NSInteger button5 = [alert5 runModal];
    if (button5 == NSAlertFirstButtonReturn) {
        location = [input5 stringValue];
    }

    NSAlert *alert8 = [[NSAlert alloc] init];
    [alert8 setMessageText:@"If you would like any optional text, enter it in below"];
    [alert8 addButtonWithTitle:@"Ok"];
    NSTextField *input8 = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 24)];
    [input8 setStringValue:@""];
    [alert8 setAccessoryView:input8];
    NSInteger button8 = [alert8 runModal];
    if (button8 == NSAlertFirstButtonReturn) {
         optionalText = [input8 stringValue];
    }
    
    if ([optionalText isEqualToString:@""]) {
        optText = false;
        [_optText setStringValue:@""];
        [_optTextBackground setHidden:YES];
    } else {
        optText = true;
        [_optTextBackground setHidden:NO];
        [_optText setStringValue:optionalText];
    }
    
    [_awayNameDisplay setStringValue:awayName];
    [_homeNameDisplay setStringValue:homeName];
    
    
    if (homeSeed != 0 && awaySeed != 0) {
        [self makeSeedStrings];
        validSeeds = true;
    } else {
        [_awaySeed setStringValue:@""];
        [_homeSeed setStringValue:@""];
        validSeeds = false;
    }

    [_displayWindow makeKeyAndOrderFront:self];
    [_displayWindow setFrame:NSMakeRect(100.f, 100.f, 640.f, 480.f) display:YES animate:NO];
    [_controlWindow makeKeyAndOrderFront:self];

    
}

- (void)makeSeedStrings {
    
    CGSize awayStringSize = [awayName sizeWithAttributes:[NSDictionary dictionaryWithObject:[NSFont fontWithName:@"Adobe Heiti Std" size:35.0f] forKey:NSFontAttributeName]];
    
    float awayStringWidth = awayStringSize.width;
    
    NSRect awayBounds = NSMakeRect(681.5-awayStringWidth/2 - 33, 188, 50, 50);
    
    [_awaySeed setFrame:awayBounds];
    
    [_awaySeed setStringValue:[NSString stringWithFormat:@"%d", awaySeed]];
    
    CGSize homeStringSize = [homeName sizeWithAttributes:[NSDictionary dictionaryWithObject:[NSFont fontWithName:@"Adobe Heiti Std" size:35.0f] forKey:NSFontAttributeName]];
    
    float homeStringWidth = homeStringSize.width;
    
    NSRect homeBounds = NSMakeRect(1029.5-homeStringWidth/2 - 33, 188, 50, 50);
    
    [_homeSeed setFrame:homeBounds];
    
    [_homeSeed setStringValue:[NSString stringWithFormat:@"%d", homeSeed]];
    
    
}

- (void)setStartingValues {
    green = [NSColor colorWithCalibratedRed:0.365 green:0.78 blue:0.337 alpha:1];
    red = [NSColor redColor];
    blue = [NSColor blueColor];
    yellow = [NSColor colorWithCalibratedRed:0.9725 green:0.8705 blue:0.1843 alpha:1];
    black = [NSColor blackColor];
    
    timeoutShowing = false;
    touchdownShowing = false;
    flagShowing = false;
    replayShowing = false;
    clockShowing = true;
    downShowing = true;
    scorebugShowing = true;
    scoreboardShowing = false;
    locatorShowing = false;
    
    awaySeed = 0;
    homeSeed = 0;
    
    [_timeoutControl setStringValue:@"Hidden"];
    [_touchdownControl setStringValue:@"Hidden"];
    [_flagControl setStringValue:@"Hidden"];
    [_replayControl setStringValue:@"Hidden"];
    [_clockShowingControl setStringValue:@"Showing"];
    [_downShowingControl setStringValue:@"Showing"];
    [_scorebugShowingControl setStringValue:@"Showing"];
    down = 1;
    distance = 10;
    timeSeconds = 480;
    andGoal = false;
    justDown = false;
    clockRunning = false;
    quarter = 1;
    homeScore = 0;
    awayScore = 0;
    [_awayScoreControl setStringValue:@"Away: 0"];
    [_homeScoreControl setStringValue:@"Home: 0"];
    [_clockControl setStringValue:@"8:00"];
    [_quarterControl setStringValue:@"1st Qtr"];
    [_downAndDistanceControl setStringValue:@"1st & 10"];
    [_downControl setStringValue:@"1"];
    [_distanceControl setStringValue:@"10"];
    
    [_scorebugShowingControl setTextColor:green];
    [_downShowingControl setTextColor:green];
    [_clockShowingControl setTextColor:green];
    
    [self updateDisplayClock];
    [self updateDisplayDown];
    [self updateDisplayQuarter];
    [self updateDisplayScore];
    
    [_locatorAwayName setStringValue:@""];
    [_locatorAwayScore setStringValue:@""];
    [_locatorHomeName setStringValue:@""];
    [_locatorHomeScore setStringValue:@""];
    [_locatorQuarter setStringValue:@""];
    [_locatorAwaySeed setStringValue:@""];
    [_locatorHomeSeed setStringValue:@""];
    [_date setStringValue:@""];
    [_location setStringValue:@""];
    
    [_flagImage setHidden:YES];
    flagShowing = false;
    touchdownShowing = false;
    timeoutShowing = false;
    
    [_animationView setHidden:YES];
    replayDone = YES;
    [_animationTwoView setHidden:YES];
    
    NSURL* videoURL = [[NSBundle mainBundle] URLForResource:@"Animation 1" withExtension:@"m4v"];
    self.animationView.player = [AVPlayer playerWithURL:videoURL];
    
    NSURL* videoURLTwo = [[NSBundle mainBundle] URLForResource:@"animation 2" withExtension:@"m4v"];
    self.animationTwoView.player = [AVPlayer playerWithURL:videoURLTwo];
    
    optText = false;
    [_optText setStringValue:@""];
    [_optTextBackground setHidden:YES];
}

- (NSString*)getTimeString:(int)timeSeconds {
    NSString *timeLabel;
    if (timeSeconds/36000 > 0) {
        NSInteger ti = (NSInteger)timeSeconds;
        NSInteger seconds = ti % 60;
        NSInteger minutes = (ti / 60) % 60;
        NSInteger hours = (ti / 3600);
        timeLabel = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
    } else if (timeSeconds/3600 >= 1) {
        NSInteger ti = (NSInteger)timeSeconds;
        NSInteger seconds = ti % 60;
        NSInteger minutes = (ti / 60) % 60;
        NSInteger hours = (ti / 3600);
        timeLabel = [NSString stringWithFormat:@"%1ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
    } else if (timeSeconds/600 >= 1) { //are we talking two-digit minutes?
        NSInteger ti = (NSInteger)timeSeconds;
        NSInteger seconds = ti % 60;
        NSInteger minutes = (ti / 60) % 60;
        timeLabel = [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
    } else if (timeSeconds/60 >= 1) { //are we talking one-digit minutes?
        NSInteger ti = (NSInteger)timeSeconds;
        NSInteger seconds = ti % 60;
        NSInteger minutes = (ti / 60) % 60;
        timeLabel = [NSString stringWithFormat:@"%1ld:%02ld", (long)minutes, (long)seconds];
    } else if (timeSeconds > 0) { // are we talking seconds?
        NSInteger ti = (NSInteger)timeSeconds;
        NSInteger seconds = ti % 60;
        timeLabel = [NSString stringWithFormat:@"0:%02ld", (long)seconds];
    } else {
        timeLabel = @"0:00";
    }
    return timeLabel;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)awayPlusSix:(id)sender {
    awayScore += 3;
    [_awayScoreControl setStringValue:[NSString stringWithFormat:@"Away: %d", awayScore]];
    [self updateDisplayScore];
}

- (IBAction)awayPlusThree:(id)sender {
    awayScore += 2;
    [_awayScoreControl setStringValue:[NSString stringWithFormat:@"Away: %d", awayScore]];
    [self updateDisplayScore];
}

- (IBAction)awayPlusOne:(id)sender {
    awayScore += 1;
    [_awayScoreControl setStringValue:[NSString stringWithFormat:@"Away: %d", awayScore]];
    [self updateDisplayScore];
}

- (IBAction)awayMinusOne:(id)sender {
    if (awayScore > 0) {
        awayScore -= 1;
        [_awayScoreControl setStringValue:[NSString stringWithFormat:@"Away: %d", awayScore]];
    }
    [self updateDisplayScore];
}

- (IBAction)homePlusSix:(id)sender {
    homeScore += 3;
    [_homeScoreControl setStringValue:[NSString stringWithFormat:@"Home: %d", homeScore]];
    [self updateDisplayScore];
}

- (IBAction)homePlusThree:(id)sender {
    homeScore += 2;
    [_homeScoreControl setStringValue:[NSString stringWithFormat:@"Home: %d", homeScore]];
    [self updateDisplayScore];
}

- (IBAction)homePlusOne:(id)sender {
    homeScore += 1;
    [_homeScoreControl setStringValue:[NSString stringWithFormat:@"Home: %d", homeScore]];
    [self updateDisplayScore];
}

- (IBAction)homeMinusOne:(id)sender {
    if (homeScore > 0) {
        homeScore -= 1;
        [_homeScoreControl setStringValue:[NSString stringWithFormat:@"Home: %d", homeScore]];
    }
    [self updateDisplayScore];
}

- (IBAction)minusOneSecond:(id)sender {
    if (timeSeconds > 1) {
        timeSeconds -= 1;
        [_clockControl setStringValue:[self getTimeString:timeSeconds]];
    }
    [self updateDisplayClock];
}

- (IBAction)minusTenSeconds:(id)sender {
    if (timeSeconds > 10) {
        timeSeconds -= 10;
        [_clockControl setStringValue:[self getTimeString:timeSeconds]];
    }
    [self updateDisplayClock];
}

- (IBAction)minusOneMinute:(id)sender {
    if (timeSeconds > 60) {
        timeSeconds -= 60;
        [_clockControl setStringValue:[self getTimeString:timeSeconds]];
    }
    [self updateDisplayClock];
}

- (IBAction)plusOneSecond:(id)sender {
    timeSeconds += 1;
    [_clockControl setStringValue:[self getTimeString:timeSeconds]];
    [self updateDisplayClock];
}

- (IBAction)plusTenSeconds:(id)sender {
    timeSeconds += 10;
    [_clockControl setStringValue:[self getTimeString:timeSeconds]];
    [self updateDisplayClock];
}

- (IBAction)plusOneMinute:(id)sender {
    timeSeconds += 60;
    [_clockControl setStringValue:[self getTimeString:timeSeconds]];
    [self updateDisplayClock];}

- (IBAction)minusQuarter:(id)sender {
    if (quarter > 1) {
        quarter--;
    }
    if (quarter == 1) {
        [_quarterControl setStringValue:@"1st Qtr"];
    } else if (quarter == 2) {
        [_quarterControl setStringValue:@"End 1st"];
    } else if (quarter == 3) {
        [_quarterControl setStringValue:@"2nd Qtr"];
    } else if (quarter == 4) {
        [_quarterControl setStringValue:@"Halftime"];
    } else if (quarter == 5) {
        [_quarterControl setStringValue:@"3rd Qtr"];
    } else if (quarter == 6) {
        [_quarterControl setStringValue:@"End 3rd"];
    } else if (quarter == 7) {
        [_quarterControl setStringValue:@"4th Qtr"];
    } else if (quarter == 8) {
        [_quarterControl setStringValue:@"Final"];
    } else if (quarter == 9) {
        [_quarterControl setStringValue:@"End Reg"];
    } else if (quarter == 10) {
        [_quarterControl setStringValue:@"OT"];
    } else if (quarter == 11) {
        [_quarterControl setStringValue:@"F/OT"];
    } else if (quarter == 12) {
        [_quarterControl setStringValue:@"End 1OT"];
    } else if (quarter == 13) {
        [_quarterControl setStringValue:@"2 OT"];
    } else if (quarter == 14) {
        [_quarterControl setStringValue:@"F/2OT"];
    }
    [self updateDisplayQuarter];
}

- (IBAction)plusQuarter:(id)sender {
    if (quarter < 14) {
        quarter++;
    }
    if (quarter == 1) {
        [_quarterControl setStringValue:@"1st Qtr"];
    } else if (quarter == 2) {
        [_quarterControl setStringValue:@"End 1st"];
    } else if (quarter == 3) {
        [_quarterControl setStringValue:@"2nd Qtr"];
    } else if (quarter == 4) {
        [_quarterControl setStringValue:@"Halftime"];
    } else if (quarter == 5) {
        [_quarterControl setStringValue:@"3rd Qtr"];
    } else if (quarter == 6) {
        [_quarterControl setStringValue:@"End 3rd"];
    } else if (quarter == 7) {
        [_quarterControl setStringValue:@"4th Qtr"];
    } else if (quarter == 8) {
        [_quarterControl setStringValue:@"Final"];
    } else if (quarter == 9) {
        [_quarterControl setStringValue:@"End Reg"];
    } else if (quarter == 10) {
        [_quarterControl setStringValue:@"OT"];
    } else if (quarter == 11) {
        [_quarterControl setStringValue:@"F/OT"];
    } else if (quarter == 12) {
        [_quarterControl setStringValue:@"End 1OT"];
    } else if (quarter == 13) {
        [_quarterControl setStringValue:@"2 OT"];
    } else if (quarter == 14) {
        [_quarterControl setStringValue:@"F/2OT"];
    }
    [self updateDisplayQuarter];
}

- (IBAction)showTimeout:(id)sender {
    if (locatorShowing || scoreboardShowing) {
        
    } else if (scorebugShowing) {
        if (timeoutShowing) {
            [_flagImage setHidden:YES];
            timeoutShowing = false;
            [_timeoutControl setStringValue:@"Hidden"];
            [_timeoutControl setTextColor:black];
            [_timeoutButton setTitle:@"Show Timeout"];
        } else {
            [_flagImage setImage:[NSImage imageNamed:@"timeout.001.jpg"]];
            [_flagImage setHidden:NO];
            timeoutShowing = true;
            flagShowing = false;
            touchdownShowing = false;
            [_timeoutControl setStringValue:@"Showing"];
            [_timeoutControl setTextColor:red];
            [_flagControl setStringValue:@"Hidden"];
            [_flagControl setTextColor:black];
            [_touchdownControl setStringValue:@"Hidden"];
            [_touchdownControl setTextColor:black];
            [_touchdownButton setTitle:@"Show Touchdown"];
            [_flagButton setTitle:@"Show Foul"];
            [_timeoutButton setTitle:@"Hide Timeout"];
        }
    }
}

- (IBAction)showFlag:(id)sender {
    if (locatorShowing || scoreboardShowing) {
        
    } else if (scorebugShowing) {
        if (flagShowing) {
            [_flagImage setHidden:YES];
            flagShowing = false;
            [_flagControl setStringValue:@"Hidden"];
            [_flagControl setTextColor:black];
            [_flagButton setTitle:@"Show Foul"];
        } else {
            [_flagImage setImage:[NSImage imageNamed:@"foul.001.jpg"]];
            [_flagImage setHidden:NO];
            timeoutShowing = false;
            flagShowing = true;
            touchdownShowing = false;
            [_timeoutControl setStringValue:@"Hidden"];
            [_timeoutControl setTextColor:black];
            [_flagControl setStringValue:@"Showing"];
            [_flagControl setTextColor:red];
            [_touchdownControl setStringValue:@"Hidden"];
            [_touchdownControl setTextColor:black];
            [_touchdownButton setTitle:@"Show Touchdown"];
            [_flagButton setTitle:@"Hide Foul"];
            [_timeoutButton setTitle:@"Show Timeout"];
        }
    }
}

- (IBAction)showTouchdown:(id)sender {
    if (locatorShowing || scoreboardShowing) {
        
    } else if (scorebugShowing) {
        if (touchdownShowing) {
            [_flagImage setHidden:YES];
            touchdownShowing = false;
            [_touchdownControl setStringValue:@"Hidden"];
            [_touchdownControl setTextColor:black];
            [_touchdownButton setTitle:@"Show Touchdown"];
        } else {
            [_flagImage setImage:[NSImage imageNamed:@"touchdown.001.jpg"]];
            [_flagImage setHidden:NO];
            timeoutShowing = false;
            flagShowing = false;
            touchdownShowing = true;
            [_timeoutControl setStringValue:@"Hidden"];
            [_timeoutControl setTextColor:black];
            [_flagControl setStringValue:@"Hidden"];
            [_flagControl setTextColor:black];
            [_touchdownControl setStringValue:@"Showing"];
            [_touchdownControl setTextColor:red];
            [_touchdownButton setTitle:@"Hide Touchdown"];
            [_flagButton setTitle:@"Show Foul"];
            [_timeoutButton setTitle:@"Show Timeout"];
        }
    }
}

- (IBAction)startClock:(id)sender {
    if (clockRunning) {
        clockRunning = false;
        [clockTimer invalidate];
        clockTimer = nil;
    } else {
        NSLog(@"hi");
        clockRunning = true;
        clockTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runClock) userInfo:self repeats:YES];
    }
}

- (void) runClock {
    if (timeSeconds > 1) {
        timeSeconds--;
        [_clockControl setStringValue:[self getTimeString:timeSeconds]];
    } else {
        if (clockRunning) {
            [self startClock:self];
        }
        timeSeconds = 0;
        [_clockControl setStringValue:@"0:00"];
    }
    [self updateDisplayClock];
}

- (IBAction)resetClock:(id)sender {
    if (clockRunning) {
        [self startClock:self];
    }
    timeSeconds = 480;
    [_clockControl setStringValue:@"8:00"];
    [self updateDisplayClock];
}

- (IBAction)showReplay:(id)sender {
    if (replayShowing) {
        if (!replayDone) {
            [_animationView setHidden:YES];
            [_animationTwoView setHidden:YES];
            [_colorScorebug setHidden:YES];
            [replayTimer invalidate];
            replayTimer = nil;
            [resetTimer invalidate];
            resetTimer = nil;
            NSURL* videoURL = [[NSBundle mainBundle] URLForResource:@"Animation 1" withExtension:@"m4v"];
            self.animationView.player = [AVPlayer playerWithURL:videoURL];
            NSURL* videoURLTwo = [[NSBundle mainBundle] URLForResource:@"animation 2" withExtension:@"m4v"];
            self.animationTwoView.player = [AVPlayer playerWithURL:videoURLTwo];
            replayDone = YES;
        } else {
            [self newReplayEnd];
        }
        replayShowing = false;
        [_replayButton setTitle:@"Show Replay"];
        [_replayControl setStringValue:@"Hidden"];
        [_replayControl setTextColor:black];
    } else {
        if (!replayDone) {
            [_animationView setHidden:YES];
            [_animationTwoView setHidden:YES];
            [_colorScorebug setHidden:YES];
            replayShowing = false;
            [resetTimer invalidate];
            resetTimer = nil;
            [replayTimer invalidate];
            replayTimer = nil;
            NSURL* videoURL = [[NSBundle mainBundle] URLForResource:@"Animation 1" withExtension:@"m4v"];
            self.animationView.player = [AVPlayer playerWithURL:videoURL];
            NSURL* videoURLTwo = [[NSBundle mainBundle] URLForResource:@"animation 2" withExtension:@"m4v"];
            self.animationTwoView.player = [AVPlayer playerWithURL:videoURLTwo];
            replayDone = YES;
        } else {
            [self newReplayStart];
            replayShowing = true;
            [_replayButton setTitle:@"Hide Replay"];
            [_replayControl setStringValue:@"Showing"];
            [_replayControl setTextColor:red];
        }
    }

}

- (void) newReplayStart {
    NSURL* videoURL = [[NSBundle mainBundle] URLForResource:@"Animation 1" withExtension:@"m4v"];
    self.animationView.player = [AVPlayer playerWithURL:videoURL];

    
    [_animationView setHidden:NO];
    [[_animationView player] play];
    replayDone = NO;
    [_colorScorebug setHidden:NO];
    resetTimer = [NSTimer scheduledTimerWithTimeInterval:2.2 target:self selector:@selector(resetReplay) userInfo:nil repeats:NO];
    replayTimer = nil;

}

- (void) newReplayEnd {
    

    [[_animationTwoView player] play];
    replayDone = NO;
    replayTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(replayScorebug) userInfo:self repeats:NO];
}

- (void) resetReplay {
    replayDone = YES;
    [resetTimer invalidate];
    resetTimer = nil;

    [_animationTwoView setHidden:NO];
    [_animationView setHidden:YES];
    
    NSURL* videoURL = [[NSBundle mainBundle] URLForResource:@"Animation 1" withExtension:@"m4v"];
    self.animationView.player = [AVPlayer playerWithURL:videoURL];
    
}

- (void) replayScorebug {
    replayDone = YES;
    [_animationView setHidden:YES];
    [_animationTwoView setHidden:YES];
    [_colorScorebug setHidden:YES];
    [replayTimer invalidate];
    replayTimer = nil;
    
    NSURL* videoURL = [[NSBundle mainBundle] URLForResource:@"Animation 1" withExtension:@"m4v"];
    self.animationView.player = [AVPlayer playerWithURL:videoURL];
    
    NSURL* videoURLTwo = [[NSBundle mainBundle] URLForResource:@"animation 2" withExtension:@"m4v"];
    self.animationTwoView.player = [AVPlayer playerWithURL:videoURLTwo];
}

- (IBAction)hideClock:(id)sender {
    if (clockShowing) {
        clockShowing = false;
        [_clockShowingControl setStringValue:@"Hidden"];
        [_clockShowingControl setTextColor:red];
        [_clockButton setTitle:@"Show Clock"];
        [self updateDisplayClock];
    } else {
        clockShowing = true;
        [_clockShowingControl setStringValue:@"Showing"];
        [_clockShowingControl setTextColor:green];
        [_clockButton setTitle:@"Hide Clock"];
        [self updateDisplayClock];
    }
}

- (IBAction)hideScorebug:(id)sender {
    if (scorebugShowing) {
        [self concealScorebug];
        scorebugShowing = false;
        [_scorebugButton setTitle:@"Show Scorebug"];
        [_scorebugShowingControl setStringValue:@"Hidden"];
        [_scorebugShowingControl setTextColor:red];
    } else {
        if (locatorShowing) {
            [self showLocator:self];
        }
        if (scoreboardShowing) {
            [self showScoreboard:self];
        }
        [self concealScorebug];
        [_scorebugButton setTitle:@"Hide Scorebug"];
        [_scorebugShowingControl setStringValue:@"Showing"];
        [_scorebugShowingControl setTextColor:green];
        scorebugShowing = true;
    }
}

- (IBAction)hideDown:(id)sender {
    if (downShowing) {
        downShowing = false;
        [_downShowingControl setStringValue:@"Hidden"];
        [_downShowingControl setTextColor:red];
        [_downButton setTitle:@"Show Do&D"];
        [self updateDisplayDown];
    } else {
        downShowing = true;
        [_downShowingControl setStringValue:@"Showing"];
        [_downShowingControl setTextColor:green];
        [_downButton setTitle:@"Hide Do&D"];
        [self updateDisplayDown];
    }
}

- (IBAction)plusDown:(id)sender {
    justDown = false;
    if (down < 4) {
        down++;
    }
    [_downControl setStringValue:[NSString stringWithFormat:@"%d", down]];
}

- (IBAction)minusDown:(id)sender {
    justDown = false;
    if (down > 1) {
        down--;
    }
    [_downControl setStringValue:[NSString stringWithFormat:@"%d", down]];
}

- (IBAction)plusDistance:(id)sender {
    justDown = false;
    distance++;
    [_distanceControl setStringValue:[NSString stringWithFormat:@"%d", distance]];
    andGoal = false;
}

- (IBAction)minusDistance:(id)sender {
    justDown = false;
    if (distance > 1) {
        distance--;
    }
    [_distanceControl setStringValue:[NSString stringWithFormat:@"%d", distance]];
    andGoal = false;
}

- (IBAction)resetDown:(id)sender {
    justDown = false;
    andGoal = false;
    down = 1;
    distance = 10;
    [_downControl setStringValue:@"1"];
    [_distanceControl setStringValue:@"10"];
    [_downAndDistanceControl setStringValue:@"1st & 10"];
    [self updateDisplayDown];
}

- (IBAction)justDown:(id)sender {
    justDown = true;
    if (down == 1) {
        [_downAndDistanceControl setStringValue:[NSString stringWithFormat:@"1st Down"]];
    }
    if (down == 2) {
        [_downAndDistanceControl setStringValue:[NSString stringWithFormat:@"2nd Down"]];
    }
    if (down == 3) {
        [_downAndDistanceControl setStringValue:[NSString stringWithFormat:@"3rd Down"]];
    }
    if (down == 4) {
        [_downAndDistanceControl setStringValue:[NSString stringWithFormat:@"4th Down"]];
    }
    [self updateDisplayDown];
    justDown = false;
}

- (IBAction)updateDown:(id)sender {
    justDown = false;
    if (!andGoal) {
        if (down == 1) {
            [_downAndDistanceControl setStringValue:[NSString stringWithFormat:@"1st & %d", distance]];
        }
        if (down == 2) {
            [_downAndDistanceControl setStringValue:[NSString stringWithFormat:@"2nd & %d", distance]];
        }
        if (down == 3) {
            [_downAndDistanceControl setStringValue:[NSString stringWithFormat:@"3rd & %d", distance]];
        }
        if (down == 4) {
            [_downAndDistanceControl setStringValue:[NSString stringWithFormat:@"4th & %d", distance]];
        }
    } else {
        if (down == 1) {
            [_downAndDistanceControl setStringValue:[NSString stringWithFormat:@"1st & G"]];
        }
        if (down == 2) {
            [_downAndDistanceControl setStringValue:[NSString stringWithFormat:@"2nd & G"]];
        }
        if (down == 3) {
            [_downAndDistanceControl setStringValue:[NSString stringWithFormat:@"3rd & G"]];
        }
        if (down == 4) {
            [_downAndDistanceControl setStringValue:[NSString stringWithFormat:@"4th & G"]];
        }
    }
    [self updateDisplayDown];
}

- (IBAction)andGoal:(id)sender {
    if (!andGoal) {
        andGoal = true;
        [_distanceControl setStringValue:@"G"];
    } else {
        andGoal = false;
        [_distanceControl setStringValue:[NSString stringWithFormat:@"%d", distance]];
    }
}


- (void)updateDisplayClock {
    if (clockShowing) {
        [_clockDisplay setStringValue:[self getTimeString:timeSeconds]];
    } else {
        [_clockDisplay setStringValue:@""];
    }
}

- (void)updateDisplayDown {
    if (downShowing) {
        if (justDown) {
            if (down == 1) {
                [_downDisplay setStringValue:[NSString stringWithFormat:@"1st Down"]];
            }
            if (down == 2) {
                [_downDisplay setStringValue:[NSString stringWithFormat:@"2nd Down"]];
            }
            if (down == 3) {
                [_downDisplay setStringValue:[NSString stringWithFormat:@"3rd Down"]];
            }
            if (down == 4) {
                [_downDisplay setStringValue:[NSString stringWithFormat:@"4th Down"]];
            }
        } else {
            if (!andGoal) {
                if (down == 1) {
                    [_downDisplay setStringValue:[NSString stringWithFormat:@"1st & %d", distance]];
                }
                if (down == 2) {
                    [_downDisplay setStringValue:[NSString stringWithFormat:@"2nd & %d", distance]];
                }
                if (down == 3) {
                    [_downDisplay setStringValue:[NSString stringWithFormat:@"3rd & %d", distance]];
                }
                if (down == 4) {
                    [_downDisplay setStringValue:[NSString stringWithFormat:@"4th & %d", distance]];
                }
            } else {
                if (down == 1) {
                    [_downDisplay setStringValue:[NSString stringWithFormat:@"1st & G"]];
                }
                if (down == 2) {
                    [_downDisplay setStringValue:[NSString stringWithFormat:@"2nd & G"]];
                }
                if (down == 3) {
                    [_downDisplay setStringValue:[NSString stringWithFormat:@"3rd & G"]];
                }
                if (down == 4) {
                    [_downDisplay setStringValue:[NSString stringWithFormat:@"4th & G"]];
                }
            }
        }
    } else {
        [_downDisplay setStringValue:@""];
    }
    
}

- (void)updateDisplayScore {
    [_homeScoreDisplay setStringValue:[NSString stringWithFormat:@"%d", homeScore]];
    [_awayScoreDisplay setStringValue:[NSString stringWithFormat:@"%d", awayScore]];
    if (scoreboardShowing) {
        [self showScoreboard:self];
        [self showScoreboard:self];
    }
}

- (void)updateDisplayQuarter {
    if (quarter == 1) {
        [_quarterDisplay setStringValue:@"1st Qtr"];
    } else if (quarter == 2) {
        [_quarterDisplay setStringValue:@"End 1st"];
    } else if (quarter == 3) {
        [_quarterDisplay setStringValue:@"2nd Qtr"];
    } else if (quarter == 4) {
        [_quarterDisplay setStringValue:@"Half"];
    } else if (quarter == 5) {
        [_quarterDisplay setStringValue:@"3rd Qtr"];
    } else if (quarter == 6) {
        [_quarterDisplay setStringValue:@"End 3rd"];
    } else if (quarter == 7) {
        [_quarterDisplay setStringValue:@"4th Qtr"];
    } else if (quarter == 8) {
        [_quarterDisplay setStringValue:@"Final"];
    } else if (quarter == 9) {
        [_quarterDisplay setStringValue:@"End Reg"];
    } else if (quarter == 10) {
        [_quarterDisplay setStringValue:@"OT"];
    } else if (quarter == 11) {
        [_quarterDisplay setStringValue:@"F/OT"];
    } else if (quarter == 12) {
        [_quarterDisplay setStringValue:@"End 1OT"];
    } else if (quarter == 13) {
        [_quarterDisplay setStringValue:@"2 OT"];
    } else if (quarter == 14) {
        [_quarterDisplay setStringValue:@"F/2OT"];
    }
    if (scoreboardShowing) {
        [self showScoreboard:self];
        [self showScoreboard:self];
    }
}




- (IBAction)enterFullScreen:(id)sender {
    [_displayWindow toggleFullScreen:nil];
    
    if (homeSeed != 0 && awaySeed != 0) {
        [self makeSeedStrings];
        validSeeds = true;
    } else {
        [_awaySeed setStringValue:@""];
        [_homeSeed setStringValue:@""];
        validSeeds = false;
    }
}


- (IBAction)displayEnterFullScreen:(id)sender {
    [_displayFullScreenButton setTransparent:YES];
    [_displayFullScreenButton setEnabled:NO];
    [_displayWindow toggleFullScreen:nil];
    
    if (homeSeed != 0 && awaySeed != 0) {
        [self makeSeedStrings];
        validSeeds = true;
    } else {
        [_awaySeed setStringValue:@""];
        [_homeSeed setStringValue:@""];
        validSeeds = false;
    }

}
- (IBAction)showLocator:(id)sender {
    if (locatorShowing) {
        [self concealScoreboard];
        [_locatorShowingControl setStringValue:@"Hidden"];
        [_locatorShowingControl setTextColor:black];
        [_locatorHomeName setStringValue:@""];
        [_locatorHomeScore setStringValue:@""];
        [_locatorAwayName setStringValue:@""];
        [_locatorAwayScore setStringValue:@""];
        [_date setStringValue:@""];
        [_location setStringValue:@""];
        [_locatorHomeSeed setStringValue:@""];
        [_locatorAwaySeed setStringValue:@""];
        [_locatorShowingControl setTextColor:black];
        [_locatorShowingControl setStringValue:@"Hidden"];
        [_showLocatorButton setTitle:@"Show Locator"];
        locatorShowing = false;
    } else {
        [_locatorShowingControl setStringValue:@"Showing"];
        [_locatorShowingControl setTextColor:green];
        if (scoreboardShowing) {
            [self showScoreboard:self];
        }
        if (scorebugShowing) {
            [self hideScorebug:self];
        }
        [self concealScoreboard];
        [_locatorHomeName setStringValue:homeName];
        [_locatorHomeScore setStringValue:homeRecord];
        [_locatorAwayName setStringValue:awayName];
        [_locatorAwayScore setStringValue:awayRecord];
        [_location setStringValue:location];
        [_date setStringValue:dateText];
        if (validSeeds) {
            [_locatorAwaySeed setStringValue:[NSString stringWithFormat:@"%d", awaySeed]];
            [_locatorHomeSeed setStringValue:[NSString stringWithFormat:@"%d", homeSeed]];
        }
        [_locatorShowingControl setTextColor:red];
        [_locatorShowingControl setStringValue:@"Showing"];
        [_showLocatorButton setTitle:@"Hide Locator"];
        locatorShowing = true;
    }
}

- (IBAction)showScoreboard:(id)sender {
    if (scoreboardShowing) {
        [self concealScoreboard];
        [_scoreboardShowingControl setStringValue:@"Hidden"];
        [_scoreboardShowingControl setTextColor:black];
        [_locatorHomeName setStringValue:@""];
        [_locatorHomeScore setStringValue:@""];
        [_locatorAwayName setStringValue:@""];
        [_locatorAwayScore setStringValue:@""];
        [_locatorQuarter setStringValue:@""];
        [_locatorAwaySeed setStringValue:@""];
        [_locatorHomeSeed setStringValue:@""];
        [_showScoreboardButton setTitle:@"Show Scoreboard"];
        [_scoreboardShowingControl setStringValue:@"Hidden"];
        [_scoreboardShowingControl setTextColor:black];
        scoreboardShowing = false;
    } else {
        [_scoreboardShowingControl setStringValue:@"Showing"];
        [_scoreboardShowingControl setTextColor:green];
        if (locatorShowing) {
            [self showLocator:self];
        }
        if (scorebugShowing) {
            [self hideScorebug:self];
        }
        [self concealScoreboard];
        [_locatorHomeName setStringValue:homeName];
        [_locatorHomeScore setStringValue:[NSString stringWithFormat:@"%d", homeScore]];
        [_locatorAwayName setStringValue:awayName];
        [_locatorAwayScore setStringValue:[NSString stringWithFormat:@"%d", awayScore]];
        if (quarter == 1) {
            [_locatorQuarter setStringValue:@"1st Quarter"];
        } else if (quarter == 2) {
            [_locatorQuarter setStringValue:@"End 1st Quarter"];
        } else if (quarter == 3) {
            [_locatorQuarter setStringValue:@"2nd Quarter"];
        } else if (quarter == 4) {
            [_locatorQuarter setStringValue:@"Halftime"];
        } else if (quarter == 5) {
            [_locatorQuarter setStringValue:@"3rd Quarter"];
        } else if (quarter == 6) {
            [_locatorQuarter setStringValue:@"End 3rd Quarter"];
        } else if (quarter == 7) {
            [_locatorQuarter setStringValue:@"4th Quarter"];
        } else if (quarter == 8) {
            [_locatorQuarter setStringValue:@"Final"];
        } else if (quarter == 9) {
            [_locatorQuarter setStringValue:@"End Regulation"];
        } else if (quarter == 10) {
            [_locatorQuarter setStringValue:@"Overtime"];
        } else if (quarter == 11) {
            [_locatorQuarter setStringValue:@"Final/Overtime"];
        } else if (quarter == 12) {
            [_locatorQuarter setStringValue:@"End 1 Overtime"];
        } else if (quarter == 13) {
            [_locatorQuarter setStringValue:@"2 Overtime"];
        } else if (quarter == 14) {
            [_locatorQuarter setStringValue:@"Final/2 Overtime"];
        }
        if (validSeeds) {
            [_locatorAwaySeed setStringValue:[NSString stringWithFormat:@"%d", awaySeed]];
            [_locatorHomeSeed setStringValue:[NSString stringWithFormat:@"%d", homeSeed]];
        }
        [_showScoreboardButton setTitle:@"Hide Scoreboard"];
        [_scoreboardShowingControl setStringValue:@"Showing"];
        [_scoreboardShowingControl setTextColor:red];
        scoreboardShowing = true;
    }
}

- (void) concealScorebug {
    if (scorebugShowing) {
        [_awayNameDisplay setHidden:YES];
        [_awayScoreDisplay setHidden:YES];
        [_homeNameDisplay setHidden:YES];
        [_homeScoreDisplay setHidden:YES];
        [_downDisplay setHidden:YES];
        [_quarterDisplay setHidden:YES];
        [_clockDisplay setHidden:YES];
        [_scorebugBackground setHidden:YES];
        [_awaySeed setHidden:YES];
        [_homeSeed setHidden:YES];
        [_flagImage setHidden:YES];
        [_optText setHidden:YES];
        [_optTextBackground setHidden:YES];
        [_timeoutControl setStringValue:@"Hidden"];
        [_timeoutControl setTextColor:black];
        [_flagControl setStringValue:@"Hidden"];
        [_flagControl setTextColor:black];
        [_touchdownControl setStringValue:@"Hidden"];
        [_touchdownControl setTextColor:black];
        [_touchdownButton setTitle:@"Show Touchdown"];
        [_flagButton setTitle:@"Show Foul"];
        [_timeoutButton setTitle:@"Show Timeout"];
    } else {
        [_awayNameDisplay setHidden:NO];
        [_awayScoreDisplay setHidden:NO];
        [_homeNameDisplay setHidden:NO];
        [_homeScoreDisplay setHidden:NO];
        [_downDisplay setHidden:NO];
        [_quarterDisplay setHidden:NO];
        [_clockDisplay setHidden:NO];
        [_scorebugBackground setHidden:NO];
        [_awaySeed setHidden:NO];
        [_homeSeed setHidden:NO];
        if (optText) {
            [_optText setHidden:NO];
            [_optTextBackground setHidden:NO];
        }
    }

}

- (void) concealScoreboard {
    if (scoreboardShowing || locatorShowing) {
        [_locatorAwayName setHidden:YES];
        [_locatorAwayScore setHidden:YES];
        [_locatorHomeName setHidden:YES];
        [_locatorHomeScore setHidden:YES];
        [_locatorQuarter setHidden:YES];
        [_scoreboardBackground setHidden:YES];
        [_location setHidden:YES];
        [_date setHidden:YES];
        [_locatorAwaySeed setHidden:YES];
        [_locatorHomeSeed setHidden:YES];
    } else {
        [_locatorAwayName setHidden:NO];
        [_locatorAwayScore setHidden:NO];
        [_locatorHomeName setHidden:NO];
        [_locatorHomeScore setHidden:NO];
        [_locatorQuarter setHidden:NO];
        [_scoreboardBackground setHidden:NO];
        [_location setHidden:NO];
        [_date setHidden:NO];
        [_locatorAwaySeed setHidden:NO];
        [_locatorHomeSeed setHidden:NO];
    }
    
}

@end
