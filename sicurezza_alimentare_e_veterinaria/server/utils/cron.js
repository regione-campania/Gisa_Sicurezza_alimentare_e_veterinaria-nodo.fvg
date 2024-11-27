/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
const cron = require('node-cron');
const bdnDwl = require('../bdn_dwl/bdn_dwl');
const bdnDwlFunzioni = require('../bdn_dwl/funzioni');
const preacc = require('./preaccettazioneFunctions');

const MIDNIGHT = "0 0 * * *";
const EVERY_MINUTE = "* * * * *";
const EVERY_5_MINUTES = "*/5 * * * *";
const EVERY_30_MINUTES = "*/30 * * * *";
const EVERY_10_SECONDS = " */10 * * * * *";
const EVERY_SUNDAY_EVENING = "0 20 * * SUN"

initScheduledJobs = function() {

    cron.schedule(EVERY_SUNDAY_EVENING, () => {
        console.log("start: jobAllienaCapiWS")
        bdnDwlFunzioni.jobAllienaCapiWS();
    }).start();

    cron.schedule(MIDNIGHT, () => {
        console.log("start: getElaborazioni")
        bdnDwl.getElaborazioni();
    }).start();

    cron.schedule(MIDNIGHT, () => {
        console.log("start: jobIZSVE")
        preacc.recuperaPreaccettazioni();
    }).start();

    cron.schedule('0 18 16 05 5', () => {
        console.log("start: jobIZSVE")
        bdnDwlFunzioni.allineaAllevamenti(true);
    }).start();
    
    console.log("CRON TASK AVVIATI");
}

exports.initScheduledJobs = initScheduledJobs;