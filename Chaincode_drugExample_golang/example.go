package main

import (
	"encoding/json"
	"fmt"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

// PharmacyDrug is a struct to represent a drug
type PharmacyDrug struct {
	ID          string `json:"id"`
	Name        string `json:"name"`
	Quantity    int    `json:"quantity"`
	ExpireDate  string `json:"expireDate"`
	ProductDate string `json:"productDate"`
}

// DrugContract is the main contract for managing drugs
type DrugContract struct {
	contractapi.Contract
}

// AddDrug adds a new drug to the ledger
func (c *DrugContract) AddDrug(ctx contractapi.TransactionContextInterface, id string, name string, quantity int, expireDate string, productDate string) error {
	existingDrug, err := ctx.GetStub().GetState(id)
	if err != nil {
		return fmt.Errorf("failed to read from world state: %v", err)
	}
	if existingDrug != nil {
		return fmt.Errorf("drug with ID %s already exists", id)
	}

	newDrug := &PharmacyDrug{
		ID:          id,
		Name:        name,
		Quantity:    quantity,
		ExpireDate:  expireDate,
		ProductDate: productDate,
	}

	drugBytes, err := json.Marshal(newDrug)
	if err != nil {
		return fmt.Errorf("failed to marshal drug: %v", err)
	}

	err = ctx.GetStub().PutState(id, drugBytes)
	if err != nil {
		return fmt.Errorf("failed to write to world state: %v", err)
	}

	return nil
}

// GetAllDrugs returns all drugs from the ledger
func (c *DrugContract) GetAllDrugs(ctx contractapi.TransactionContextInterface) ([]*PharmacyDrug, error) {
	// range query with empty startKey and endKey does an "index scan" of all drugs
	resultsIterator, err := ctx.GetStub().GetStateByRange("", "")
	if err != nil {
		return nil, fmt.Errorf("failed to get drugs: %v", err)
	}
	defer resultsIterator.Close()

	var drugs []*PharmacyDrug
	for resultsIterator.HasNext() {
		queryResponse, err := resultsIterator.Next()
		if err != nil {
			return nil, fmt.Errorf("failed to get drug from iterator: %v", err)
		}

		var drug PharmacyDrug
		err = json.Unmarshal(queryResponse.Value, &drug)
		if err != nil {
			return nil, fmt.Errorf("failed to unmarshal drug bytes: %v", err)
		}

		drugs = append(drugs, &drug)
	}

	return drugs, nil
}

// SellDrug sells a drug from the ledger
func (c *DrugContract) SellDrug(ctx contractapi.TransactionContextInterface, id string, quantity int) error {
	drugBytes, err := ctx.GetStub().GetState(id)
	if err != nil {
		return fmt.Errorf("failed to read from world state: %v", err)
	}
	if drugBytes == nil {
		return fmt.Errorf("drug with ID %s does not exist", id)
	}

	var drug PharmacyDrug
	err = json.Unmarshal(drugBytes, &drug)
	if err != nil {
		return fmt.Errorf("failed to unmarshal drug bytes: %v", err)
	}

	if drug.Quantity < quantity {
		return fmt.Errorf("not enough quantity available for drug with ID %s", id)
	}

	drug.Quantity -= quantity

	drugBytes, err = json.Marshal(drug)
	if err != nil {
		return fmt.Errorf("failed to marshal drug: %v", err)
	}

	err = ctx.GetStub().PutState(id, drugBytes)
	if err != nil {
		return fmt.Errorf("failed to write to world state: %v", err)
	}

	return nil
}

// InitLedger adds 10 initial drugs to the ledger
func (c *DrugContract) InitLedger(ctx contractapi.TransactionContextInterface) error {
	drugs := []*PharmacyDrug{}
	for i := 1; i <= 1000; i++ {
		drug := &PharmacyDrug{
			ID:          fmt.Sprintf("%05d", i),
			Name:        fmt.Sprintf("Drug %d", i),
			Quantity:    50,
			ExpireDate:  "2026-12-31",
			ProductDate: "2023-01-01",
		}
		drugs = append(drugs, drug)
	}

	// Save the drugs to the ledger
	for _, drug := range drugs {
		err := c.AddDrug(ctx, drug.ID, drug.Name, drug.Quantity, drug.ExpireDate, drug.ProductDate)
		if err != nil {
			return fmt.Errorf("failed to add drug %s: %v", drug.ID, err)
		}
	}

	return nil
}

// GetDrug returns the drug with the given ID from the ledger
func (c *DrugContract) GetDrug(ctx contractapi.TransactionContextInterface, drugID string) (*PharmacyDrug, error) {
	existingDrugBytes, err := ctx.GetStub().GetState(drugID)
	if err != nil {
		return nil, fmt.Errorf("failed to read from world state: %v", err)
	}
	if existingDrugBytes == nil {
		return nil, fmt.Errorf("drug with ID %s does not exist", drugID)
	}

	var drug PharmacyDrug
	err = json.Unmarshal(existingDrugBytes, &drug)
	if err != nil {
		return nil, fmt.Errorf("failed to unmarshal drug data: %v", err)
	}

	return &drug, nil
}

// main function starts the chaincode
func main() {
	chaincode, err := contractapi.NewChaincode(&DrugContract{})
	if err != nil {
		fmt.Printf("Error creating drug chaincode: %v", err)
		return
	}

	if err := chaincode.Start(); err != nil {
		fmt.Printf("Error starting drug chaincode: %v", err)
	}
}
