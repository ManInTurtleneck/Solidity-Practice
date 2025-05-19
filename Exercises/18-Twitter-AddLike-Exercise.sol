// SPDX-License-Identifier: MIT

// 1️⃣ Add id to Tweet Struct to make every Tweet Unique
// 2️⃣ Set the id to be the Tweet[] length 
// HINT: you do it in the createTweet function
// 3️⃣ Add a function to like the tweet
// HINT: there should be 2 parameters, id and author
// 4️⃣ Add a function to unlike the tweet
// HINT: make sure you can unlike only if likes count is greater then 0
// 4️⃣ Mark both functions external

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

    }

    function likeTweet(address author, uint256 id) external {
        require(tweets[author][id].id == id, "tweet unavailable");
        tweets[author][id].likes++;

    }

    function unlikeTweet(address author, uint256 id) external {
        require(tweets[author][id].id == id, "tweet unavailable");
        require(tweets[author][id].likes > 0, "Likes already 0");
        tweets[author][id].likes--;

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