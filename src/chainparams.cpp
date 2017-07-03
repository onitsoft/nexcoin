// Copyright (c) 2010 Satoshi Nakamoto
// Copyright (c) 2009-2012 The Bitcoin developers
// Distributed under the MIT/X11 software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#include "assert.h"

#include <iostream>

#include "chainparams.h"
#include "main.h"
#include "util.h"

#include <boost/assign/list_of.hpp>

using namespace boost::assign;

struct SeedSpec6 {
    uint8_t addr[16];
    uint16_t port;
};

#include "chainparamsseeds.h"

//
// Main network
//

// Convert the pnSeeds6 array into usable address objects.
static void convertSeed6(std::vector<CAddress> &vSeedsOut, const SeedSpec6 *data, unsigned int count)
{
    // It'll only connect to one or two seed nodes because once it connects,
    // it'll get a pile of addresses with newer timestamps.
    // Seed nodes are given a random 'last seen time' of between one and two
    // weeks ago.
    const int64_t nOneWeek = 7*24*60*60;
    for (unsigned int i = 0; i < count; i++)
    {
        struct in6_addr ip;
        memcpy(&ip, data[i].addr, sizeof(ip));
        CAddress addr(CService(ip, data[i].port));
        addr.nTime = GetTime() - GetRand(nOneWeek) - nOneWeek;
        vSeedsOut.push_back(addr);
    }
}

class CMainParams : public CChainParams {
public:
    CMainParams() {
        // The message start string is designed to be unlikely to occur in normal data.
        // The characters are rarely used upper ASCII, not valid as UTF-8, and produce
        // a large 4-byte int at any alignment.
        pchMessageStart[0] = 0x70;
        pchMessageStart[1] = 0x35;
        pchMessageStart[2] = 0x42;
        pchMessageStart[3] = 0x05;
        vAlertPubKey = ParseHex("04088d3cdb8e76a602e7f0e2b7f77ebf066d7385866a704de187a769e3108bf6ee4d98a5eb90f7656c006c5bdbb4d8b7c096dfa3c7019b52cc18db3121e6f43e9b");
        nDefaultPort = 8228;
        nRPCPort = 8229;
        bnProofOfWorkLimit = CBigNum(~uint256(0) >> 20);

        const char* pszTimestamp = "3 July 2017 CoinTelegraph Bitcoin Outputs Stop Growing After 2 Years As Network Relaxes";
        const uint32_t genesisTimestamp = 1499102185;
        std::vector<CTxIn> vin;
        vin.resize(1);
        vin[0].scriptSig = CScript() << 0 << CBigNum(42) << vector<unsigned char>((const unsigned char*)pszTimestamp, (const unsigned char*)pszTimestamp + strlen(pszTimestamp));
        std::vector<CTxOut> vout;
        vout.resize(1);
        vout[0].SetEmpty();
        CTransaction txNew(1, genesisTimestamp, vin, vout, 0);
        genesis.vtx.push_back(txNew);
        genesis.hashPrevBlock = 0;
        genesis.hashMerkleRoot = genesis.BuildMerkleTree();
        genesis.nVersion = 1;
        genesis.nTime    = genesisTimestamp;
        genesis.nBits    = bnProofOfWorkLimit.GetCompact();


        // "mine" the nonce
        // for (genesis.nNonce = 0; genesis.nNonce < 0xffffffff; genesis.nNonce++) {
        //     if (genesis.nNonce % 1000000 == 0)
        //         std::cout << "tried " << genesis.nNonce << " nonces" << std::endl;
        //     hashGenesisBlock = genesis.GetHash();
        //     unsigned char *b = hashGenesisBlock.end() - 3;
        //     if (memcmp(b, "\x01\x00\x00", 3) == 0) {
        //         std::cout << "nNonce is: " << genesis.nNonce << std::endl;
        //         std::cout << "Hash is: " << genesis.GetHash().ToString() << std::endl;
        //         std::cout << "Block is: " << genesis.ToString() << std::endl;
        //         abort();
        //         break;
        //     }
        // }


        genesis.nNonce = 10222963;
        hashGenesisBlock = genesis.GetHash();

        assert(hashGenesisBlock == uint256("000001f7f2ae344c8b71eb98f4c2f30cc199948fc34493c652adb9cc901cc743"));
        assert(genesis.hashMerkleRoot == uint256("6fbda8240472b8b9a4b9e783c2bc3d370e700c48991e898fdaedf9b963e372be"));

        vSeeds.push_back(CDNSSeedData("188.166.69.84", "188.166.69.84"));

        base58Prefixes[PUBKEY_ADDRESS] = list_of(53); // appears as "C" in base58
        base58Prefixes[SCRIPT_ADDRESS] = list_of(85);
        base58Prefixes[SECRET_KEY] =     list_of(153);
        base58Prefixes[EXT_PUBLIC_KEY] = list_of(0x04)(0x88)(0xB2)(0x1E);
        base58Prefixes[EXT_SECRET_KEY] = list_of(0x04)(0x88)(0xAD)(0xE4);

        convertSeed6(vFixedSeeds, pnSeed6_main, ARRAYLEN(pnSeed6_main));

        nLastPOWBlock = LAST_POW_BLOCK;
    }

    virtual const CBlock& GenesisBlock() const { return genesis; }
    virtual Network NetworkID() const { return CChainParams::MAIN; }

    virtual const vector<CAddress>& FixedSeeds() const {
        return vFixedSeeds;
    }
protected:
    CBlock genesis;
    vector<CAddress> vFixedSeeds;
};
static CMainParams mainParams;


//
// Testnet
//

class CTestNetParams : public CMainParams {
public:
    CTestNetParams() {
        // The message start string is designed to be unlikely to occur in normal data.
        // The characters are rarely used upper ASCII, not valid as UTF-8, and produce
        // a large 4-byte int at any alignment.
        pchMessageStart[0] = 0xcd;
        pchMessageStart[1] = 0xf2;
        pchMessageStart[2] = 0x42;
        pchMessageStart[3] = 0xef;
        bnProofOfWorkLimit = CBigNum(~uint256(0) >> 16);
        vAlertPubKey = ParseHex("0471dc165db490094d35cde15b1f5d755fa6ad6f2b5ed0f340e3f17f57389c3c2af113a8cbcc885bde73305a553b5640c83021128008ddf882e856336269080496");
        nDefaultPort = 18228;
        nRPCPort = 18229;
        strDataDir = "testnet";

        // Modify the testnet genesis block so the timestamp is valid for a later start.
        genesis.nBits  = bnProofOfWorkLimit.GetCompact();


        // "mine" the nonce
        // std::cout << "Testnet mining " << genesis.nTime << "\n";
        // for (genesis.nNonce = 0; genesis.nNonce < 0xffffffff; genesis.nNonce++) {
        //     if (genesis.nNonce % 1000000 == 0)
        //         std::cout << "tried " << genesis.nNonce << " nonces" << std::endl;
        //     hashGenesisBlock = genesis.GetHash();
        //     unsigned char *b = hashGenesisBlock.end() - 2;
        //     if (memcmp(b, "\x00\x00", 2) == 0) {
        //         std::cout << "testnet nNonce is: " << genesis.nNonce << std::endl;
        //         std::cout << "Hash is: " << genesis.GetHash().ToString() << std::endl;
        //         std::cout << "Block is: " << genesis.ToString() << std::endl;
        //         abort();
        //         break;
        //     }
        // }


        genesis.nNonce = 163466;
        hashGenesisBlock = genesis.GetHash();

        assert(hashGenesisBlock == uint256("0x0000e729371aa6478819127587a5e635f371242c520204320a46e6b77390a18d"));

        vFixedSeeds.clear();
        vSeeds.clear();

        base58Prefixes[PUBKEY_ADDRESS] = list_of(111);
        base58Prefixes[SCRIPT_ADDRESS] = list_of(196);
        base58Prefixes[SECRET_KEY]     = list_of(239);
        base58Prefixes[EXT_PUBLIC_KEY] = list_of(0x04)(0x35)(0x87)(0xCF);
        base58Prefixes[EXT_SECRET_KEY] = list_of(0x04)(0x35)(0x83)(0x94);

        convertSeed6(vFixedSeeds, pnSeed6_test, ARRAYLEN(pnSeed6_test));

        nLastPOWBlock = 0x7fffffff;
    }
    virtual Network NetworkID() const { return CChainParams::TESTNET; }
};
static CTestNetParams testNetParams;


//
// Regression test
//
class CRegTestParams : public CTestNetParams {
public:
    CRegTestParams() {
        pchMessageStart[0] = 0xfa;
        pchMessageStart[1] = 0xbf;
        pchMessageStart[2] = 0xb5;
        pchMessageStart[3] = 0xda;
        bnProofOfWorkLimit = CBigNum(~uint256(0) >> 1);
        genesis.nTime = 1411111111;
        genesis.nBits  = bnProofOfWorkLimit.GetCompact();
        genesis.nNonce = 2;
        hashGenesisBlock = genesis.GetHash();
        nDefaultPort = 18444;
        strDataDir = "regtest";

        /*
        std::cout << "Block is: " << genesis.ToString() << std::endl;
        */
        // assert(hashGenesisBlock == uint256("0xb0dd3b9300bac6ebca952b64d8f8e70698c5b94a8bef14e94d564ee6a0d4e00c"));

        vSeeds.clear();  // Regtest mode doesn't have any DNS seeds.
    }

    virtual bool RequireRPCPassword() const { return false; }
    virtual Network NetworkID() const { return CChainParams::REGTEST; }
};
static CRegTestParams regTestParams;

static CChainParams *pCurrentParams = &mainParams;

const CChainParams &Params() {
    return *pCurrentParams;
}

void SelectParams(CChainParams::Network network) {
    switch (network) {
        case CChainParams::MAIN:
            pCurrentParams = &mainParams;
            break;
        case CChainParams::TESTNET:
            pCurrentParams = &testNetParams;
            break;
        case CChainParams::REGTEST:
            pCurrentParams = &regTestParams;
            break;
        default:
            assert(false && "Unimplemented network");
            return;
    }
}

bool SelectParamsFromCommandLine() {
    bool fRegTest = GetBoolArg("-regtest", false);
    bool fTestNet = GetBoolArg("-testnet", false);

    if (fTestNet && fRegTest) {
        return false;
    }

    if (fRegTest) {
        SelectParams(CChainParams::REGTEST);
    } else if (fTestNet) {
        SelectParams(CChainParams::TESTNET);
    } else {
        SelectParams(CChainParams::MAIN);
    }
    return true;
}
