// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import {PriceConverter} from "./GetConversionRate.sol";
contract CrowdFunding{
    using PriceConverter for uint;
    address public immutable OwnerAddress;
    uint public FundingGoal = 50e18;
    uint public DeployTime;
    uint public Deadline;
    address[] public SendersList;
    mapping(address => uint) public SendersMapping;
    constructor(){
        OwnerAddress = msg.sender;
        DeployTime = block.timestamp;
        Deadline = DeployTime + 7 days;
    }
    modifier DeadlineNotReached(){
        require(block.timestamp<=Deadline);
        _;
    }
    modifier DeadlineReached(){
        require(block.timestamp>Deadline);
        _;
    }
    modifier GoalNotCompleted(){
        require(address(this).balance.Conversion()<FundingGoal);
        _;
    }
    modifier GoalCompleted(){
        require(address(this).balance.Conversion()>=FundingGoal);
        _;
    }
    modifier OnlyOwner(){
        require(msg.sender == OwnerAddress);
        _;
    }
    function Fund() public payable DeadlineNotReached GoalNotCompleted{
        address AB = msg.sender;
        SendersList.push(msg.sender);
        SendersMapping[AB] = SendersMapping[AB] +  msg.value;
    }
    function Withdraw() public DeadlineReached GoalNotCompleted{
        address AB = msg.sender;
        uint ABFund = SendersMapping[AB];
        SendersMapping[AB] = 0;
        (bool CallSuccess,) = payable(msg.sender).call{value: ABFund}("");
        require(CallSuccess,"Transaction Not Done");
    }
    function WithdrawOwner() public OnlyOwner GoalCompleted{
        (bool CallSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(CallSuccess,"Transaction Not Done");
    }
