import MixboxUiKit

public final class SwipeAction: ElementInteraction {
    private let swipeActionPathCalculator: SwipeActionPathCalculator
    private let swipeActionDescriptionProvider: SwipeActionDescriptionProvider
    
    public init(
        startPoint: SwipeActionStartPoint,
        endPoint: SwipeActionEndPoint,
        speed: TouchActionSpeed?)
    {
        let swipeActionPathSettings = SwipeActionPathSettings(
            startPoint: startPoint,
            endPoint: endPoint,
            speed: speed
        )
        
        self.swipeActionPathCalculator = SwipeActionPathCalculator(
            swipeActionPathSettings: swipeActionPathSettings
        )
        
        self.swipeActionDescriptionProvider = SwipeActionDescriptionProvider(
            swipeActionPathSettings: swipeActionPathSettings
        )
    }
    
    public func with(
        dependencies: ElementInteractionDependencies)
        -> ElementInteractionWithDependencies
    {
        return WithDependencies(
            dependencies: dependencies,
            swipeActionPathCalculator: swipeActionPathCalculator,
            swipeActionDescriptionProvider: swipeActionDescriptionProvider
        )
    }
    
    public final class WithDependencies: ElementInteractionWithDependencies {
        private let dependencies: ElementInteractionDependencies
        private let swipeActionPathCalculator: SwipeActionPathCalculator
        private let swipeActionDescriptionProvider: SwipeActionDescriptionProvider
        
        public init(
            dependencies: ElementInteractionDependencies,
            swipeActionPathCalculator: SwipeActionPathCalculator,
            swipeActionDescriptionProvider: SwipeActionDescriptionProvider)
        {
            self.dependencies = dependencies
            self.swipeActionPathCalculator = swipeActionPathCalculator
            self.swipeActionDescriptionProvider = swipeActionDescriptionProvider
        }
    
        public func description() -> String {
            return swipeActionDescriptionProvider.swipeActionDescription(
                elementName: dependencies.elementInfo.elementName
            )
        }
        
        public func interactionFailureShouldStopTest() -> Bool {
            return true
        }
        
        public func perform() -> InteractionResult {
            return dependencies.interactionRetrier.retryInteractionUntilTimeout {
                // Unfortunately either the line will be long, either this rule will be violated:
                // swiftlint:disable:next closure_parameter_position
                [dependencies, swipeActionPathCalculator] _ in

                dependencies.interactionResultMaker.makeResultCatchingErrors {
                    try dependencies.snapshotResolver.resolve { elementSnapshot in
                        let path = swipeActionPathCalculator.path(elementSnapshot: elementSnapshot)

                        return dependencies.interactionResultMaker.makeResultCatchingErrors {
                            dependencies.retriableTimedInteractionState.markAsImpossibleToRetry()
                            
                            try dependencies.eventGenerator.pressAndDrag(
                                from: path.startPoint,
                                to: path.endPoint,
                                durationOfInitialPress: 0,
                                velocity: path.velocity,
                                cancelInertia: false
                            )
                            
                            return .success
                        }
                    }
                }
            }
        }
    }
}
