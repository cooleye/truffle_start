truffle是一个以太坊的开发和测试框架。使用它可以方便我们快速的在以太坊上开发。那废话不多说，下面我们就来看下如何使用。
## 安装
首先安装truffle
```
npm install -g truffle
```
## 创建工程目录
```
mkdir myproject
```
## 初始化工程
```
$ cd myproject
$ truffle init
```
![image.png](https://upload-images.jianshu.io/upload_images/4834364-87c6a0775ee65506.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
创建好的工程目录
![image.png](https://upload-images.jianshu.io/upload_images/4834364-2aff6df2ea222f05.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* contract/ - Truffle默认的合约文件存放地址。
* migrations/ - 存放发布脚本文件
* test/ - 用来测试应用和合约的测试文件
* truffle.js - Truffle的配置文件

## 编译合约
要编译您的合约，使用
```
truffle compile
```
Truffle仅默认编译自上次编译后被修改过的文件，来减少不必要的编译。如果你想编译全部文件，可以使用--compile-all选项
```
truffle compile --compile-all
```
##### 注意，合约的名称和文件名要一直，想这样
```
contract MyContract {
  ...
}
// or
library MyContract {
  ...
}
```
name文件名也应为 `MyContract.sol`

编译完成
![image.png](https://upload-images.jianshu.io/upload_images/4834364-d79a51bab95ad137.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
会在项目目录下生成build目录。
![image.png](https://upload-images.jianshu.io/upload_images/4834364-7a85688cd5108fdd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##### 配置网络 NETWORKS
指定在移植(Migration)时使用哪个[网络](http://truffleframework.com/docs/advanced/configuration)
打开truffle.js
添加如下配置
```
module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*" // Match any network id
    }
  }
};
```


也可以配置多个网络
```
networks: {
  development: {
    host: "127.0.0.1",
    port: 9545,
    network_id: "*" // match any network
  },
  live: {
    host: "178.25.19.88", // Random IP for example purposes (do not use)
    port: 80,
    network_id: 1,        // Ethereum public network
    // optional config values:
    // gas
    // gasPrice
    // from - default address to use for any transaction Truffle makes during migrations
    // provider - web3 provider instance Truffle should use to talk to the Ethereum network.
    //          - function that returns a web3 provider instance (see below.)
    //          - if specified, host and port are ignored.
  }
}
```


## Migrate
把合约发布到以太网络上
```
truffle migrate
```
这个命令会执行所有的位于migrations目录内的移植脚本。如果之前部署过，那么它只会部署新的合约.如何要重新部署，可以使用 
`truffle migrate --reset `

```
var Migrations = artifacts.require("./Migrations.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
```
这个脚本中，首先require进来合约。在移植函数中，接受一个deployer对象，使用 deploy来部署合约。

多个网络的话，部署的时候制定使用的网络
```
$ truffle migrate --network live
```

执行部署之前，先要启动以太坊开发环境
```
truffle develop
truffle develop
Truffle Develop started at http://127.0.0.1:9545/

Accounts:
(0) 0x627306090abab3a6e1400e9345bc60c78a8bef57
(1) 0xf17f52151ebef6c7334fad080c5704d77216b732
(2) 0xc5fdf4076b8f3a5357c5e395ab970b5b54098fef
(3) 0x821aea9a577a9b44299b9c15c88cf3087f3b5544
(4) 0x0d1d4e623d10f9fba5db95830f7d3839406c6af2
(5) 0x2932b7a2355d6fecc4b5c0b6bd44cc31df247a2e
(6) 0x2191ef87e392377ec08e7c08eb105ef5448eced5
(7) 0x0f4f2ac550a1b4e2280d04c21cea7ebd822934b5
(8) 0x6330a553fc93768f612722bb8c2ec78ac90b3bbc
(9) 0x5aeda56215b167893e80b4fe645ba6d5bab767de

Private Keys:
(0) c87509a1c067bbde78beb793e6fa76530b6382a4c0241e5e4a9ec0a0f44dc0d3
(1) ae6ae8e5ccbfb04590405997ee2d52d2b330726137b875053c36d94e974d162f
(2) 0dbbe8e4ae425a6d2687f1a7e3ba17bc98c673636790f1b8ad91193c05875ef1
(3) c88b703fb08cbea894b6aeff5a544fb92e78a18e19814cd85da83b71f772aa6c
(4) 388c684f0ba1ef5017716adb5d21a053ea8e90277d0868337519f97bede61418
(5) 659cbb0e2411a44db63778987b1e22153c086a95eb6b18bdf89de078917abc63
(6) 82d052c865f5763aad42add438569276c00d3d88a2d062d36b2bae914d58b8c8
(7) aa3680d5d48a8283413f7a108367c7299ca73f553735860a87b08f39395618b7
(8) 0f62d96d6675f32685bbdb8ac13cda7c23436f63efbb9d07700d8669ff12b7c4
(9) 8d5366123cb560bb606379f90a0bfd4769eecc0557f1b362dcae9012b548b1e5

Mnemonic: candy maple cake sugar pudding cream honey rich smooth crumble sweet treat

⚠️  Important ⚠️  : This mnemonic was created for you by Truffle. It is not secure.
Ensure you do not use it on production blockchains, or else you risk losing funds.

truffle(develop)>
```
他会默认创建10个账户。注意这里的端口使用的是9545。

执行部署命令
```
truffle migrate
```
```
truffle migrate
Using network 'development'.

Network up to date.
```
## 自定义合约
下面呢我们就自己实现一个合约来测试一下。
在contract目录下新建 Greete.sol
```
pragma solidity ^0.4.16;


contract Greete {
    
    function sayHello() public constant returns (string name) {
        return ("迪丽热巴");
    }

    function greeting(uint a) public returns(uint b) {
        return a*8;
    }
}
```
##### 编译合约
```
truffle compile
```
在migrations里新建一个部署脚本 `2_deploy_migration.js`
```
var Greete = artifacts.require("./Greete.sol");

module.exports = function(deployer) {
  deployer.deploy(Greete);
};
```
##### 移植
```
truffle migrate
```

##### 进入truffle 控制台
```
truffle console
```
##### 部署合约
创建一个变量保存合约实例,然后部署合约。

```
truffle(development)> let contract;
undefined
truffle(development)> Greete.deployed().then( instance => contract = instance )
TruffleContract {
  constructor:
   { [Function: TruffleContract]
     _static_methods:
      { setProvider: [Function: setProvider],
        new: [Function: new],
        at: [Function: at],
        deployed: [Function: deployed],
        defaults: [Function: defaults],
        hasNetwork: [Function: hasNetwork],
        isDeployed: [Function: isDeployed],
        detectNetwork: [Function: detectNetwork],
        setNetwork: [Function: setNetwork],
        resetAddress: [Function: resetAddress],
        link: [Function: link],
        clone: [Function: clone],
        addProp: [Function: addProp],
        toJSON: [Function: toJSON] },
     _properties:
      { contract_name: [Object],
        contractName: [Object],
        abi: [Object],
        network: [Function: network],
        networks: [Function: networks],
        address: [Object],
        transactionHash: [Object],
        links: [Function: links],
        events: [Function: events],
        binary: [Function: binary],
        deployedBinary: [Function: deployedBinary],
        unlinked_binary: [Object],
        bytecode: [Object],
        deployedBytecode: [Object],
        sourceMap: [Object],
        deployedSourceMap: [Object],
        source: [Object],
        sourcePath: [Object],
        legacyAST: [Object],
        ast: [Object],
        compiler: [Object],
        schema_version: [Function: schema_version],
        schemaVersion: [Function: schemaVersion],
        updated_at: [Function: updated_at],
        updatedAt: [Function: updatedAt] },
     _property_values: {},
     _json:
      { contractName: 'Greete',
        abi: [Array],
        bytecode: '0x6060604052341561000f57600080fd5b6101a68061001e6000396000f30060606040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff16806372a239eb14610051578063ef5fb05b14610088575b600080fd5b341561005c57600080fd5b6100726004808035906020019091905050610116565b6040518082815260200191505060405180910390f35b341561009357600080fd5b61009b610123565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100db5780820151818401526020810190506100c0565b50505050905090810190601f1680156101085780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b6000600882029050919050565b61012b610166565b6040805190810160405280600c81526020017fe8bfaae4b8bde783ade5b7b40000000000000000000000000000000000000000815250905090565b6020604051908101604052806000815250905600a165627a7a7230582018a750bc4f8272ac2a1bfb6471656ac977b15ab056a45dcb33efc2f2af27d9280029',
        deployedBytecode: '0x60606040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff16806372a239eb14610051578063ef5fb05b14610088575b600080fd5b341561005c57600080fd5b6100726004808035906020019091905050610116565b6040518082815260200191505060405180910390f35b341561009357600080fd5b61009b610123565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100db5780820151818401526020810190506100c0565b50505050905090810190601f1680156101085780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b6000600882029050919050565b61012b610166565b6040805190810160405280600c81526020017fe8bfaae4b8bde783ade5b7b40000000000000000000000000000000000000000815250905090565b6020604051908101604052806000815250905600a165627a7a7230582018a750bc4f8272ac2a1bfb6471656ac977b15ab056a45dcb33efc2f2af27d9280029',
        sourceMap: '27:209:0:-;;;;;;;;;;;;;;;;;',
        deployedSourceMap: '27:209:0:-;;;;;;;;;;;;;;;;;;;;;;;;;;;;;158:76;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;54:98;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;23:1:-1;8:100;33:3;30:1;27:2;8:100;;;99:1;94:3;90;84:5;80:1;75:3;71;64:6;52:2;49:1;45:3;40:15;;8:100;;;12:14;3:109;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;158:76:0;199:6;226:1;224;:3;217:10;;158:76;;;:::o;54:98::-;99:11;;:::i;:::-;122:23;;;;;;;;;;;;;;;;;;;;54:98;:::o;27:209::-;;;;;;;;;;;;;;;:::o',
        source: 'pragma solidity ^0.4.16;\n\n\ncontract Greete {\n    \n    function sayHello() public constant returns (string name) {\n        return ("迪丽热巴");\n    }\n\n    function greeting(uint a) public returns(uint b) {\n        return a*8;\n    }\n}',
        sourcePath: '/Users/kongdejian/Desktop/myproject/contracts/Greete.sol',
        ast: [Object],
        legacyAST: [Object],
        compiler: [Object],
        networks: [Object],
        schemaVersion: '2.0.0',
        updatedAt: '2018-04-14T10:58:55.558Z' },
     setProvider: [Function: bound setProvider],
     new: [Function: bound new],
     at: [Function: bound at],
     deployed: [Function: bound deployed],
     defaults: [Function: bound defaults],
     hasNetwork: [Function: bound hasNetwork],
     isDeployed: [Function: bound isDeployed],
     detectNetwork: [Function: bound detectNetwork],
     setNetwork: [Function: bound setNetwork],
     resetAddress: [Function: bound resetAddress],
     link: [Function: bound link],
     clone: [Function: bound clone],
     addProp: [Function: bound addProp],
     toJSON: [Function: bound toJSON],
     web3:
      Web3 {
        _requestManager: [RequestManager],
        currentProvider: [Provider],
        eth: [Eth],
        db: [DB],
        shh: [Shh],
        net: [Net],
        personal: [Personal],
        bzz: [Swarm],
        settings: [Settings],
        version: [Object],
        providers: [Object],
        _extend: [Function] },
     class_defaults:
      { from: '0x627306090abab3a6e1400e9345bc60c78a8bef57',
        gas: 6721975,
        gasPrice: 100000000000 },
     currentProvider:
      HttpProvider {
        host: 'http://127.0.0.1:9545',
        timeout: 0,
        user: undefined,
        password: undefined,
        headers: undefined,
        send: [Function],
        sendAsync: [Function],
        _alreadyWrapped: true },
     network_id: '4447' },
  abi:
   [ { constant: true,
       inputs: [],
       name: 'sayHello',
       outputs: [Array],
       payable: false,
       stateMutability: 'view',
       type: 'function' },
     { constant: false,
       inputs: [Array],
       name: 'greeting',
       outputs: [Array],
       payable: false,
       stateMutability: 'nonpayable',
       type: 'function' } ],
  contract:
   Contract {
     _eth:
      Eth {
        _requestManager: [RequestManager],
        getBalance: [Function],
        getStorageAt: [Function],
        getCode: [Function],
        getBlock: [Function],
        getUncle: [Function],
        getCompilers: [Function],
        getBlockTransactionCount: [Function],
        getBlockUncleCount: [Function],
        getTransaction: [Function],
        getTransactionFromBlock: [Function],
        getTransactionReceipt: [Function],
        getTransactionCount: [Function],
        call: [Function],
        estimateGas: [Function],
        sendRawTransaction: [Function],
        signTransaction: [Function],
        sendTransaction: [Function],
        sign: [Function],
        compile: [Object],
        submitWork: [Function],
        getWork: [Function],
        coinbase: [Getter],
        getCoinbase: [Function],
        mining: [Getter],
        getMining: [Function],
        hashrate: [Getter],
        getHashrate: [Function],
        syncing: [Getter],
        getSyncing: [Function],
        gasPrice: [Getter],
        getGasPrice: [Function],
        accounts: [Getter],
        getAccounts: [Function],
        blockNumber: [Getter],
        getBlockNumber: [Function],
        protocolVersion: [Getter],
        getProtocolVersion: [Function],
        iban: [Function],
        sendIBANTransaction: [Function: bound transfer] },
     transactionHash: null,
     address: '0x2c2b9c9a4a25e24b174f26114e8926a9f2128fe4',
     abi: [ [Object], [Object] ],
     sayHello:
      { [Function: bound ]
        request: [Function: bound ],
        call: [Function: bound ],
        sendTransaction: [Function: bound ],
        estimateGas: [Function: bound ],
        getData: [Function: bound ],
        '': [Circular] },
     greeting:
      { [Function: bound ]
        request: [Function: bound ],
        call: [Function: bound ],
        sendTransaction: [Function: bound ],
        estimateGas: [Function: bound ],
        getData: [Function: bound ],
        uint256: [Circular] },
     allEvents: [Function: bound ] },
  sayHello:
   { [Function]
     call: [Function],
     sendTransaction: [Function],
     request: [Function: bound ],
     estimateGas: [Function] },
  greeting:
   { [Function]
     call: [Function],
     sendTransaction: [Function],
     request: [Function: bound ],
     estimateGas: [Function] },
  sendTransaction: [Function],
  send: [Function],
  allEvents: [Function: bound ],
  address: '0x2c2b9c9a4a25e24b174f26114e8926a9f2128fe4',
  transactionHash: null }
truffle(development)>
```
##### 调用合约
```
truffle(development)> contract.sayHello()
'迪丽热巴'
truffle(development)>
```
调用另一个方法
```
truffle(development)> contract.greeting(11)
{ tx: '0x640a0bcb1678ab6679f8f5ec20d6904f499089a7972dcca24c7a81dd10e47379',
  receipt:
   { transactionHash: '0x640a0bcb1678ab6679f8f5ec20d6904f499089a7972dcca24c7a81dd10e47379',
     transactionIndex: 0,
     blockHash: '0x4f54256da873a61cd976feaf70823671033a5b2f6dc34252c4065b98b2d664f3',
     blockNumber: 11,
     gasUsed: 21705,
     cumulativeGasUsed: 21705,
     contractAddress: null,
     logs: [],
     status: '0x01',
     logsBloom: '0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000' },
  logs: [] }
truffle(development)>
```
`greeting `会改变数据在区块链上的状态，需要花费gas。
查看交易结果
```
truffle(development)> contract.greeting.call(2)
BigNumber { s: 1, e: 1, c: [ 16 ] }
truffle(development)>
```
返回的是一个BigNumber类型的数据。





