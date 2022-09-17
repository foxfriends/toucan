abstract contract Registry {
    function owner(bytes32 node) external view returns (address);
    function resolver(bytes32 node) public virtual view returns (PublicResolver);
}

abstract contract PublicResolver {
    function addr(bytes32 node) public virtual view returns (address);
    function name(bytes32 node) external view returns (string memory);
    function contenthash(bytes32 node) external view returns (bytes memory);
}

abstract contract ReverseRegistrar {
    function node(address addr) public pure returns (bytes32);
}
