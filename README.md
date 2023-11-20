# Extend_HLF_testnetwork

This branch installs Fabcar of [caliper-benchmarks version 0.5](https://hyperledger.github.io/caliper/v0.5.0/getting-started/)  in the extended network as explained in the README file of the master branch.

## Hyperledger Fabric test-network

1. Successfully complete all the steps mentioned in the [README](https://github.com/rezajavan/Extend_HLF_testnetwork/tree/master) file of the master branch.

2. Copy all setup&IFC_?_?.sh files from this branch's folder to the "fabric-sample/test-network" directory (master branch).

3. Navigate to "fabric-sample/test-network" and execute this command:

```bash
./downfabric.sh
```
## Setup and install Fabcar on the extended network
Execute the desired setup&IFC_?_?.sh script(s) in the "fabric-sample/test-network" directory using the following command format:
~~~
./setup&IFC_?_?.sh
~~~
Replace '?' with the desired script identifier to proceed.

## Using caliper-benchmarks

To utilize caliper-benchmarks for this network, please install [caliper benchmark version 0.5](https://hyperledger.github.io/caliper/v0.5.0/getting-started/) in a folder alongside 'fabric-sample'.

### Steps:

1. Begin by shutting down the "Extend_HLF_testnetwork":
    - Go to "fabric-sample/test-network" and execute:
    ```bash
    ./downfabric.sh
    ```

2. Install [caliper benchmark](https://hyperledger.github.io/caliper/v0.5.0/getting-started/).

3. Verify the functionality by executing commands from the README file located in ""caliper-benchmarks/tree/main/networks/fabric"".

4. Next, modify the network structure by executing setup&IFC_?_?.sh script(s) and following the instructions in the README file located in ""caliper-benchmarks/tree/main/networks/fabric"". Only the network configuration changes while everything else remains the same.

