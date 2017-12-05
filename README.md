# React Swift webview 

## Very WIP

## What is this?

This is a project built off of what was previously my [Swift iOS web hybrid template](https://github.com/WillsonSmith/Swift-iOS-web-hybrid-template) that allowed you to use a webview, but call native code with JavaScript.

This updates the project to swift 4, and adds some cleanups done in my macOS version. 

## Getting it running
This is in very early phases, but if you would like to try it out you can use the following steps:
1. Clone the repo somewhere exciting like `~/documents/the-best-project-in-the-world`
2. Make sure you have yarn or npm installed, whichever your heart desires
4. Skip the number 3
5. In your terminal, navigate to `react-swift-ios/web_root/react-swift-webview`
6. run `yarn run start` or `npm run start`
7. Open the xcode project and click run

By default the project is set to go to `localhost:3000`, which should be the default output of `start`.

The demo app should appear.

JS -> Swift -> JS related code exists in `src/swift_specifics/globals.ts` right now.
