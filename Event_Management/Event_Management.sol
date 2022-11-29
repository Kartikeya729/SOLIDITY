// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0 <0.9.0;

contract EventContract {
    struct Event {
        address organizer;
        string name;
        uint256 date;
        uint256 price;
        uint256 ticketCount;
        uint256 ticketRemain;
    }

    mapping(uint256 => Event) public events; //maps structs
    mapping(address => mapping(uint256 => uint256)) public tickets;
    uint256 public nextId;

    function createEvent(
        string memory name,
        uint256 date,
        uint256 price,
        uint256 ticketCount
    ) external {
        require(
            date > block.timestamp,
            "You can only organize events for a date later than this date..."
        ); //check if current date for event is greater than currect block timestamp
        require(
            ticketCount > 0,
            "You can only organize events with more than 0 tickets..."
        ); //Can only create event if tickets are more than 0

        events[nextId] = Event(
            msg.sender,
            name,
            date,
            price,
            ticketCount,
            ticketCount
        );
        nextId++;
    }

    function buyTicket(uint256 id, uint256 quantity) external payable {
        Event storage _event = events[id];

        require(events[id].date != 0, "Event does not exist...");
        require(_event.ticketRemain >= quantity, "Not enough tickets left...");
        require(
            events[id].date > block.timestamp,
            "Event has already started..."
        );

        require(
            msg.value == (_event.price * quantity),
            "Ethers are not enough..."
        );
        _event.ticketRemain -= quantity;

        tickets[msg.sender][id] += quantity;
    }

    function transferTicket(
        uint256 id,
        uint256 quantity,
        address to
    ) external {
        require(events[id].date != 0, "Event does not exist...");
        require(
            events[id].date > block.timestamp,
            "Event has already started..."
        );
        require(
            tickets[msg.sender][id] >= quantity,
            "You do not have enough tickets..."
        );
        tickets[msg.sender][id] -= quantity;
        tickets[to][id] += quantity;
    }
}
