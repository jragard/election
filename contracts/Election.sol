pragma solidity ^0.5.0;

contract Election {
    // Read/Write candidate
    string public candidate;

    // Constructor
    constructor() public {
        addCandidate("Ryan");
        addCandidate("Michelle");
    }

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;

    // Store candidates count
    uint public candidatesCount;

    // Store accounts that have voted
    mapping(address => bool) public voters;

    event votedEvent (
        uint indexed _candidateId
    );

    function vote(uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender], "address already voted");

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount, "invalid candidate");

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);

    }

    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }
}

