// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Board is Ownable {
    mapping(uint => address) private postAuthors;
    mapping(uint => uint) private shareBounties;
    mapping(address => uint) private earnings;

    modifier requireValue() {
        require(msg.value > 0);
        _;
    }

    modifier requireEarnings() {
        require(earnings[msg.sender] > 0);
        _;
    }

    event Received(address, uint);
    event PostedText(uint indexed postId, address indexed author, string content);
    event Shared(uint indexed postId, address indexed sharer);
    event Tipped(uint indexed postId, address indexed tipper, uint amount);
    event Collected(address, uint);

    receive() external payable {}

    // Counters
    using Counters for Counters.Counter;
    Counters.Counter private postCounter;
    function genid() private returns (uint) {
        uint id = postCounter.current();
        postCounter.increment();
        return id;
    }

    // Posting
    function postText(string calldata content) public payable {
        uint id = genid();
        postAuthors[id] = msg.sender;
        if (msg.value > 0) {
            // A post submitted with some ETH puts that ETH as a share bounty.
            // Others who share this post will claim some of that bounty.
            shareBounties[id] = msg.value;
        }
        emit PostedText(id, msg.sender, content);
    }

    // Sharing
    //
    // Likely to be reworked into a more meaningful system...
    // Currently we just give a portion of the bounty to anyone who
    // shares a post, but that's not great.
    //
    // Better would be to track a graph of shares, and reward the people
    // who lead to more views/likes/shares down the line. Would require
    // a "campaign" to be started with a bounty and a length, and then
    // the bounty is distributed to the sharers at the end of the campaign
    // duration.
    function bounty(uint postId) public view returns (uint) {
        return shareBounties[postId];
    }

    function addBounty(uint postId) public payable requireValue {
        shareBounties[postId] += msg.value;
    }

    function sharePost(uint postId) public {
        if (shareBounties[postId] > 0) {
            // Somewhat arbitrarily, the sharer receives 1/4 of the remaining share bounty.
            // This way it kinda never runs out, but also the rewards are somewhat decent
            // for the earlier shares and eventually most of the bounty is claimed.
            uint claimedBounty = shareBounties[postId] / 4;
            shareBounties[postId] -= claimedBounty;
            earnings[msg.sender] += claimedBounty;
        }
        emit Shared(postId, msg.sender);
    }

    // Tipping
    //
    // As an equivalent to "likes", you may instead "tip" a post some amount
    // of money. This tip will be available for the post to collect at a later
    // date.
    function sendTip(uint postId) public payable requireValue {
        address author = postAuthors[postId];
        earnings[author] += msg.value;
        emit Tipped(postId, msg.sender, msg.value);
    }

    // Earnings
    //
    // Derived from tips and by sharing posts with bounties, users will be
    // able to collect their earnings here.
    function checkEarnings() public view returns (uint) {
        return earnings[msg.sender];
    }

    function collectEarnings() public requireEarnings {
        uint claimed = earnings[msg.sender];
        earnings[msg.sender] = 0;
        payable(msg.sender).transfer(claimed);
        emit Collected(msg.sender, claimed);
    }
}
