/*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

'use strict';

const { WorkloadModuleBase } = require('@hyperledger/caliper-core');

const names = ["name20", "name21", "name22", "name23", "name24", "name25", "name26", "name27", "name28", "name29"];
const quantitys = [100, 500, 1000, 20000, 30000, 40000, 50000, 5000, 356422, 254646];
const expiredates = ["2026-10-12", "2027-10-12", "2024-10-11", "2028-10-12", "2029-10-12", "2030-10-12", "2025-1-12", "2024-10-12", "2026-10-12", "2026-10-12"];
const productdates = ["2023-10-12", "2023-10-12", "2023-10-11", "2021-10-12", "2022-10-12", "2020-10-12", "2019-1-12", "2023-10-12", "2023-10-12", "2022-10-12"];


/**
 * Workload module for the benchmark round.
 */
class CreateCarWorkload extends WorkloadModuleBase {
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
        let ID = `drug${this.workerIndex}-${this.txIndex}-${Date.now()}`;
        let name = names[Math.floor(Math.random() * names.length)];
        let quantity = quantitys[Math.floor(Math.random() * quantitys.length)];
        let expiredate = expiredates[Math.floor(Math.random() * expiredates.length)];
        let productdate = productdates[Math.floor(Math.random() * productdates.length)];

        let args = {
            contractId: 'basic',
            contractVersion: 'v0',
            contractFunction: 'AddDrug',
            contractArguments: [ID, name,quantity,expiredate,productdate],
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
    return new CreateCarWorkload();
}

module.exports.createWorkloadModule = createWorkloadModule;