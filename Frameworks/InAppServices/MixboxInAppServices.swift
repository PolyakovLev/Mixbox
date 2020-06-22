#if MIXBOX_ENABLE_IN_APP_SERVICES

import MixboxIpc
import MixboxIpcCommon
import Foundation
import UIKit

// Facade for starting everything for tests, on the side of the app.
public final class MixboxInAppServices: IpcMethodHandlerWithDependenciesRegisterer {
    // Dependencies
    private let inAppServicesDependenciesFactory: InAppServicesDependenciesFactory
    
    // State
    private var router: IpcRouter?
    private var client: IpcClient?
    private var commandsForAddingRoutes: [IpcMethodHandlerRegistrationTypeErasedClosure] = []
    
    public init(inAppServicesDependenciesFactory: InAppServicesDependenciesFactory) {
        self.inAppServicesDependenciesFactory = inAppServicesDependenciesFactory
        
        self.commandsForAddingRoutes = [
            { [inAppServicesDependenciesFactory] dependencies in
                MixboxInAppServices.registerDefaultMethods(
                    router: dependencies.ipcRouter,
                    inAppServicesDependenciesFactory: inAppServicesDependenciesFactory
                )
            }
        ]
    }
    
    public func register<MethodHandler: IpcMethodHandler>(closure: @escaping IpcMethodHandlerRegistrationClosure<MethodHandler>) {
        if let router = router {
            let dependencies = IpcMethodHandlerRegistrationDependencies(
                ipcRouter: router,
                ipcClient: client,
                synchronousIpcClient: client.map {
                    inAppServicesDependenciesFactory.synchronousIpcClientFactory.synchronousIpcClient(ipcClient: $0)
                }
            )
            
            router.register(
                methodHandler: closure(dependencies)
            )
        } else {
            commandsForAddingRoutes.append({ dependencies in
                dependencies.ipcRouter.register(
                    methodHandler: closure(dependencies)
                )
            })
        }
    }
    
    public func start() -> (IpcRouter, IpcClient?) {
        assert(self.router == nil, "MixboxInAppServices are already started")
        
        do {
            let (router, client) = try inAppServicesDependenciesFactory.ipcStarter.start(
                commandsForAddingRoutes: commandsForAddingRoutes
            )
            
            self.router = router
            self.client = client
            
            try inAppServicesDependenciesFactory.accessibilityEnhancer.enhanceAccessibility()
            
            inAppServicesDependenciesFactory.scrollViewIdlingResourceSwizzler.swizzle()
            inAppServicesDependenciesFactory.uiAnimationIdlingResourceSwizzler.swizzle()
            inAppServicesDependenciesFactory.viewControllerIdlingResourceSwizzler.swizzle()
            inAppServicesDependenciesFactory.coreAnimationIdlingResourceSwizzler.swizzle()
            
            let mixboxUrlProtocolBootstrapper = client.flatMap { client in
                inAppServicesDependenciesFactory.mixboxUrlProtocolBootstrapper(
                    ipcRouter: router,
                    ipcClient: client
                )
            }
            
            mixboxUrlProtocolBootstrapper?.bootstrapNetworkMocking()
            
            commandsForAddingRoutes = []
            
            return (router, client)
        } catch {
            // TODO: Better error handling for tests (fail test instead of crashing app)
            preconditionFailure(String(describing: error))
        }
    }

    private static func registerDefaultMethods(
        router: IpcRouter,
        inAppServicesDependenciesFactory: InAppServicesDependenciesFactory)
    {
        router.register(methodHandler: ScrollingHintIpcMethodHandler())
        router.register(methodHandler: PercentageOfVisibleAreaIpcMethodHandler())
        router.register(
            methodHandler: ViewHierarchyIpcMethodHandler(
                viewHierarchyProvider: ViewHierarchyProviderImpl(
                    applicationWindowsProvider: UiApplicationWindowsProvider(
                        uiApplication: UIApplication.shared,
                        iosVersionProvider: inAppServicesDependenciesFactory.iosVersionProvider
                    ),
                    floatValuesForSr5346Patcher: FloatValuesForSr5346PatcherImpl(
                        iosVersionProvider: inAppServicesDependenciesFactory.iosVersionProvider
                    )
                )
            )
        )
        
        router.register(methodHandler: OpenUrlIpcMethodHandler())
        
        router.register(methodHandler: PushNotificationIpcMethodHandler())
        
        router.register(methodHandler: SimulateLocationIpcMethodHandler())
        router.register(methodHandler: StopLocationSimulationIpcMethodHandler())
        
        router.register(
            methodHandler: InjectKeyboardEventsIpcMethodHandler(
                keyboardEventInjector: inAppServicesDependenciesFactory.keyboardEventInjector
            )
        )
        
        router.register(methodHandler: GetPasteboardStringIpcMethodHandler())
        router.register(methodHandler: SetPasteboardStringIpcMethodHandler())
    }
}

#endif
