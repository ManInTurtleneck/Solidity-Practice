// SPDX-License-Identifier: MIT

// 1️⃣ Add a function called changeTweetLength to change max tweet length
// HINT: use newTweetLength as input for function
// 2️⃣ Create a constructor function to set an owner of contract
// 3️⃣ Create a modifier called onlyOwner
// 4️⃣ Use onlyOwner on the changeTweetLength function

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
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);

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