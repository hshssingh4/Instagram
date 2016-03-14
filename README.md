# Project 6 - *Instagram*

**Instagram** is a photo sharing app using Parse as its backend.

Time spent: **30-35** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign up to create a new account using Parse authentication
- [x] User can log in and log out of his or her account
- [x] The current signed in user is persisted across app restarts
- [x] User can take a photo, add a caption, and post it to "Instagram"
- [x] User can view the last 20 posts submitted to "Instagram"

The following **optional** features are implemented:

- [x] Show the username and creation time for each post
- [x] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse.
- [x] User Profiles:
   - [x] Allow the logged in user to add a profile photo
   - [x] Display the profile photo with each post
   - [x] Tapping on a post's username or profile photo goes to that user's profile page

The following **additional** features are implemented:

- [x] On tapping the sign up button, user is presented with a new view controller where the user needs to provide first name, last name, username, and password in order to create a new "Instagram" account!
- [x] If the user doesn't enter the correct sign up information, an error message is displayed using UIAlertController to notify user about the issues.
- [x] While signing in, if the user enters incorrect login info., he/she is notified by a shake gesture of the text fields.
- [x] Swipe Down and tap gestures added throughout the app to help user dismiss the keyboard.
- [x] On the home screen, user can delete any post by a left swipe and a tap on the delete button.
- [x] Apart from adding a profile picture, user can also add a cover photo!
- [x] A collection view is displayed on the user profile screen to display all the posts posted by that particular user.
- [x] Tapping on an image in the user profile lets the user view that image in fullscreen with the capabilities to zoom in and out! 
- [x] Alert View Controllers used throughout the app (eg. to log out, to view/change a profile picture etc.) provding user with a "confirm-choice" functionality!
- [x] Full Proof Design implemented. That is, user is only allowed to use controls only when those controls are applicable. For eg. the "Post" button only appears when a user has uploaded/taken an image.  
- [x] There are many more that if I start listing, I would be doing injustice to the users. Please use the app yourself and have fun! :)

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. AutoLayout!
2. Getting PF user using the username from Parse!

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/KSER2lo.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Enjoyed building it! Not many challenges except few minor ones! :)

## License

    Copyright [2016] [Harpreet Singh]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
