// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract Contract {
    // Struct to store index details
    struct Index {
        string name;
        uint256 ethPriceInWei;
        uint256 usdPriceInCents;
        uint256 usdCapitalization;
        int256 percentageChange;
    }

    // Struct to store group details
    struct Group {
        string name;
        uint256[] indexes;  // List of index IDs within the group
    }

    // Mappings to store groups and indexes by ID
    mapping(uint256 => Group) private groups;
    mapping(uint256 => Index) private indexes;
    uint256[] private groupIds;
    uint256[] private indexIds;

    // Constructor (as specified in the ABI)
    constructor() {

        string[5] memory indexNamesArray = ["eth", "sol", "btc", "xrp", "avax"];

        // Loop to initialize the mapping
        for (uint256 i = 0; i < indexNamesArray.length; i++) {
                indexes[i] = Index({
                    name: indexNamesArray[i],
                    ethPriceInWei: (i + 1) * 3e11, // Example ETH price
                    usdPriceInCents: (i + 1) * 10000, // Example USD price in cents
                    usdCapitalization: (i + 4) * 1e4, // Example capitalization
                    percentageChange: int256(i) * 7 // Example percentage change
                });
                indexIds.push(i); // Keep track of the index IDs
            }      // Store the key in the keys array
        
        }

    // Function to get all group IDs
    function getGroupIds() external view returns (uint256[] memory) {
        return groupIds;
    }

    // Function to get a group's details by its ID
    function getGroup(uint256 _groupId) external view returns (string memory, uint256[] memory) {
        Group storage group = groups[_groupId];
        return (group.name, group.indexes);
    }

    // Function to get an index's details by its ID
    function getIndex(uint256 _indexId) external view returns (
        string memory name,
        uint256 ethPriceInWei,
        uint256 usdPriceInCents,
        uint256 usdCapitalization,
        int256 percentageChange
    ) {
        Index storage index = indexes[_indexId];
        return (
            index.name,
            index.ethPriceInWei,
            index.usdPriceInCents,
            index.usdCapitalization,
            index.percentageChange
        );
    }

    // Optional: Functions to add groups and indexes (for testing purposes)
    function addGroup(uint256 _groupId, string memory _name, uint256[] memory _indexIds) external {
        groups[_groupId] = Group(_name, _indexIds);
        groupIds.push(_groupId);
    }

    function addIndex(
        uint256 _indexId,
        string memory _name,
        uint256 _ethPriceInWei,
        uint256 _usdPriceInCents,
        uint256 _usdCapitalization,
        int256 _percentageChange
    ) external {
        indexes[_indexId] = Index(_name, _ethPriceInWei, _usdPriceInCents, _usdCapitalization, _percentageChange);
    }
}
