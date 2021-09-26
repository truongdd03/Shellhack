# Shellhack 2021 - Nuntinum

This is a ![project](https://youtu.be) created for ShellHacks 2020.

## Inspiration
Reading news in the 4.0 era is very simple. With a reading device connected to the Internet, we easily can access hot news that appears every moment in the world. However, news providers can be any one of us, from a trustworthy news organization to individuals paid to write disingenuous news or heretics damaging the country's government by uploading prejudicial information. 

## What it does
- Nuntium is an open social media, where people from all countries can freely share information in all aspects. However, the correctness of posts is evaluated by our algorithms and other users, preventing fake news. Using a special grading system, user’s reliability will be calculated based on their posts and votes. Deliberately voting can also lead to a decrease in credibility.
- More than just a place for people to discuss, Nuntium also provides a search engine, helping users to evaluate the news by showing similar posts. Just simply enter a rumor that you just heard, we will let you know if it’s true or not.

## How we built it
- The app is based on Firebase to display real-time information. 
- Search engine: To reduce the amount of storage, the Porter Stemmer 2 library is utilized. Words are extracted, indexed, and then stored in an effective way.  

## Accomplishments that we're proud of
- A grading system evaluates the reliability of posts
- A search engine that can return accurate results in "a blink of an eye".

## What's next for Nuntium
- Mini-games for users with high-reliability scores can be added to encourage people to post and vote.
- Instead of just show similar posts, AI can be utilized to answer questions about the credibility of opinions.

## Video walkthrough
![](demo.gif)
