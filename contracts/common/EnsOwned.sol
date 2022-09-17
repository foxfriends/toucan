// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;

contract EnsOwned {
    Registry ens = Registry(0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e);
    ReverseRegistrar rev = ReverseRegistrar(0x084b1c3c81545d370f3634392de611caabff8148)

    modifier checkOwner() internal {
        bytes32 node = rev.node(address(this));
        Resolver resolver = ens.resolver(node);
    }
}
