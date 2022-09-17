// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;

import "./common/EnsOwned.sol";

contract Board is EnsOwned {
    event TextPost(
        address indexed author,
        string content,
    );
}
