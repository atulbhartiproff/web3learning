//SPDX-License-Identifier:MIT

pragma solidity ^0.8.26;

contract twwt{

    uint16 Max_tweet_length=250;

    struct tweet{
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint128 likes;
    }
    mapping(address => tweet[]) public tweets;
    address public owner;

    constructor(){
        owner=msg.sender;
    }

    event TweetCreated(uint256 id, address author, string content, uint256 timestamp);
    event TweetLiked(address tweetLiker, address tweetauthor, uint256 tweetid, uint256 likecount);
    event TweetdisLiked(address tweetLiker, address tweetauthor, uint256 tweetid, uint256 likecount);


    modifier  onlyOwner()  {
        require(msg.sender== owner, "You are not the owner");
        _;
    }

    function changeTweetLength(uint16 newTweetLength) public onlyOwner(){
        Max_tweet_length=newTweetLength;
    }

    function createTweet(string memory _tweet) public{
        
        require(bytes(_tweet).length<=Max_tweet_length,"Tweet is too long broski");

        tweet memory newtweet= tweet({
            id:tweets[msg.sender].length,
            author:msg.sender,
            content:_tweet,
            timestamp: block.timestamp,
            likes:0
        });
        
        tweets[msg.sender].push(newtweet);
        emit TweetCreated(newtweet.id, newtweet.author, newtweet.content, newtweet.timestamp);
    }

    function Like(address author, uint256 id) external {
        require(tweets[author][id].id==id, "Tweet NOT IN EXISTENCE");
        tweets[author][id].likes++;
        emit TweetLiked(msg.sender, author, id, tweets[author][id].likes);
    }

    function unLike(address author, uint256 id) external {
        require(tweets[author][id].id==id, "Tweet NOT IN EXISTENCE");
        require(tweets[author][id].likes>0, "Tweet does not have enough likes to dislike");
        tweets[author][id].likes--;
        emit TweetdisLiked(msg.sender, author, id, tweets[author][id].likes);
    }

    function getTweet(uint _i) public view returns (tweet memory) {
        return tweets[msg.sender][_i];
    }

    function getallTweets() public view returns(tweet[]  memory) {
        return tweets[msg.sender];
    }
}