# FoodMob
Eating out with friends made easy.  This is the iOS portion of the application.  The backend server is in \[repo not yet specified\]

# Build Requirements
* Xcode 7.2 with iOS 9.2 SDK
    * Current Swift version: 2.1.1
    * Targeted iOS version: 9.1
* Homebrew ([http://brew.sh](http://brew.sh))
* Carthage ([GitHub](https://github.com/Carthage/Carthage))

# Getting Started
1. Install the two command line tools you will need if you don't have them:

    * [Homebrew](http://brew.sh)
    * Carthage using Homebrew:

        ```
        brew update
        brew install carthage
        ```

2. In this project directory, run

    ```
    carthage bootstrap
    ```
    
    This installs the library dependencies needed for this application.
3. Open the `FoodMob.xcproject` file using Xcode.
4. In the top bar, the scheme should be set to FoodMob, and the destination should be a simulator or device (i.e, not "Generic iOS Device").
5. Click the ▶️ Run button in Xcode.

# Adding new libraries
Please follow these procedures for adding new libraries.

1. Libraries must be licensed permissively.  No GPL/LGPL crap.  MIT and Apache are good ones.
2. Libraries should be available as a framework (dynamic library).
4. Libraries should be approved by Jonathan (@jonjesbuzz).  Open a GitHub issue or contact him on Slack.
5. Libraries should be available to download using [Carthage](https://github.com/Carthage/Carthage).
5. It would be nice if the library is written in Swift. (This effectively requires #2 for technical reasons.)  Objective-C libraries are allowed, but Swift libraries tend to be nicer to work with in Swift (obviously) and tend to be more modern.