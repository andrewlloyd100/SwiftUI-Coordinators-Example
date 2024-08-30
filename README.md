# SwiftUICoordinators

This demo application shows how you can use the coordinator pattern within a SwiftUI app. It is a project with a coordinator & three simple separate screens that can navigate amongst each other. 

## The Coordinator

The coordinator consists of a `CoordinatorModel` class & a `Coordinator` view which acts as the root view of the app.
The coordinator model handles all the navigation logic for the entire application amongst all screens. 

It has a `Destination` enum which covers every possible state that the coordinator can navigate to. These enum values can also have associated properties such as view models if required.
```swift
    enum Destination: Hashable {
        case bScreen(ScreenBViewModel)
        case cScreen
    }
```

We then have a published property of an array of `Destination` values. This acts as the route or the stack the navigation stack will bind to.
```swift
    @Published var path: [Destination] = []
```

Lastly the `CoordinatorModel` needs a `rootViewModel` property. This will be the root view model that the navigation stacks root view requires. Every coordinator will have one of these as every stack has to start somewhere!
```swift
    let rootViewModel: ScreenAViewModel
```


## The Destinations

Each screen has a view and a view model. Any view model that requires navigation, tells the coordinator to handle that via a delegate set onto the viewModel. Navigation is all then handled within the coordinator instead of screens individual view models. This could also be done with closures instead of delegates if preferred. 

When the coordinator is called with the delgate method to handle navigation, it can append to the path the required destination, along with any view model required. The change of the path property will then be observed by the `NavigationStack` and the view associated with that destination type will be pushed onto the stack.

```swift
    func goToB() {
        let bViewModel = ScreenBViewModel()
        bViewModel.delegate = self
        path.append(Destination.bScreen(bViewModel))
    }
```

```swift
    struct Coordinator: View {
        @ObservedObject var coordinatorModel: CoordinatorModel
        
        var body: some View {
            NavigationStack(path: self.$coordinatorModel.path) {
                ScreenA(viewModel: coordinatorModel.rootViewModel)
                    .navigationDestination(for: CoordinatorModel.Destination.self) { destination in
                    switch destination {
                    case let .bScreen(model):
                        ScreenB(viewModel: model)
                    case .cScreen:
                        ScreenC()
                    }
                    }
                    .navigationTitle("SwiftUI Coordinators")
            }
        }
    }
```

## The Payoff

The main advantage to this approach is it gives us a single source of truth for state. We can write tests on the navigation and check the coordinators state at anytime to know exactly what is shown and what is in the navigation stack. Check out the test in the demo project for an example!

It separates all navigation code out of any individual view model/view making views more reusable meaning any view can be interchanged to be a root view or presented easily anywhere. In our example we can navigate from A > B > C or straight from A > C. This allows the navigation for the push of C to use the same coordinator code. 

It also allows code to be understood easier, to have navigation for a whole section of your application handled in a single place away from other logic views may have makes it easier to follow and get a grasp of exactly where and what that navigation stack can show.

This was heavily inspired by point free navigation in the episode [here](https://pointfree.co/episodes/ep213-swiftui-navigation-stacks). I highly recommend it if interested in using this approach.
