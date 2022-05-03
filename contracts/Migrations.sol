// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract Migrations {
    // ╔═══════════╗
    // ║ Variables ║
    // ╚═══════════╝
  address public owner;
  uint public last_completed_migration;

    // ╔═══════════╗
    // ║ Modifiers ║
    // ╚═══════════╝
  modifier restricted() {
    if (msg.sender == owner) _;
  }

    // ╔═══════════╗
    // ║ Functions ║
    // ╚═══════════╝
  constructor() {
    owner = msg.sender;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }

  function upgrade(address new_address) public restricted {
    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);
  }
}
