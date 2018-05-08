/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/

#import "UIViewController+AddIsAutorotate.h"
#import <objc/runtime.h>

@implementation UIViewController (AddIsAutorotate)

//添加属性get方法
- (BOOL)isAutorotate {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

//添加属性set方法
- (void)setIsAutorotate:(BOOL)isAutorotate {
    objc_setAssociatedObject(self, @selector(isAutorotate), @(isAutorotate), OBJC_ASSOCIATION_ASSIGN);
}

@end

/*      Aspects
 
+ (void)load {
    /// 为一个指定的类的某个方法执行前/替换/后,添加一段代码块.对这个类的所有对象都会起作用.
    ///
    /// @param block  方法被添加钩子时,Aspectes会拷贝方法的签名信息.
    /// 第一个参数将会是 `id<AspectInfo>`,余下的参数是此被调用的方法的参数.
    /// 这些参数是可选的,并将被用于传递给block代码块对应位置的参数.
    /// 你甚至使用一个没有任何参数或只有一个`id<AspectInfo>`参数的block代码块.
    ///
    /// @注意 不支持给静态方法添加钩子.
    /// @return 返回一个唯一值,用于取消此钩子.
    
    [UIViewController aspect_hookSelector:@selector(viewDidLoad)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> info) {
                                   [[info instance] aspect_hookSelector:@selector(prepareForSegue:sender:)
                                                            withOptions:AspectPositionBefore
                                                             usingBlock:^(id<AspectInfo> aspectInfo){
                                                                 UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
                                                                 returnButtonItem.title = @"";
                                                                 [(UIViewController *)[aspectInfo instance] navigationItem].backBarButtonItem = returnButtonItem;
                                                             }
                                                                  error:NULL];
                               }
                                    error:NULL];
}
*/

/// 为一个指定的类的某个方法执行前/替换/后,添加一段代码块.对这个类的所有对象都会起作用.
///
/// @param block  方法被添加钩子时,Aspectes会拷贝方法的签名信息.
/// 第一个参数将会是 `id<AspectInfo>`,余下的参数是此被调用的方法的参数.
/// 这些参数是可选的,并将被用于传递给block代码块对应位置的参数.
/// 你甚至使用一个没有任何参数或只有一个`id<AspectInfo>`参数的block代码块.
///
/// @注意 不支持给静态方法添加钩子.
/// @return 返回一个唯一值,用于取消此钩子.
//+ (id<AspectToken>)aspect_hookSelector:(SEL)selector
//                           withOptions:(AspectOptions)options
//                            usingBlock:(id)block
//                                 error:(NSError **)error;

/// 为一个指定的对象的某个方法执行前/替换/后,添加一段代码块.只作用于当前对象.
//- (id<AspectToken>)aspect_hookSelector:(SEL)selector withOptions:(AspectOptions)options usingBlock:(id)block error:(NSError **)error; - (id<AspectToken>)aspect_hookSelector:(SEL)selector withOptions:(AspectOptions)options usingBlock:(id)block error:(NSError **)error;
/// 撤销一个Aspect 钩子.
/// @return YES 撤销成功, 否则返回 NO.
//id<AspectToken> aspect = ...;
//[aspect remove];

//所有的调用,都会是线程安全的.Aspects 使用了Objective-C 的消息转发机会,会有一定的性能消耗.所有对于过于频繁的调用,不建议使用 Aspects.Aspects更适用于视图/控制器相关的等每秒调用不超过1000次的代码.

//可以在调试应用时,使用Aspects动态添加日志记录功能.
//
//[UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {
//    NSLog(@"控制器 %@ 将要显示: %tu", aspectInfo.instance, animated);
//} error:NULL];
//使用它,分析功能的设置会很简单:
//https://github.com/orta/ARAnalytics
//
//你可以在你的测试用例中用它来检查某个方法是否被真正调用(当涉及到继承或类目扩展时,很容易发生某个父类/子类方法未按预期调用的情况):
//
//- (void)testExample {
//    TestClass *testClass = [TestClass new];
//    TestClass *testClass2 = [TestClass new];
//    
//    __block BOOL testCallCalled = NO;
//    [testClass aspect_hookSelector:@selector(testCall) withOptions:AspectPositionAfter usingBlock:^{
//        testCallCalled = YES;
//    } error:NULL];
//    
//    [testClass2 testCallAndExecuteBlock:^{
//        [testClass testCall];
//    } error:NULL];
//    XCTAssertTrue(testCallCalled, @"调用testCallAndExecuteBlock 必须调用 testCall");
//}
//它对调试应用真的会提供很大的作用.这里我想要知道究竟何时轻击手势的状态发生变化(如果是某个你自定义的手势的子类,你可以重写setState:方法来达到类似的效果;但这里的真正目的是,捕捉所有的各类控件的轻击手势,以准确分析原因):
//
//[_singleTapGesture aspect_hookSelector:@selector(setState:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
//    NSLog(@"%@: %@", aspectInfo.instance, aspectInfo.arguments);
//} error:NULL];
//下面是一个你监测一个模态显示的控制器何时消失的示例.通常,你也可以写一个子类,来实现相似的效果,但使用 Aspects 可以有效减小你的代码量:
//
//@implementation UIViewController (DismissActionHook)
//
//// Will add a dismiss action once the controller gets dismissed.
//- (void)pspdf_addWillDismissAction:(void (^)(void))action {
//    PSPDFAssert(action != NULL);
//    
//    [self aspect_hookSelector:@selector(viewWillDisappear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
//        if ([aspectInfo.instance isBeingDismissed]) {
//            action();
//        }
//    } error:NULL];
//}
//
//@end
//
//
//在返回值不为void的方法上使用 Aspects
//
//你可以使用 NSInvocation 对象类自定义返回值:
//
//[PSPDFDrawView aspect_hookSelector:@selector(shouldProcessTouches:withEvent:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info, NSSet *touches, UIEvent *event) {
//    // 调用方法原来的实现.
//    BOOL processTouches;
//    NSInvocation *invocation = info.originalInvocation;
//    [invocation invoke];
//    [invocation getReturnValue:&processTouches];
//    
//    if (processTouches) {
//        processTouches = pspdf_stylusShouldProcessTouches(touches, event);
//        [invocation setReturnValue:&processTouches];
//    }
//} error:NULL];
//兼容性与限制
//当应用于某个类时(使用类方法添加钩子),不能同时hook父类和子类的同一个方法;否则会引起循环调用问题.但是,当应用于某个类的示例时(使用实例方法添加钩子),不受此限制.
//使用KVO时,最好在 aspect_hookSelector: 调用之后添加观察者;否则可能会引起崩溃.







