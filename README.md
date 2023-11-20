# Extend_HLF_testnetwork
## Installing Hyperledger Fabric test-network
- Install test-network
  
### Step 1: Installing Hyperledger Fabric version 2.2.1
To install the test-network, you can follow the instructions in the [Hyperledger Fabric documentation](https://hyperledger-fabric.readthedocs.io/en/latest/install.html) **or** execute the following commands:

```bash
curl -sSLO https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh && chmod +x install-fabric.sh
./install-fabric.sh --fabric-version 2.2.1 docker samples binary
```  
Follow the step-by-step instructions detailed in [this link](https://hyperledger-fabric.readthedocs.io/en/latest/test_network.html#using-the-fabric-test-network ) to confirm the proper functionality of the test-network.
## Extend test-network
- clone this repository
  
step 3: go to the location where the fabric-sample directory is located. For example, if the address of the fabric-sample directory is /home/file1/fabric-sample, go to /home/file1, then clone the master branch of this repository.

step 4: In the "Extend_HLF_testnetwork" folder repository, open a terminal and run the following command:
~~~
./mergefiles.sh
~~~

step 5: Execute the desired setup_?_?.sh script(s) in the fabric-sample/test-network directory using the following command format:
~~~
./setup_?_?.sh
~~~
Replace '?' with the desired script identifier to proceed.





