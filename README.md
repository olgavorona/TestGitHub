# TestGitHub

Test assigment.

**Requirements**

- Build a native mobile app for Github using Github API
- Ability to search for repositories via Github API similarly to how Github web UI search works, display search results and be able to view repository details such as stars, author and created date
- A screen with most popular Swift repositories for the last month, week and day

🔗 External dependencies
--------------------------
[GitHub Search API](https://docs.github.com/en/free-pro-team@latest/rest/reference/search)

[External  Trending API for GitHub](https://github.com/xxdongs/github-trending)

[Progress HUD](https://github.com/pkluz/PKHUD)

🛠 How to build
 --------------------------
The project was build with:

>**Xcode 12.2**
>
>**СocoaPods 1.9.3**

Run in terminal
`pod install`

Supported devices:
>**iOS 11+**


👨‍💻 Project structure
 --------------------------
 All source code is in the Sources.

 The service folder is for Networking. Networking is built with URLSession.

 UI folder is for screens. UI is built with Autolayout. UI Modules contains only View Controller, Presenter, and Protocols for their communication

 Common Folder contains helpers.


📱 Demo
 --------------------------
 ![](README-images/demo.gif)


🔘 Afterthoughts
--------------------------
It was built in 7 hours including research time. The main issue was Trending API because there is no native API from GitHub. 
I found the most popular API https://github.com/huchenme/github-trending-api, but it is down for the past two months.
So, in the end, I use the working one, but not popular.

I added zero screens, progressHUD, search delay, and error processing, so the UX looks minimalistic and friendly.
I also added an ability to open repo, so the demo app looks more like a real app.

If I had more time I would add:
- Pagination for search
- Service Provider, so all networking request will be short and without copy-paste code
- Different layout for trending cell, so I can see additional stars
- Filter for the search screen(not in the MVP)

