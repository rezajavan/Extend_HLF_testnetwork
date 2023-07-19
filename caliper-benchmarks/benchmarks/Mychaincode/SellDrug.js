const { WorkloadModuleBase } = require('@hyperledger/caliper-core');

/**
 * Workload module for the SellDrug function in the mychain chaincode.
 */
class SellDrugWorkload extends WorkloadModuleBase {
    /**
     * Initializes the workload module instance.
     */
    constructor() {
        super();
        this.txIndex = 0;
    }

    /**
     * Assemble TXs for the round.
     * @return {Promise<TxStatus[]>}
     */
    async submitTransaction() {
        this.txIndex++;

        // Generate a random drug ID within the range of "00200"
        const min = 1;
        const max = 9000;
        const randomId = Math.floor(Math.random() * (max - min + 1) + min).toString().padStart(5, '0');

        const args = {
            contractId: 'basic',
            contractVersion: 'v0',
            contractFunction: 'SellDrug',
            contractArguments: [randomId, 1],
            timeout: 30
        };

        await this.sutAdapter.sendRequests(args);
    }
}

/**
 * Create a new instance of the workload module.
 * @return {WorkloadModuleInterface}
 */
function createWorkloadModule() {
    return new SellDrugWorkload();
}

module.exports.createWorkloadModule = createWorkloadModule;

