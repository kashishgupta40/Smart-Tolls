pragma solidity ^0.8.0;

contract TollTransaction {
    address public tollBooth; // Address of the toll booth
    address public vehicle;   // Address of the vehicle
    uint public tollAmount;   // Toll amount in Wei (1 Ether = 10^18 Wei)
    bool public paid;         // Flag indicating whether toll is paid
    
    event TollPaid(address indexed payer, uint amount);
    
    // Constructor to set the toll booth address and toll amount
    constructor(address _tollBooth, uint _tollAmount) {
        tollBooth = _tollBooth;
        tollAmount = _tollAmount;
    }
    
    // Function to pay toll
    function payToll() public payable {
        require(msg.sender == vehicle, "Only the vehicle owner can pay toll");
        require(msg.value == tollAmount, "Incorrect toll amount");
        require(!paid, "Toll already paid");
        
        payable(tollBooth).transfer(msg.value); // Transfer toll amount to toll booth
        paid = true; // Mark toll as paid
        emit TollPaid(msg.sender, msg.value); // Emit event
    }
    
    // Function to check if toll is paid
    function isTollPaid() public view returns(bool) {
        return paid;
    }
}
