# Extend_HLF_testnetwork
## Install Hyper ledger fabric test-network
- Install test-network
  
step 1: Install hyper ledger fabric version 2.2.1.
[install hyper ledger fabric document](https://hyperledger-fabric.readthedocs.io/en/latest/install.html) **or** install by these commands:

~~~
curl -sSLO https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh && chmod +x install-fabric.sh
./install-fabric.sh  --fabric-version 2.2.1 docker samples binary
~~~
- make sure test-network works correctly
  
step 2: By following the step-by-step instructions in [this link](https://hyperledger-fabric.readthedocs.io/en/latest/test_network.html#using-the-fabric-test-network ), we can verify that the test-network is functioning correctly.
## Extend test-network
- clone this repository
  
step 3: go to the location where the fabric-sample directory is located. For example, if the address of the fabric-sample directory is /home/file1/fabric-sample, go to /home/file1, then clone the master branch of this repository.

step 4: go to the "Extend_HLF_testnetwork" folder repository, open a terminal, and execute this command:
~~~
./mergefiles.sh
~~~

step 5: execute each setup_?_?.sh script that you want in the fabric-sample/test-network directory. Command is: 
~~~
./setup_?_?.sh
~~~






