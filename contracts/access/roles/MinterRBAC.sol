pragma solidity ^0.5.0;

import "../../GSN/Context.sol";
import "../RBAC.sol";

contract MinterRBAC is Context, RBAC {
    event MinterAdded(address indexed account);
    event MinterRemoved(address indexed account);

    constructor () internal RBAC(_msgSender()) {
    }

    modifier onlyMinter() {
        require(isMinter(_msgSender()), "MinterRole: caller does not have the Minter role");
        _;
    }

    function isMinter(address account) public view returns (bool) {
        return hasRole(account, ROOT_ROLE);
    }

    function addMinter(address account) public onlyMinter {
        _addMinter(account);
    }

    function renounceMinter() public {
        _removeMinter(_msgSender());
    }

    function _addMinter(address account) internal {
        addMember(account, ROOT_ROLE);
        emit MinterAdded(account);
    }

    function _removeMinter(address account) internal {
        removeMember(account, ROOT_ROLE);
        emit MinterRemoved(account);
    }
}
