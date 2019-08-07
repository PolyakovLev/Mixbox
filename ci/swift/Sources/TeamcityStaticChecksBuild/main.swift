import BuildDsl
import StaticChecksTask

BuildDsl.teamcity.main { di in
    try StaticChecksTask(
        swiftLint: SwiftLintImpl(
            processExecutor: di.resolve(),
            repoRootProvider: di.resolve()
        )
    )
}
