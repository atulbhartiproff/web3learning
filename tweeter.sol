//SPDX-License-Identifier:MIT

pragma solidity ^0.8.26;

contract twwt{

    uint16 constant Max_tweet_length=250;

    struct tweet{
        address author;
        string content;
        uint256 timestamp;
        uint128 likes;
    }
    mapping(address => tweet[]) public tweets;
    
    function createTweet(string memory _tweet) public{
        
        require(bytes(_tweet).length<=Max_tweet_length,"Tweet is too long broski");

        tweet memory newtweet= tweet({
            author:msg.sender,
            content:_tweet,
            timestamp: block.timestamp,
            likes:0
        });
        
        tweets[msg.sender].push(newtweet);
    }

    function getTweet(uint _i) public view returns (tweet memory) {
        return tweets[msg.sender][_i];
    }

    function getallTweets() public view returns(tweet[]  memory) {
        return tweets[msg.sender];
    }
}