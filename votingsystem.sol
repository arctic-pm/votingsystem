pragma solidity ^0.8.0;

contract VotingRewards {
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    mapping(address => bool) public hasVoted;
    mapping(address => uint256) public tokenBalance;
    Candidate[3] public candidates;
    address public owner;

    uint256 public constant REWARD_TOKENS = 10;

    modifier onlyOnce() {
        require(!hasVoted[msg.sender], "You have already voted");
        _;
    }

    constructor() {
        owner = msg.sender;
        candidates[0] = Candidate("Alice", 0);
        candidates[1] = Candidate("Bob", 0);
        candidates[2] = Candidate("Charlie", 0);
    }

    function vote(uint8 candidateIndex) external onlyOnce {
        require(candidateIndex < candidates.length, "Invalid candidate");
        candidates[candidateIndex].voteCount++;
        hasVoted[msg.sender] = true;
        tokenBalance[msg.sender] += REWARD_TOKENS;
    }
    
    function getCandidateVotes(uint8 candidateIndex) external view returns (uint256) {
        require(candidateIndex < candidates.length, "Invalid candidate");
        return candidates[candidateIndex].voteCount;
    }
}
