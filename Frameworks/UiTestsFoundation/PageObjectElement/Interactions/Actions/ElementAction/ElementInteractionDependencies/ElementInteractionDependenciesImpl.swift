import MixboxFoundation
import MixboxTestsFoundation
import MixboxIpcCommon

public final class ElementInteractionDependenciesImpl: ElementInteractionDependencies {
    public let snapshotResolver: SnapshotForInteractionResolver
    public let textTyper: TextTyper
    public let menuItemProvider: MenuItemProvider
    public let keyboardEventInjector: SynchronousKeyboardEventInjector
    public let pasteboard: Pasteboard
    public let interactionPerformer: NestedInteractionPerformer
    public let elementSimpleGesturesProvider: ElementSimpleGesturesProvider
    public let eventGenerator: EventGenerator
    public let interactionRetrier: InteractionRetrier
    public let interactionResultMaker: InteractionResultMaker
    public let elementMatcherBuilder: ElementMatcherBuilder
    public let elementInfo: HumanReadableInteractionDescriptionBuilderSource
    public let retriableTimedInteractionState: RetriableTimedInteractionState
    public let signpostActivityLogger: SignpostActivityLogger
    public let applicationQuiescenceWaiter: ApplicationQuiescenceWaiter
    
    public init(
        snapshotResolver: SnapshotForInteractionResolver,
        textTyper: TextTyper,
        menuItemProvider: MenuItemProvider,
        keyboardEventInjector: SynchronousKeyboardEventInjector,
        pasteboard: Pasteboard,
        interactionPerformer: NestedInteractionPerformer,
        elementSimpleGesturesProvider: ElementSimpleGesturesProvider,
        eventGenerator: EventGenerator,
        interactionRetrier: InteractionRetrier,
        interactionResultMaker: InteractionResultMaker,
        elementMatcherBuilder: ElementMatcherBuilder,
        elementInfo: HumanReadableInteractionDescriptionBuilderSource,
        retriableTimedInteractionState: RetriableTimedInteractionState,
        signpostActivityLogger: SignpostActivityLogger,
        applicationQuiescenceWaiter: ApplicationQuiescenceWaiter)
    {
        self.snapshotResolver = snapshotResolver
        self.textTyper = textTyper
        self.menuItemProvider = menuItemProvider
        self.keyboardEventInjector = keyboardEventInjector
        self.pasteboard = pasteboard
        self.interactionPerformer = interactionPerformer
        self.elementSimpleGesturesProvider = elementSimpleGesturesProvider
        self.eventGenerator = eventGenerator
        self.interactionRetrier = interactionRetrier
        self.interactionResultMaker = interactionResultMaker
        self.elementMatcherBuilder = elementMatcherBuilder
        self.elementInfo = elementInfo
        self.retriableTimedInteractionState = retriableTimedInteractionState
        self.signpostActivityLogger = signpostActivityLogger
        self.applicationQuiescenceWaiter = applicationQuiescenceWaiter
    }
}
