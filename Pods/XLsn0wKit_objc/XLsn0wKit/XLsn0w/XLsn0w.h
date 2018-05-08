/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *   \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *    \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *   \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *    \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
/*!
 * @author XLsn0w
 *
 * < XLsn0w类方法&&单例工具类>
 */

/**
 *  Get App name
 */
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

/**
 *  Get App build
 */
#define APP_BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

/**
 *  Get App version
 */
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/**
 *  Use BFLocalizedString to use the string translated by BFKit
 */
#define BFLocalizedString(key, comment) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:@"BFKit"]

/**
 *  Password strength level enum, from 0 (min) to 6 (max)
 */
typedef NS_ENUM(NSInteger, PasswordStrengthLevel) {
    /**
     *  Password strength very weak
     */
    PasswordStrengthLevelVeryWeak = 0,
    /**
     *  Password strength weak
     */
    PasswordStrengthLevelWeak,
    /**
     *  Password strength average
     */
    PasswordStrengthLevelAverage,
    /**
     *  Password strength strong
     */
    PasswordStrengthLevelStrong,
    /**
     *  Password strength very strong
     */
    PasswordStrengthLevelVeryStrong,
    /**
     *  Password strength secure
     */
    PasswordStrengthLevelSecure,
    /**
     *  Password strength very secure
     */
    PasswordStrengthLevelVerySecure
};

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

/**
 *  Audio IDs enum - http://iphonedevwiki.net/index.php/AudioServices
 */
typedef NS_ENUM(NSInteger, AudioID) {
    /**
     *  New Mail
     */
    AudioIDNewMail = 1000,
    /**
     *  Mail Sent
     */
    AudioIDMailSent = 1001,
    /**
     *  Voice Mail
     */
    AudioIDVoiceMail = 1002,
    /**
     *  Recived Message
     */
    AudioIDRecivedMessage = 1003,
    /**
     *  Sent Message
     */
    AudioIDSentMessage = 1004,
    /**
     *  Alerm
     */
    AudioIDAlarm = 1005,
    /**
     *  Low pPower
     */
    AudioIDLowPower = 1006,
    /**
     *  SMS Received 1
     */
    AudioIDSMSReceived1 = 1007,
    /**
     *  SMS Received 2
     */
    AudioIDSMSReceived2 = 1008,
    /**
     *  SMS Received 3
     */
    AudioIDSMSReceived3 = 1009,
    /**
     *  SMS Received 4
     */
    AudioIDSMSReceived4 = 1010,
    /**
     *  SMS Received 5
     */
    AudioIDSMSReceived5 = 1013,
    /**
     *  SMS Received 6
     */
    AudioIDSMSReceived6 = 1014,
    /**
     *  Tweet Sent
     */
    AudioIDTweetSent = 1016,
    /**
     *  Anticipate
     */
    AudioIDAnticipate = 1020,
    /**
     *  Bloom
     */
    AudioIDBloom = 1021,
    /**
     *  Calypso
     */
    AudioIDCalypso = 1022,
    /**
     *  Choo Choo
     */
    AudioIDChooChoo = 1023,
    /**
     *  Descent
     */
    AudioIDDescent = 1024,
    /**
     *  Fanfare
     */
    AudioIDFanfare = 1025,
    /**
     *  Ladder
     */
    AudioIDLadder = 1026,
    /**
     *  Minuet
     */
    AudioIDMinuet = 1027,
    /**
     *  News Flash
     */
    AudioIDNewsFlash = 1028,
    /**
     *  Noir
     */
    AudioIDNoir = 1029,
    /**
     *  Sherwood Forest
     */
    AudioIDSherwoodForest = 1030,
    /**
     *  Speel
     */
    AudioIDSpell = 1031,
    /**
     *  Suspance
     */
    AudioIDSuspence = 1032,
    /**
     *  Telegraph
     */
    AudioIDTelegraph = 1033,
    /**
     *  Tiptoes
     */
    AudioIDTiptoes = 1034,
    /**
     *  Typewriters
     */
    AudioIDTypewriters = 1035,
    /**
     *  Update
     */
    AudioIDUpdate = 1036,
    /**
     *  USSD Alert
     */
    AudioIDUSSDAlert = 1050,
    /**
     *  SIM Toolkit Call Dropped
     */
    AudioIDSIMToolkitCallDropped = 1051,
    /**
     *  SIM Toolkit General Beep
     */
    AudioIDSIMToolkitGeneralBeep = 1052,
    /**
     *  SIM Toolkit Negative ACK
     */
    AudioIDSIMToolkitNegativeACK = 1053,
    /**
     *  SIM Toolkit Positive ACK
     */
    AudioIDSIMToolkitPositiveACK = 1054,
    /**
     *  SIM Toolkit SMS
     */
    AudioIDSIMToolkitSMS = 1055,
    /**
     *  Tink
     */
    AudioIDTink = 1057,
    /**
     *  CT Busy
     */
    AudioIDCTBusy = 1070,
    /**
     *  CT Congestion
     */
    AudioIDCTCongestion = 1071,
    /**
     *  CT Pack ACK
     */
    AudioIDCTPathACK = 1072,
    /**
     *  CT Error
     */
    AudioIDCTError = 1073,
    /**
     *  CT Call Waiting
     */
    AudioIDCTCallWaiting = 1074,
    /**
     *  CT Keytone
     */
    AudioIDCTKeytone = 1075,
    /**
     *  Lock
     */
    AudioIDLock = 1100,
    /**
     *  Unlock
     */
    AudioIDUnlock = 1101,
    /**
     *  Failed Unlock
     */
    AudioIDFailedUnlock = 1102,
    /**
     *  Keypressed Tink
     */
    AudioIDKeypressedTink = 1103,
    /**
     *  Keypressed Tock
     */
    AudioIDKeypressedTock = 1104,
    /**
     *  Tock
     */
    AudioIDTock = 1105,
    /**
     *  Beep Beep
     */
    AudioIDBeepBeep = 1106,
    /**
     *  Ringer Charged
     */
    AudioIDRingerCharged = 1107,
    /**
     *  Photo Shutter
     */
    AudioIDPhotoShutter = 1108,
    /**
     *  Shake
     */
    AudioIDShake = 1109,
    /**
     *  JBL Begin
     */
    AudioIDJBLBegin = 1110,
    /**
     *  JBL Confirm
     */
    AudioIDJBLConfirm = 1111,
    /**
     *  JBL Cancel
     */
    AudioIDJBLCancel = 1112,
    /**
     *  Begin Recording
     */
    AudioIDBeginRecording = 1113,
    /**
     *  End Recording
     */
    AudioIDEndRecording = 1114,
    /**
     *  JBL Ambiguous
     */
    AudioIDJBLAmbiguous = 1115,
    /**
     *  JBL No Match
     */
    AudioIDJBLNoMatch = 1116,
    /**
     *  Begin Video Record
     */
    AudioIDBeginVideoRecord = 1117,
    /**
     *  End Video Record
     */
    AudioIDEndVideoRecord = 1118,
    /**
     *  VC Invitation Accepted
     */
    AudioIDVCInvitationAccepted = 1150,
    /**
     *  VC Ringing
     */
    AudioIDVCRinging = 1151,
    /**
     *  VC Ended
     */
    AudioIDVCEnded = 1152,
    /**
     *  VC Call Waiting
     */
    AudioIDVCCallWaiting = 1153,
    /**
     *  VC Call Upgrade
     */
    AudioIDVCCallUpgrade = 1154,
    /**
     *  Touch Tone 1
     */
    AudioIDTouchTone1 = 1200,
    /**
     *  Touch Tone 2
     */
    AudioIDTouchTone2 = 1201,
    /**
     *  Touch Tone 3
     */
    AudioIDTouchTone3 = 1202,
    /**
     *  Touch Tone 4
     */
    AudioIDTouchTone4 = 1203,
    /**
     *  Touch Tone 5
     */
    AudioIDTouchTone5 = 1204,
    /**
     *  Touch Tone 6
     */
    AudioIDTouchTone6 = 1205,
    /**
     *  Touch Tone 7
     */
    AudioIDTouchTone7 = 1206,
    /**
     *  Touch Tone 8
     */
    AudioIDTouchTone8 = 1207,
    /**
     *  Touch Tone 9
     */
    AudioIDTouchTone9 = 1208,
    /**
     *  Touch Tone 10
     */
    AudioIDTouchTone10 = 1209,
    /**
     *  Tone Star
     */
    AudioIDTouchToneStar = 1210,
    /**
     *  Tone Pound
     */
    AudioIDTouchTonePound = 1211,
    /**
     *  Headset Start Call
     */
    AudioIDHeadsetStartCall = 1254,
    /**
     *  Headset Redial
     */
    AudioIDHeadsetRedial = 1255,
    /**
     *  Headset Answer Call
     */
    AudioIDHeadsetAnswerCall = 1256,
    /**
     *  Headset End Call
     */
    AudioIDHeadsetEndCall = 1257,
    /**
     *  Headset Call Waiting Actions
     */
    AudioIDHeadsetCallWaitingActions = 1258,
    /**
     *  Headset Transition End
     */
    AudioIDHeadsetTransitionEnd = 1259,
    /**
     *  Voicemail
     */
    AudioIDVoicemail = 1300,
    /**
     *  Received Message
     */
    AudioIDReceivedMessage = 1301,
    /**
     *  New Mail 2
     */
    AudioIDNewMail2 = 1302,
    /**
     *  Email Sent 2
     */
    AudioIDMailSent2 = 1303,
    /**
     *  Alarm 2
     */
    AudioIDAlarm2 = 1304,
    /**
     *  Lock 2
     */
    AudioIDLock2 = 1305,
    /**
     *  Tock 2
     */
    AudioIDTock2 = 1306,
    /**
     *  SMS Received 7
     */
    AudioIDSMSReceived1_2 = 1307,
    /**
     *  SMS Received 8
     */
    AudioIDSMSReceived2_2 = 1308,
    /**
     *  SMS Received 9
     */
    AudioIDSMSReceived3_2 = 1309,
    /**
     *  SMS Received 10
     */
    AudioIDSMSReceived4_2 = 1310,
    /**
     *  SMS Received Vibrate
     */
    AudioIDSMSReceivedVibrate = 1311,
    /**
     *  SMS Received 11
     */
    AudioIDSMSReceived1_3 = 1312,
    /**
     *  SMS Received 12
     */
    AudioIDSMSReceived5_3 = 1313,
    /**
     *  SMS Received 13
     */
    AudioIDSMSReceived6_3 = 1314,
    /**
     *  Voicemail 2
     */
    AudioIDVoicemail2 = 1315,
    /**
     *  Anticipate 2
     */
    AudioIDAnticipate2 = 1320,
    /**
     *  Bloom 2
     */
    AudioIDBloom2 = 1321,
    /**
     *  Calypso 2
     */
    AudioIDCalypso2 = 1322,
    /**
     *  Choo Choo 2
     */
    AudioIDChooChoo2 = 1323,
    /**
     *  Descent 2
     */
    AudioIDDescent2 = 1324,
    /**
     *  Fanfare 2
     */
    AudioIDFanfare2 = 1325,
    /**
     *  Ladder 2
     */
    AudioIDLadder2 = 1326,
    /**
     *  Minuet 2
     */
    AudioIDMinuet2 = 1327,
    /**
     *  News Flash 2
     */
    AudioIDNewsFlash2 = 1328,
    /**
     *  Noir 2
     */
    AudioIDNoir2 = 1329,
    /**
     *  Sherwood Forest 2
     */
    AudioIDSherwoodForest2 = 1330,
    /**
     *  Speel 2
     */
    AudioIDSpell2 = 1331,
    /**
     *  Suspence 2
     */
    AudioIDSuspence2 = 1332,
    /**
     *  Telegraph 2
     */
    AudioIDTelegraph2 = 1333,
    /**
     *  Tiptoes 2
     */
    AudioIDTiptoes2 = 1334,
    /**
     *  Typewriters 2
     */
    AudioIDTypewriters2 = 1335,
    /**
     *  Update 2
     */
    AudioIDUpdate2 = 1336,
    /**
     *  Ringer View Changed
     */
    AudioIDRingerVibeChanged = 1350,
    /**
     *  Silent View Changed
     */
    AudioIDSilentVibeChanged = 1351,
    /**
     *  Vibrate
     */
    AudioIDVibrate = 4095
};

///定义结构体
struct SolarTerm {
    __unsafe_unretained NSString * _Nullable solarName;
    int solarDate;
};
/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *   \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *    \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
@interface XLsn0w : NSObject {
    NSArray *HeavenlyStems;//天干表
    NSArray *EarthlyBranches;//地支表
    NSArray *LunarZodiac;//生肖表
    NSArray *SolarTerms;//24节气表
    NSArray *arrayMonth;//农历月表
    NSArray *arrayDay;//农历天表
    
    NSDate *thisdate;
    
    int year;//年
    int month;//月
    int day;//日
    
    int lunarYear;    //农历年
    int lunarMonth;    //农历月
    int doubleMonth;    //闰月
    bool isLeap;      //是否闰月标记
    int lunarDay;    //农历日
    
    struct SolarTerm solarTerm[2];
    
    NSString *yearHeavenlyStem;//年天干
    NSString *monthHeavenlyStem;//月天干
    NSString *dayHeavenlyStem;//日天干
    
    NSString *yearEarthlyBranch;//年地支
    NSString *monthEarthlyBranch;//月地支
    NSString *dayEarthlyBranch;//日地支
    
    NSString *monthLunar;//农历月
    NSString *dayLunar;//农历日
    
    NSString *zodiacLunar;//生肖
    
    NSString *solarTermTitle; //24节气
    
    //added by cyrusleung
    NSMutableArray *holiday;//节日
}

+ (instancetype _Nullable)shared;
+ (NSString *_Nullable)deviceModel;

///截取字符串显示不同颜色
+ (NSMutableAttributedString *)makeRangeWithString:(NSString *)string
                                         textColor:(UIColor *)textColor
                                               loc:(NSUInteger)loc
                                               len:(NSUInteger)len;

///截取字符串显示不同字体
+ (NSMutableAttributedString *)makeRangeWithString:(NSString *)string
                                          textFont:(UIFont *)textFont
                                               loc:(NSUInteger)loc
                                               len:(NSUInteger)len;

///截取字符串显示下划线样式
+ (NSMutableAttributedString *)makeRangeWithString:(NSString *)string
                                   textStyleNumber:(NSNumber *)textStyleNumber
                                               loc:(NSUInteger)loc
                                               len:(NSUInteger)len;

-(void)loadWithDate:(NSDate *_Nullable)date;//加载数据

-(void)InitializeValue;//添加数据
-(int)LunarYearDays:(int)y;
-(int)DoubleMonth:(int)y;
-(int)DoubleMonthDays:(int)y;
-(int)MonthDays:(int)y :(int)m;
-(void)ComputeSolarTerm;

-(double)Term:(int)y :(int)n :(bool)pd;
-(double)AntiDayDifference:(int)y :(double)x;
-(double)EquivalentStandardDay:(int)y :(int)m :(int)d;
-(int)IfGregorian:(int)y :(int)m :(int)d :(int)opt;
-(int)DayDifference:(int)y :(int)m :(int)d;
-(double)Tail:(double)x;

-(NSString *_Nullable)MonthLunar;//农历
-(NSString *_Nullable)DayLunar;//农历日
-(NSString *_Nullable)ZodiacLunar;//年生肖
-(NSString *_Nullable)YearHeavenlyStem;//年天干
-(NSString *_Nullable)MonthHeavenlyStem;//月天干
-(NSString *_Nullable)DayHeavenlyStem;//日天干
-(NSString *_Nullable)YearEarthlyBranch;//年地支
-(NSString *_Nullable)MonthEarthlyBranch;//月地支
-(NSString *_Nullable)DayEarthlyBranch;//日地支
-(NSString *_Nullable)SolarTermTitle;//节气
-(NSMutableArray * _Nullable)Holiday;//节日
-(bool)IsLeap;//是不是农历闰年？？
-(int)GregorianYear;//阳历年
-(int)GregorianMonth;//阳历月
-(int)GregorianDay;//阳历天
-(int)Weekday;//一周的第几天
-(NSString * _Nullable)Constellation;//星座

///JSON 转换成 iOS字典格式
+ (NSDictionary *_Nullable)convertToDictionaryWithJSON:(id _Nullable)JSON;

//字典 转 字符串
+ (NSString *_Nullable)convertToStringWithDictionary:(NSDictionary *_Nullable)dictionary;

//字符串 转 字典
+ (NSDictionary *_Nullable)convertToDictionaryWithString:(NSString *_Nullable)string;

+ (UIImage *_Nonnull)getCustomBundleWithFileName:(NSString *_Nullable)fileName;
+ (UIImage *_Nullable)getCustomBundleWithFileName:(NSString *_Nullable)fileName bundleImageName:(NSString *_Nullable)bundleImageName;
/**
 *  Check the password strength level
 *
 *  @param password Password string
 *
 *  @return Returns the password strength level with value from enum PasswordStrengthLevel
 */
+ (PasswordStrengthLevel)checkPasswordStrength:(NSString * _Nonnull)password;


/**
 *  This class adds some useful methods to play system sounds
 */

/**
 *  Play a system sound from the ID
 *
 *  @param audioID ID of system audio from the AudioID enum
 */
+ (void)playSystemSound:(AudioID)audioID;

/**
 *  Play system sound vibrate
 */
+ (void)playSystemSoundVibrate;

/**
 *  Play custom sound with url
 *
 *  @param soundURL Sound URL
 *
 *  @return Returns the SystemSoundID
 */
+ (SystemSoundID)playCustomSound:(NSURL * _Nonnull)soundURL;

/**
 *  Dispose custom sound
 *
 *  @param soundID SystemSoundID
 *
 *  @return Returns YES if has been disposed, otherwise NO
 */
+ (BOOL)disposeSound:(SystemSoundID)soundID;

+ (NSDictionary * _Nullable)xl_receiveJSONDictionaryWithData:(NSData * _Nullable)data;
+ (NSData * _Nullable)xl_receiveStringDataWithString:(NSString * _Nullable)string encoding:(NSStringEncoding)encoding;
+ (NSString * _Nullable)xl_receiveJSONStringWithDictionary:(NSDictionary * _Nullable)dictionary;

+ (NSString * _Nullable)xl_getNSStringWithNumber:(NSNumber * _Nullable)number;
+ (NSNumber * _Nullable)xl_getNSNumberWithString:(NSString * _Nullable)string;
+ (UIImage * _Nullable)xl_getCompressedImageWithNewSize:(CGSize)newSize currentImage:(UIImage * _Nullable)currentImage;
+ (NSData * _Nullable)xl_getImageDataWithCurrentImage:(UIImage * _Nullable)currentImage;
+ (NSString * _Nullable)xl_getBase64EncodedStringWithCurrentImage:(UIImage * _Nullable)currentImage;
+ (UIImage * _Nullable)xl_getImageWithBase64EncodedString:(NSString * _Nullable)base64EncodedString;
+ (void)xl_showTipText:(NSString * _Nullable)tipText;
+ (void)xl_saveImageToAlbumWithCurrentImage:(UIImage * _Nullable)currentImage;
+ (UIImage * _Nullable)xl_getURLImageWithURLString:(NSString * _Nullable)URLString;
+ (void)xl_getCurrentNavigationController:(UINavigationController * _Nullable)currentNavigationController popToViewControllerAtTargetIndex:(NSUInteger)targetIndex;
+ (NSUInteger)xl_getCurrentIndexWithCurrentNavigationController:(UINavigationController * _Nullable)currentNavigationController currentViewController:(UIViewController * _Nullable)currentViewController;
+ (void)xl_getPhoneNumber:(NSString * _Nullable)phoneNumber currentViewController:(UIViewController * _Nullable)currentViewController;
//手机号码验证
+ (BOOL)xl_isPhoneNumber:(NSString * _Nullable)phoneNumber;
+ (void)xl_showTimeoutWithCurrentSelf:(UIViewController * _Nullable)currentSelf statusCode:(NSInteger)statusCode;

/**************************************************************************************************/
/**
 *  Executes a block on first start of the App for current version.
 *  Remember to execute UI instuctions on main thread
 *
 *  @param block The block to execute, returns isFirstStartForCurrentVersion
 */
+ (void)onFirstStart:(void (^ _Nullable)(BOOL isFirstStart))block;

/**
 *  Executes a block on first start of the App.
 *  Remember to execute UI instuctions on main thread
 *
 *  @param block The block to execute, returns isFirstStart
 */
+ (void)onFirstStartForCurrentVersion:(void (^ _Nullable)(BOOL isFirstStartForCurrentVersion))block;

/**
 *  Executes a block on first start of the App for current given version.
 *  Remember to execute UI instuctions on main thread
 *
 *  @param version Version to be checked
 *  @param block   The block to execute, returns isFirstStartForVersion
 */
+ (void)onFirstStartForVersion:(NSString * _Nonnull)version
                         block:(void (^ _Nullable)(BOOL isFirstStartForCurrentVersion))block;

/**
 *  Returns if is the first start of the App
 *
 *  @return Returns if is the first start of the App
 */
+ (BOOL)isFirstStart;

/**
 *  Returns if is the first start of the App for current version
 *
 *  @return Returns if is the first start of the App for current version
 */
+ (BOOL)isFirstStartForCurrentVersion;

/**
 *  Returns if is the first start of the App for the given version
 *
 *  @param version Version to be checked
 *
 *  @return Returns if is the first start of the App for the given version
 */
+ (BOOL)isFirstStartForVersion:(NSString * _Nonnull)version;

/**
 *  This class adds some useful methods to encrypt/decrypt data.
 *  All methods are static
 */

/**
 *  Create a MD5 string
 *
 *  @param string The string to be converted
 *
 *  @return Returns the MD5 NSString
 */
+ (NSString * _Nullable)MD5:(NSString * _Nonnull)string;

/**
 *  Create a SHA1 string
 *
 *  @param string The string to be converted
 *
 *  @return Returns the SHA1 NSString
 */
+ (NSString * _Nullable)SHA1:(NSString * _Nonnull)string;

/**
 *  Create a SHA256 string
 *
 *  @param string The string to be converted
 *
 *  @return Returns the SHA256 NSString
 */
+ (NSString * _Nullable)SHA256:(NSString * _Nonnull)string;

/**
 *  Create a SHA512 string
 *
 *  @param string The string to be converted
 *
 *  @return Returns the SHA512 NSString
 */
+ (NSString * _Nullable)SHA512:(NSString * _Nonnull)string;


+ (NSString *_Nullable)xl_htmlShuangyinhao:(NSString *_Nullable)values;
+ (UIColor *_Nullable)xl_colorWithHexString:(NSString *_Nullable)stringToConvert;
+ (NSString *_Nullable)xl_nullDefultString:(NSString *_Nullable)fromString null:(NSString *_Nullable)nullStr;

#pragma 正则匹配邮箱号
+ (BOOL)checkMailAccount:(NSString *_Nullable)mail;

#pragma 正则匹配手机号
+ (BOOL)checkPhoneNumber:(NSString *_Nullable)phoneNumber;

#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *_Nullable)password;

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *_Nullable)userName;

#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIDCard: (NSString *_Nullable)IDCard;

#pragma 正则匹配URL
+ (BOOL)checkURL:(NSString *_Nullable)url;

/*****************************************************/

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber:(NSString *_Nullable)number;
#pragma 正则匹配昵称
+ (BOOL)checkNickname:(NSString *_Nullable)nickname;
#pragma 正则匹配以C开头的18位字符
+ (BOOL) checkCtooNumberTo18:(NSString *_Nullable)nickNumber;
#pragma 正则匹配以C开头字符
+ (BOOL) checkCtooNumber:(NSString *_Nullable)nickNumber;
#pragma 正则匹配银行卡号是否正确
+ (BOOL) checkBankNumber:(NSString *_Nullable)bankNumber;
#pragma 正则匹配17位车架号
+ (BOOL) checkCheJiaNumber:(NSString *_Nullable)cheJiaNumber;
#pragma 正则只能输入数字和字母
+ (BOOL) checkTeshuZifuNumber:(NSString *_Nullable)cheJiaNumber;
#pragma 车牌号验证
+ (BOOL)checkCarNumber:(NSString *_Nullable)carNumber;

+ (NSDictionary* _Nullable)dictionaryFromBundleWithName:(NSString * _Nullable)fileName withType:(NSString* _Nullable)typeName;
//字符串MD5转换
+ (NSString * _Nullable)md5HexDigest:(NSString* _Nullable)input;
+ (NSString *_Nullable)fileMd5sum:(NSString * _Nullable)filename; //md5转换

//时间格式
+ (NSDate * _Nullable)getNowTime;
+ (NSString * _Nullable)getyyyymmdd;
+ (NSString * _Nullable)getyyyymmddHHmmss;
+ (NSString * _Nullable)get1970timeString;
+ (NSString * _Nullable)getTimeString:(NSDate * _Nullable)date;
+ (NSString * _Nullable)gethhmmss;

+ (void)showTipsWithHUD:(NSString * _Nullable)labelText;
+ (void)showTipsWithHUD:(NSString * _Nullable)labelText inView:(UIView *_Nullable)inView;
+ (void)showTipsWithView:(UIView * _Nullable)uiview labelText:(NSString *_Nullable)labelText showTime:(CGFloat)time;
+ (void)showHudMessage:(NSString* _Nullable)msg hideAfterDelay:(NSInteger)sec uiview:(UIView *_Nullable)uiview;

//+ (NetworkStatus)getCurrentNetworkStatus;
+ (void)showNotReachabileTips;

+ (NSDate * _Nullable)dateFromString:(NSString * _Nullable)dateString usingFormat:(NSString*_Nullable)format;
+ (NSDate * _Nullable)dateFromString:(NSString * _Nullable)dateString;
+ (NSString * _Nullable)stringFromDate:(NSDate *_Nullable)date;
+ (NSString *_Nullable)stringFromDate:(NSDate *_Nullable)date usingFormat:(NSString*_Nullable)format;

//获取后台服务器主机名
//+(NSString*)readFromUmengOlineHostname;

//loadingView方法集
+(void)addLoadingViewInView:(UIView* _Nullable)viewToLoadData usingUIActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)aStyle;
+(void)removeLoadingViewInView:(UIView* _Nullable)viewToLoadData;
+(void)addLoadingViewInView:(UIView* _Nullable)viewToLoadData usingUIActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)aStyle usingColor:(UIColor *_Nullable)color;
+(void)removeLoadingViewAndLabelInView:(UIView*_Nullable)viewToLoadData;
+(void)addLoadingViewAndLabelInView:(UIView*_Nullable)viewToLoadData usingOrignalYPosition:(CGFloat)yPosition;
+(void)showProgessInView:(UIView * _Nullable)view withExtBlock:(void (^ _Nullable)(void) )exBlock withComBlock:(void (^ _Nullable)(void))comBlock;
+ (UIImage *_Nullable)image:(UIImage *_Nullable)image rotation:(UIImageOrientation)orientation; //图片旋转

//将图片保存到应用程序沙盒中去,imageNameString的格式为 @"upLoad.png"
+ (void)saveImagetoLocal:(UIImage* _Nullable)image imageName:(NSString * _Nullable)imageNameString;
+ (NSString * _Nullable)getDeviceOSType;

//判断字符串长度
+ (int)convertToInt:(NSString* _Nullable)strtemp;
//end

+(NSMutableArray *_Nullable)decorateString:(NSString *_Nullable)string;
//正则表达式部分
+ (BOOL) validateEmail:(NSString *_Nullable)email;
//手机号码验证
+ (BOOL) validateMobile:(NSString *_Nullable)mobile;
//用户名
+ (BOOL) validateUserName:(NSString *_Nullable)name;
//密码
+ (BOOL) validatePassword:(NSString *_Nullable)passWord;
//昵称
+ (BOOL) validateNickname:(NSString *_Nullable)nickname;
//身份证号
+ (BOOL) validateIdentityCard: (NSString *_Nullable)identityCard;
//银行卡
+ (BOOL) validateBankCardNumber: (NSString *_Nullable)bankCardNumber;
//银行卡后四位
+ (BOOL) validateBankCardLastNumber: (NSString *_Nullable)bankCardNumber;
//CVN
+ (BOOL) validateCVNCode: (NSString *_Nullable)cvnCode;
//month
+ (BOOL) validateMonth: (NSString *_Nullable)month;
//year
+ (BOOL) validateYear: (NSString *_Nullable)year;
//verifyCode
+ (BOOL) validateVerifyCode: (NSString *_Nullable)verifyCode;
//压缩图片质量
+(UIImage * _Nullable)reduceImage:(UIImage * _Nullable)image percent:(float)percent;
//压缩图片尺寸
+ (UIImage* _Nullable)imageWithImageSimple:(UIImage*_Nullable)image scaledToSize:(CGSize)newSize;
+ (UIColor * _Nullable) colorWithHexString: (NSString *_Nullable)color;
+ (NSString * _Nullable)documentsDirectoryPath;
/**
 *  返回字符串所占用的尺寸
 *
 *  @param stringFont    字体
 *  @param stringSize 最大尺寸
 */
+ (CGSize)getWidthByString:(NSString* _Nullable)string withFont:(UIFont* _Nullable)stringFont withStringSize:(CGSize)stringSize;
/**
 *  正则表达式验证数字
 */
+ (BOOL)checkNum:(NSString *_Nullable)str;

// View转化为图片
+ (UIImage * _Nullable)getImageFromView:(UIView *_Nullable)view;
// imageView转化为图片
+ (UIImage * _Nullable)getImageFromImageView:(UIImageView *_Nullable)imageView;

+ (NSInteger)getCellMaxNum:(CGFloat)cellHeight maxHeight:(CGFloat)height;//得到tableview最大页数
//匹配数字和英文字母
+ (BOOL) isNumberOrEnglish:(NSString *_Nullable)string;
//匹配数字
+ (BOOL) isKimiNumber:(NSString *_Nullable)number;
//是否存在字段
+ (BOOL)rangeString:(NSString *_Nullable)string searchString:(NSString *_Nullable)searchString;

///文件管理方法
/// 把对象归档存到沙盒里
+(void)saveObject:(id _Nullable)object byFileName:(NSString*_Nullable)fileName;
/// 通过文件名从沙盒中找到归档的对象
+(id _Nullable)getObjectByFileName:(NSString*_Nullable)fileName;

/// 根据文件名删除沙盒中的 plist 文件
+(void)removeFileByFileName:(NSString*_Nullable)fileName;

/// 存储用户偏好设置 到 NSUserDefults
+(void)saveUserData:(id _Nullable)data forKey:(NSString*_Nullable)key;

/// 读取用户偏好设置
+(id _Nullable)readUserDataForKey:(NSString*_Nullable)key;

/// 删除用户偏好设置
+(void)removeUserDataForkey:(NSString*_Nullable)key;

///本地推送方法
+ (NSDate *_Nullable)fireDateWithWeek:(NSInteger)week
                                 hour:(NSInteger)hour
                               minute:(NSInteger)minute
                               second:(NSInteger)second;

//本地发送推送（先取消上一个 再push现在的）
+ (void)localPushForDate:(NSDate *_Nullable)fireDate
                  forKey:(NSString *_Nullable)key
               alertBody:(NSString *_Nullable)alertBody
             alertAction:(NSString *_Nullable)alertAction
               soundName:(NSString *_Nullable)soundName
             launchImage:(NSString *_Nullable)launchImage
                userInfo:(NSDictionary *_Nullable)userInfo
              badgeCount:(NSUInteger)badgeCount
          repeatInterval:(NSCalendarUnit)repeatInterval;

#pragma mark - 退出
+ (void)cancelAllLocalPhsh;

+ (void)cancleLocalPushWithKey:(NSString * _Nullable)key;

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;

- (NSDate * _Nullable)convertDate;

@end
/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *   \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *    \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *   \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *    \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
@interface NSDate (chineseCalendarDate)

/****************************************************
 *@Description:获得NSDate对应的中国日历（农历）的NSDate
 *@Params:nil
 *@Return:NSDate对应的中国日历（农历）的LunarCalendar
 ****************************************************/
- (XLsn0w * _Nullable)chineseCalendarDate;//加载中国农历

@end
/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *   \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *    \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
