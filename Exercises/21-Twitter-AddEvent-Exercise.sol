// SPDX-License-Identifier: MIT

// 1️⃣ Create Event for creating the tweet, called TweetCreated ✅
// USE parameters like id, author, content, timestamp
// 2️⃣ Emit the Event in the createTweet() function below  ✅
// 3️⃣ Create Event for liking the tweet, called TweetLiked ✅ 
// USE parameters like liker, tweetAuthor, tweetId, newLikeCount
// 4️⃣ Emit the event in the likeTweet() function below  ✅

pragma solidity ^0.8.0;

contract Twitter {

    /* initialization */
    uint16 public MAX_TWEET_LENGTH = 280;
    address public owner;

    // definitions
    // define constructor
    constructor() {
        owner = msg.sender;
    }

    // define our struct
    struct tweet{
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;

    }

    // define mapping
    mapping(address => tweet[]) public tweets;

    // define modifier
    modifier onlyOwner() {
        require(msg.sender == owner, "You're not the owner");
        _;
    }

    // define events
    event tweetCreated(uint256 id, address author, string content, uint256 timestamp);
    event tweetLiked(address liker, address author, uint256 id, uint256 likes);
    event tweetUnliked(address unliker, address author, uint256 id, uint256 likes);

    /* end of initialization */



    // main

    function createTweet(string memory _tweet) public {
        // conditional
        // if tweet length <= MAX_TWEET_LENGTH continue, else, revert
        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Tweet too long");


        tweet memory newTweet = tweet({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);

        emit tweetCreated(newTweet.id, newTweet.author, newTweet.content, newTweet.timestamp);

    }

    function likeTweet(address author, uint256 id) external {
        require(tweets[author][id].id == id, "tweet unavailable");
        tweets[author][id].likes++;

        emit tweetLiked(msg.sender, author, id, tweets[author][id].likes);

    }

    function unlikeTweet(address author, uint256 id) external {
        require(tweets[author][id].id == id, "tweet unavailable");
        require(tweets[author][id].likes > 0, "Likes already 0");
        tweets[author][id].likes--;

        emit tweetLiked(msg.sender, author, id, tweets[author][id].likes);

    }

    function getTweet(uint _i) public view returns (tweet memory){
        return tweets[msg.sender][_i];

    }

    function getAllTweets(address _owner) public view returns (tweet[] memory){
        return tweets[_owner];

    }

    function changeTweetLength(uint16 newTweetLength) public onlyOwner{
        MAX_TWEET_LENGTH = newTweetLength;
    }

}


