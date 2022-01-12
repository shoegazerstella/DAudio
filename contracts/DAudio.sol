// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;


contract DAudio {
  uint public audioCount = 0;
  string public contractName = "DAudio";
  mapping(uint => Audio) public audios;
  mapping(string => Audio) public audiohash2metadata; //retrieve metadata by audio hash
  mapping(address => Audio[]) public address2catalogue; // retrieve catalogue of address

  struct Audio {
    uint id;
    string hash; // hash of audio
    string title; // song title
    string[] keywords; // keywords like genre, style etc..
    address author;
  }

  event AudioUploaded(
    uint id,
    string hash,
    string title,
    string[] keywords,
    address author
  );

  constructor() public {
  }

  function uploadAudio(string memory _audioHash, string memory _title, string[] memory _keywords) public {

    // Make sure the audio hash exists
    require(bytes(_audioHash).length > 0);

    // Make sure audio title exists
    require(bytes(_title).length > 0);

    // Make sure audio keywords exists
    //require(bytes(_keywords).length > 0);

    // Make sure uploader address exists
    require(msg.sender!=address(0));

    // create struct
    Audio memory _audio = Audio(audioCount, _audioHash, _title, _keywords, msg.sender);

    // Increment audio id
    audioCount ++;

    // Add audio to the contract
    audios[audioCount] = _audio;

    // Add audio hash to metadata
    audiohash2metadata[_audioHash] = _audio;

    // Add audio hash to address mapping
    address2catalogue[msg.sender].push( _audio );
    // to test as "0x00",0 - need to specify the index of the array

    // Trigger an event
    emit AudioUploaded(audioCount, _audioHash, _title, _keywords, msg.sender);
  }
}