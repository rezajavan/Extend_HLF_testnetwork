'use strict';

const { WorkloadModuleBase } = require('@hyperledger/caliper-core');

/**
 * Workload module for the initledger function.
 */
class InitLedgerWorkload extends WorkloadModuleBase {
    /**
     * Initializes the workload module instance.
     */
    constructor() {
        super();
        this.runOnce = false;
    }

    /**
     * Assemble TXs for the round.
     * @return {Promise<TxStatus[]>}
     */
    async submitTransaction() {
        if (!this.runOnce) {
            let args = {
                contractId: 'basic',
                contractVersion: 'v0',
                contractFunction: 'InitLedger',
                contractArguments: [],
                readOnly: false
            };

            await this.sutAdapter.sendRequests(args);

            this.runOnce = true;
        }
    }
}

/**
 * Create a new instance of the workload module.
 * @return {WorkloadModuleInterface}
 */
function createWorkloadModule() {
    return new InitLedgerWorkload();
}

module.exports.createWorkloadModule = createWorkloadModule;

