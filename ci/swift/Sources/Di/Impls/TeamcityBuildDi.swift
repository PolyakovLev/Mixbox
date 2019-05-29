import Dip
import Tasks

public final class TeamcityBuildDi: CommonDi {
    public override init() {
    }
    
    override public func registerAll(container: DependencyContainer) {
        super.registerAll(container: container)
        
        container.register(type: LocalTaskExecutor.self) {
            TeamcityLocalTaskExecutor()
        }
    }
}
