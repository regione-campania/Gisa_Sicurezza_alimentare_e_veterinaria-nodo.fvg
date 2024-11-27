/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
const express = require('express');
const cookieSession = require('express-session')
const cors = require('cors');
const bodyParser = require("body-parser");
const fileUpload = require('express-fileupload');
const fs = require('fs');
const conf = require('../config/config');
const path = require('path');
const compression = require('compression');

if (process.env.NODE_APP_INSTANCE == 0 || process.env.NODE_APP_INSTANCE == undefined) { //se viene lanciato su pm2 solo il primo processo deve lanciare i cron
    const cron = require('../utils/cron');
    cron.initScheduledJobs();
}


//rotte
const ce = require('../routes/certificatiExport');
const um = require('../routes/um');

var app = express();
app.disable("x-powered-by");

app.enable('trust proxy')

app.use(compression());

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json({ limit: '1000mb' }));

// enable files upload
app.use(fileUpload({ createParentPath: true }));


const whitelist = conf.corsWhitelist;
app.use(function (req, res, next) {
    let origin = req.headers.origin || req.headers.referer;
    let corsWhitelisted = false;
    if(!origin){
        origin = whitelist[0];
        corsWhitelisted = true;
        res.header("Access-Control-Allow-Origin", origin);
    }else{
        origin = whitelist.some(w => origin.includes(w)) ? origin : whitelist[0];
        res.header("Access-Control-Allow-Origin", origin);
    }
    res.header("Access-Control-Allow-Methods", "GET,HEAD,OPTIONS,POST,PUT");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization");
    res.header('Access-Control-Allow-Credentials', true);
    /*if(!req.headers.referer?.includes(conf.path)){ //REFER CHECK
        res.writeHead(400).end();
        return;
    }*/
    //console.log(origin, req.headers.referer);
    if(!corsWhitelisted && mountedRoutes.some(m => req.url.includes(m)) && !req.headers.referer?.includes(origin) && !conf.referWhitelist.some(w => req.headers.referer?.includes(w))){ //REFER CHECK
        console.log("refer non valido");
        console.log(origin, req.headers.referer);
        res.writeHead(400).end();
        return;
    }
    next();
});

//monto rotte
app.use(conf.path + '/ce', ce);
app.use(conf.path + '/um', um);
app.use(conf.path + '/', express.static('static'));

mountedRoutes = [conf.path + '/ce', conf.path + '/um'];

exports.app = app;