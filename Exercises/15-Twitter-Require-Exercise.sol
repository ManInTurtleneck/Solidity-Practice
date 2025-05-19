// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// 1️⃣  Use require to limit the length of the tweet to be only 280 characters
// HINT: use bytes to length of tweet

contract Twitter {

    uint16 constant MAX_TWEET_LENGTH = 280;

    // define our struct
    struct tweet{
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    // add our code
    mapping(address => tweet[]) public tweets;

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

}