#!/bin/bash

./network.sh up createChannel -s couchdb -ca
export PATH=${PWD}/../bin:$PATH
export FABRIC_CFG_PATH=$PWD/../config/


#add peers to org1
	#add peer1org1
export PATH=$PATH:${PWD}/../bin
export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/org1.example.com/

fabric-ca-client register --caname ca-org1 --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

mkdir -p organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com

fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca-org1 -M ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/msp --csr.hosts peer1.org1.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

cp ${PWD}/organizations/peerOrganizations/org1.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/msp/config.yaml

fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca-org1 -M ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls --enrollment.profile tls --csr.hosts peer1.org1.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

cp ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt

cp ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/server.crt

cp ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/server.key
sleep 1.5
docker-compose -f docker/docker-compose-peer1org1.yaml up -d

#read -p "Press enter to continue"

#add peer1 org1 to channel
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=localhost:8051
sleep 1.5
peer channel join -b channel-artifacts/mychannel.block
	#end peer1org1

	#add peer2org1
export PATH=$PATH:${PWD}/../bin
export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/org1.example.com/

fabric-ca-client register --caname ca-org1 --id.name peer2 --id.secret peer2pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

mkdir -p organizations/peerOrganizations/org1.example.com/peers/peer2.org1.example.com

fabric-ca-client enroll -u https://peer2:peer2pw@localhost:7054 --caname ca-org1 -M ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer2.org1.example.com/msp --csr.hosts peer2.org1.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

cp ${PWD}/organizations/peerOrganizations/org1.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer2.org1.example.com/msp/config.yaml

fabric-ca-client enroll -u https://peer2:peer2pw@localhost:7054 --caname ca-org1 -M ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer2.org1.example.com/tls --enrollment.profile tls --csr.hosts peer2.org1.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

cp ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer2.org1.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer2.org1.example.com/tls/ca.crt

cp ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer2.org1.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer2.org1.example.com/tls/server.crt

cp ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer2.org1.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer2.org1.example.com/tls/server.key
sleep 1.5
docker-compose -f docker/docker-compose-peer2org1.yaml up -d

#read -p "Press enter to continue"

#add peer2 org1 to channel
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer2.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=localhost:1051
sleep 1.5
peer channel join -b channel-artifacts/mychannel.block
	#end peer2org1

	#add peer3org1
export PATH=$PATH:${PWD}/../bin
export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/org1.example.com/

fabric-ca-client register --caname ca-org1 --id.name peer3 --id.secret peer3pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

mkdir -p organizations/peerOrganizations/org1.example.com/peers/peer3.org1.example.com

fabric-ca-client enroll -u https://peer3:peer3pw@localhost:7054 --caname ca-org1 -M ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/msp --csr.hosts peer3.org1.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

cp ${PWD}/organizations/peerOrganizations/org1.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/msp/config.yaml

fabric-ca-client enroll -u https://peer3:peer3pw@localhost:7054 --caname ca-org1 -M ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/tls --enrollment.profile tls --csr.hosts peer3.org1.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

cp ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/tls/ca.crt

cp ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/tls/server.crt

cp ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/tls/server.key
sleep 1.5
docker-compose -f docker/docker-compose-peer3org1.yaml up -d

#read -p "Press enter to continue"

#add peer3 org1 to channel
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=localhost:1151
sleep 1.5
peer channel join -b channel-artifacts/mychannel.block
	#end peer3org1





#end of add peers to org1

#read -p "Press enter to continue"



#add peers to org2
	#add peer1org2
export PATH=$PATH:${PWD}/../bin
export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/org2.example.com/

fabric-ca-client register --caname ca-org2 --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

mkdir -p organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com

fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca-org2 -M ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/msp --csr.hosts peer1.org2.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

cp ${PWD}/organizations/peerOrganizations/org2.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/msp/config.yaml

fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca-org2 -M ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls --enrollment.profile tls --csr.hosts peer1.org2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

cp ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/ca.crt

cp ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/server.crt

cp ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/server.key
sleep 1.5
docker-compose -f docker/docker-compose-peer1org2.yaml up -d

#read -p "Press enter to continue"

#add peer1 org2 to channel
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=localhost:6051
sleep 1.5
peer channel join -b channel-artifacts/mychannel.block
	#end peer1org2

	#add peer2org2
export PATH=$PATH:${PWD}/../bin
export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/org2.example.com/

fabric-ca-client register --caname ca-org2 --id.name peer2 --id.secret peer2pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

mkdir -p organizations/peerOrganizations/org2.example.com/peers/peer2.org2.example.com

fabric-ca-client enroll -u https://peer2:peer2pw@localhost:8054 --caname ca-org2 -M ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer2.org2.example.com/msp --csr.hosts peer2.org2.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

cp ${PWD}/organizations/peerOrganizations/org2.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer2.org2.example.com/msp/config.yaml

fabric-ca-client enroll -u https://peer2:peer2pw@localhost:8054 --caname ca-org2 -M ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer2.org2.example.com/tls --enrollment.profile tls --csr.hosts peer2.org2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

cp ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer2.org2.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer2.org2.example.com/tls/ca.crt

cp ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer2.org2.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer2.org2.example.com/tls/server.crt

cp ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer2.org2.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer2.org2.example.com/tls/server.key
sleep 1.5
docker-compose -f docker/docker-compose-peer2org2.yaml up -d

#read -p "Press enter to continue"

#add peer2 org2 to channel
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=localhost:2051
sleep 1.5
peer channel join -b channel-artifacts/mychannel.block
	#end peer2org2

	#add peer3org2
export PATH=$PATH:${PWD}/../bin
export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/org2.example.com/

fabric-ca-client register --caname ca-org2 --id.name peer3 --id.secret peer3pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

mkdir -p organizations/peerOrganizations/org2.example.com/peers/peer3.org2.example.com

fabric-ca-client enroll -u https://peer3:peer3pw@localhost:8054 --caname ca-org2 -M ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer3.org2.example.com/msp --csr.hosts peer3.org2.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

cp ${PWD}/organizations/peerOrganizations/org2.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer3.org2.example.com/msp/config.yaml

fabric-ca-client enroll -u https://peer3:peer3pw@localhost:8054 --caname ca-org2 -M ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer3.org2.example.com/tls --enrollment.profile tls --csr.hosts peer3.org2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org2/tls-cert.pem

cp ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer3.org2.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer3.org2.example.com/tls/ca.crt

cp ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer3.org2.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer3.org2.example.com/tls/server.crt

cp ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer3.org2.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer3.org2.example.com/tls/server.key
sleep 1.5
docker-compose -f docker/docker-compose-peer3org2.yaml up -d

#read -p "Press enter to continue"

#add peer3 org2 to channel
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=localhost:2151
sleep 1.5
peer channel join -b channel-artifacts/mychannel.block
	#end peer3org2





#end of add peers to org2






#read -p "Press enter to continue"
















./rename_priv_key_user1org1.sh;


