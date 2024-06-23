# Gilt Contract Deployment 
The following tables list the various Gilt Deployments across different chains. The following deployments are testnet deployments and are available for permissionless use. 

## Deployments

Arbitrum Sepolia
Meter 
OP Sepolia 
Base Sepolia
Sepolia 
Wemix

### Arbitrum Sepolia
| Blockchain | Contract                          | Address                                  |Version|Description|
|------------|-----------------------------------|------------------------------------------|-------|-----------|
|421614      |TEST_GILT_TOKEN                    |0x847ed1C4d0141cEb2B559244EfADc7C885F44752|   0   |*Optimised*|
|421614      |RESERVED_GILT_ADMIN                |0xC1436aD1dAc368a81AF38E25Faf4cCe8872B2746|   0   |-|
|421614      |RESERVED_GILT_OPS_REGISTER         |0xc0Ac69b911Cdf2c237E41EDc9dDfa961a2073B4b|   6   |*Optimised*|
|421614      |RESERVED_GILT_FUNDS_VAULT_FACTORY  |0x3a8c9538E4d182938Dd61b30c4fA1BC4A7254160|   6   |*Optimised*|
|421614      |RESERVED_GILT_CONTRACT             |0x919A3b95Bd16d6AA0e89621c4491a463a8B6f3fc|   18  |*Optimised*|
|421614      |RESERVED_GILT_TRANSFER_VAULT       |0xc81BEF0B79881Eb80a16577e250e1cB2b59D3FAA|   6   |*Optimised*|
|421614      |RESERVED_GILT_LOCATION_REGISTER    |0xBb67f93D77fC6f1F76b3f53cB36Be401546ba8d8|   4   |*Optimised*|
|421614      |RESERVED_GILT_CCIP_TELEPORTER      |0xb2B7Ac820C94Fa5Ae9B5eB1358A4Fd613dd86170|   12  |*Optimised*|
|421614      |RESERVED_GILT_CCIP_RECIEVER        |0xC3330816DF629EBf867F2e7B3A76Bc2DD5A94d07|   14  |*Optimised*|
|421614      |CCIP_ROUTER                        |0x2a9C5afB0d0e4BAb2BCdaE109EC4b0c4Be15a165|   0   |*Optimised*|
|421614      |RESERVED_GILT_LAYER_ZERO_TELEPORTER|0x44f9713E71a5467811c8894aA138A4a4ab6a3579|   1   |*Optimised* (EVM : paris)|
|421614      |RESERVED_GILT_LAYER_ZERO_RECIEVER  |0x4B590F589effD340D4B7D529236146654a212872|   1   |*Optimised* (EVM : paris)|

#### Available Destinations 

|ID| Name          | Reciever Address                           | Universal Chain Id |Transport Protocol Chain Id | Transport | 
|--|---------------|--------------------------------------------|--------------------|----------------------------|-----------|
|  | Sepolia       | 0x9E520879F74b8FF4262cb77c7964D13237C60Fb9 | 11155111           |16015286601757825753        | CCIP      |
|  | OP Sepolia    | 0x2ff1343BBE12a5e29990C648eEa8C139A6d483B8 | 11155420           |5224473277236331295         | CCIP      |
|  | Base Sepolia  | 0x9E520879F74b8FF4262cb77c7964D13237C60Fb9 | 84532              |10344971235874465080        | CCIP      |
|  | WeMix Testnet | 0x2ff1343BBE12a5e29990C648eEa8C139A6d483B8 | 1112               |5224473277236331295         | CCIP      |
|  | Meter Testnet | 0x8Ad1E752d892c97243C6c7fF28A216C472e21E56 | 83                 |40156                       | Layer Zero|



### Meter Testnet
| Blockchain | Contract                        | Address                                  |Version|Description|
|------------|-----------------------------------|------------------------------------------|-------|-----------|
|83          |RESERVED_GILT_ADMIN                |0xC1436aD1dAc368a81AF38E25Faf4cCe8872B2746|   0   |-|
|83          |RESERVED_GILT_OPS_REGISTER         |0xf1B7282d8E41bC77DA36bD3421C17c5776718AdA|   6   |(EVM : Shanghai) |
|83          |RESERVED_GILT_FUNDS_VAULT_FACTORY  |0xc6889C0a791D5971984c29AFaE8e2A242769d1F8|   6   |(EVM : Shanghai) |
|83          |RESERVED_GILT_CONTRACT             |0x09d0aBa0039a1F42a3B1a04d13C85fA252d0cEe8|   18  |(EVM : Shanghai)  *Optimised*|
|83          |RESERVED_GILT_TRANSFER_VAULT       |0x0Ed9C1d467D141B60D101dF3900a8912DF583277|   6   |*Optimised* |
|83          |RESERVED_GILT_LOCATION_REGISTER    |0x0Ed9C1d467D141B60D101dF3900a8912DF583277|   4   |*Optimised* |
|83          |RESERVED_GILT_LAYER_ZERO_TELEPORTER|0xA17609590f682Bf96d8799bAf0853D11F6493786|   1   |*Optimised* (EVM : paris)|
|83          |RESERVED_GILT_LAYER_ZERO_RECIEVER  |0x8Ad1E752d892c97243C6c7fF28A216C472e21E56|   1   |*Optimised* (EVM : paris)|

#### Available Destinations 

|ID| Name          | Reciever Address                           | Universal Chain Id |Transport Protocol Chain Id | Transport | 
|--|---------------|--------------------------------------------|--------------------|----------------------------|-----------|
|  | Sepolia       | 0x9E520879F74b8FF4262cb77c7964D13237C60Fb9 | 11155111           |16015286601757825753        | CCIP      |
|  | OP Sepolia    | 0x2ff1343BBE12a5e29990C648eEa8C139A6d483B8 | 11155420           |5224473277236331295         | CCIP      |
|  | Base Sepolia  | 0x9E520879F74b8FF4262cb77c7964D13237C60Fb9 | 84532              |10344971235874465080        | CCIP      |
|  | WeMix Testnet | 0x2ff1343BBE12a5e29990C648eEa8C139A6d483B8 | 1112               |5224473277236331295         | CCIP      |
|  | Meter Testnet | 0x8Ad1E752d892c97243C6c7fF28A216C472e21E56 | 83                 |40156                       | Layer Zero|

### OP Sepolia
| Blockchain | Contract                        | Address                                  |Version|Description|
|------------|---------------------------------|------------------------------------------|-------|-----------|
|11155420    |RESERVED_GILT_ADMIN              |0xC1436aD1dAc368a81AF38E25Faf4cCe8872B2746|  0    |-|
|11155420    |RESERVED_GILT_OPS_REGISTER       |0x2578A2FF9BA8Ec2242f658AAE1bF8aD7B8b1956D|  6    |*Optimised*|
|11155420    |RESERVED_GILT_FUNDS_VAULT_FACTORY|0xa07CB323a8063d477c887613aBB50F2174296500|  6    |*Optimised*|
|11155420    |RESERVED_GILT_CONTRACT           |0x6eC701943326c42cB49F9a9aa324E4337FbA60c2|  18   |*Optimised*|
|11155111    |RESERVED_GILT_TRANSFER_VAULT     |0x901d9fe7448f71114c728e2720C6fc3A7790F67B|   6   |*Optimised*|
|11155111    |RESERVED_GILT_LOCATION_REGISTER  |0x02f8F662150ab0758719aCdF789D7A8C64C71D6b|   4   |*Optimised*|
|11155111    |RESERVED_GILT_CCIP_TELEPORTER         |0x974b9F9899A63ae9c30FEa8211053fbaF03246bD|   13  |*Optimised*|
|11155111    |CCIP_ROUTER                      |0x114A20A10b43D4115e5aeef7345a1A71d2a60C57|   0   |*Optimised*|
|11155111    |RESERVED_GILT_CCIP_RECIEVER      |0x2ff1343BBE12a5e29990C648eEa8C139A6d483B8|   14  |*Optimised*|

#### Available Destinations 

|ID| Name             | Reciever Address                           | Universal Chain Id |Transport Protocol Chain Id | Transport | 
|--|------------------|--------------------------------------------|--------------------|----------------------------|-----------|
|  | Sepolia          | 0x9E520879F74b8FF4262cb77c7964D13237C60Fb9 | 11155111           | 16015286601757825753       | CCIP      |
|  | Arbitrum Sepolia | 0x2ff1343BBE12a5e29990C648eEa8C139A6d483B8 | 11155420           | 5224473277236331295        | CCIP      |
|  | Base Sepolia     | 0x9E520879F74b8FF4262cb77c7964D13237C60Fb9 | 84532              | 10344971235874465080       | CCIP      |
|  | WeMix Testnet    | 0x2ff1343BBE12a5e29990C648eEa8C139A6d483B8 | 1112               | 5224473277236331295        | CCIP      |
|  | Meter Testnet    | 0x8Ad1E752d892c97243C6c7fF28A216C472e21E56 | 83                 |40156                       | Layer Zero|

### Base Sepolia
| Blockchain | Contract                        | Address                                  |Version|Description|
|------------|---------------------------------|------------------------------------------|-------|-----------|
|84532       |RESERVED_GILT_ADMIN              |0xC1436aD1dAc368a81AF38E25Faf4cCe8872B2746|   0   |-|
|84532       |RESERVED_GILT_OPS_REGISTER       |0x2578A2FF9BA8Ec2242f658AAE1bF8aD7B8b1956D|   6   |*Optimised*|
|84532       |RESERVED_GILT_FUNDS_VAULT_FACTORY|0xa07CB323a8063d477c887613aBB50F2174296500|   6   |*Optimised*|
|84532       |RESERVED_GILT_CONTRACT           |0x6eC701943326c42cB49F9a9aa324E4337FbA60c2|   18  |*Optimised*|
|84532       |RESERVED_GILT_TRANSFER_VAULT     |0x847ed1C4d0141cEb2B559244EfADc7C885F44752|   6   |*Optimised*|
|84532       |RESERVED_GILT_LOCATION_REGISTER  |0x131312E32Ac6a4c6969C175698fDCeFC4c6fC530|   4   |*Optimised*|
|84532       |RESERVED_GILT_CCIP_TELEPORTER         |0x6F548Fb772dcc2c7398da498E6aD6D248dA7970d|   13  |*Optimised*|
|84532       |CCIP_ROUTER                      |0xD3b06cEbF099CE7DA4AcCf578aaebFDBd6e88a93|   0   |*Optimised*|
|84532       |RESERVED_GILT_CCIP_RECIEVER      |0x9E520879F74b8FF4262cb77c7964D13237C60Fb9|   14  |*Optimised*|

#### Available Destinations 

|ID| Name             | Reciever Address                           | Universal Chain Id |Transport Protocol Chain Id | Transport | 
|--|------------------|--------------------------------------------|--------------------|----------------------------|-----------|
|  | Sepolia          | 0x9E520879F74b8FF4262cb77c7964D13237C60Fb9 | 11155111           |16015286601757825753        | CCIP      |
|  | OP Sepolia       | 0x2ff1343BBE12a5e29990C648eEa8C139A6d483B8 | 11155420           |5224473277236331295         | CCIP      |
|  | Arbitrum Sepolia | 0xC3330816DF629EBf867F2e7B3A76Bc2DD5A94d07 | 84532              |10344971235874465080        | CCIP      |
|  | Meter Testnet    | 0x8Ad1E752d892c97243C6c7fF28A216C472e21E56 | 83                 |40156                       | Layer Zero|

### Wemix Testnet
| Blockchain | Contract                        | Address                                  |Version|Description|
|------------|---------------------------------|------------------------------------------|-------|-----------|
|1112        |RESERVED_GILT_ADMIN              |0xC1436aD1dAc368a81AF38E25Faf4cCe8872B2746|   0   | - |
|1112        |RESERVED_GILT_OPS_REGISTER       |0x2578A2FF9BA8Ec2242f658AAE1bF8aD7B8b1956D|   6   | (EVM: paris)|
|1112        |RESERVED_GILT_FUNDS_VAULT_FACTORY|0xb477c73223ba9B4Bb1566b028c4bb7aFbd8a9752|   6   |*Optimised* (EVM: paris)|
|1112        |RESERVED_GILT_CONTRACT           |0xa07CB323a8063d477c887613aBB50F2174296500|   18  |*Optimised* (EVM: paris)|
|1112        |RESERVED_GILT_TRANSFER_VAULT     |0x901d9fe7448f71114c728e2720C6fc3A7790F67B|   6   |*Optimised* (EVM: paris)|
|1112        |RESERVED_GILT_LOCATION_REGISTER  |0x02f8F662150ab0758719aCdF789D7A8C64C71D6b|   4   |*Optimised* (EVM: paris)|
|1112        |RESERVED_GILT_CCIP_TELEPORTER    |0x974b9F9899A63ae9c30FEa8211053fbaF03246bD|   12  |*Optimised* (EVM: paris)|
|1112        |CCIP_ROUTER                      |0xA8C0c11bf64AF62CDCA6f93D3769B88BdD7cb93D|   0   |*Optimised* (EVM: paris)|
|1112        |RESERVED_GILT_CCIP_RECIEVER      |0x2ff1343BBE12a5e29990C648eEa8C139A6d483B8|   14  |*Optimised* (EVM: paris)|

#### Available Destinations 

|ID| Name             | Reciever Address                           | Universal Chain Id |Transport Protocol Chain Id | Transport | 
|--|------------------|--------------------------------------------|--------------------|----------------------------|-----------|
|  | Sepolia          | 0x9E520879F74b8FF4262cb77c7964D13237C60Fb9 | 11155111           |16015286601757825753        | CCIP      |
|  | OP Sepolia       | 0x2ff1343BBE12a5e29990C648eEa8C139A6d483B8 | 11155420           |5224473277236331295         | CCIP      |
|  | Arbitrum Sepolia | 0xC3330816DF629EBf867F2e7B3A76Bc2DD5A94d07 | 421614             |5224473277236331295         | CCIP      |
|  | Meter Testnet    | 0x8Ad1E752d892c97243C6c7fF28A216C472e21E56 | 83                 |40156                       | Layer Zero|



### Sepolia
| Blockchain | Contract                        | Address                                  |Version|Description |
|------------|---------------------------------|------------------------------------------|-------|------------|
|11155111    |RESERVED_GILT_ADMIN              |0xC1436aD1dAc368a81AF38E25Faf4cCe8872B2746|   0   |*Optimised* |
|11155111    |RESERVED_GILT_OPS_REGISTER       |0xa07CB323a8063d477c887613aBB50F2174296500|   6   |*Optimised* |
|11155111    |RESERVED_GILT_FUNDS_VAULT_FACTORY|0xb477c73223ba9B4Bb1566b028c4bb7aFbd8a9752|   6   |*Optimised* |
|11155111    |RESERVED_GILT_CONTRACT           |0x4b65fb1ab23652d2a40288ce1774c0439Bb427cA|   18  |*Optimised* |
|11155111    |RESERVED_GILT_TRANSFER_VAULT     |0x131312E32Ac6a4c6969C175698fDCeFC4c6fC530|   6   |*Optimised* |
|11155111    |RESERVED_GILT_LOCATION_REGISTER  |0x3bCad7c3dD7D7687CE3eFDa16FC414577b9b6523|   6   |*Optimised* (EVM: paris) |
|11155111    |RESERVED_GILT_CCIP_TELEPORTER    |0x6F548Fb772dcc2c7398da498E6aD6D248dA7970d|   12  |*Optimised* |
|11155111    |CCIP_ROUTER                      |0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59|   0   |*Optimised* |
|11155111    |RESERVED_GILT_CCIP_RECIEVER      |0x9E520879F74b8FF4262cb77c7964D13237C60Fb9|   14  |*Optimised* |
|11155111    |RESERVED_GILT_LAYER_ZERO_TELEPORTER||||
|11155111    |RESERVED_GILT_LAYER_ZERO_TELEPORTER||||

#### Available Destinations 

|ID| Name              | Reciever Address                           | Universal Chain Id |Transport Protocol Chain Id | Transport | 
|--|-------------------|--------------------------------------------|--------------------|----------------------------|-----------|
|  | Wemix Testnet     | 0x2ff1343BBE12a5e29990C648eEa8C139A6d483B8 | 11155111           |16015286601757825753        | CCIP      |
|  | OP Sepolia        | 0x2ff1343BBE12a5e29990C648eEa8C139A6d483B8 | 11155420           |5224473277236331295         | CCIP      |
|  | Base Sepolia      | 0x9E520879F74b8FF4262cb77c7964D13237C60Fb9 | 84532              |10344971235874465080        | CCIP      |
|  | Arbitrum Sepolia  | 0xC3330816DF629EBf867F2e7B3A76Bc2DD5A94d07 | 421614             |5224473277236331295         | CCIP      |
|  | Meter Testnet     | 0x8Ad1E752d892c97243C6c7fF28A216C472e21E56 | 83                 |40156                       | Layer Zero|