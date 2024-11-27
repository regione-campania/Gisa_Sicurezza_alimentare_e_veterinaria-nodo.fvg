/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
const express = require('express');
const bodyParser = require("body-parser");
const fileUpload = require('express-fileupload');
const compression = require('compression');
var minify = require('express-minify');
var conf = null;
try{
   conf = require('../config/config.js') ;
}catch(err){
   conf = require('../config/config.js.sample')
}

var mountedRoutes = [];

if(process.env.NODE_APP_INSTANCE == 0 || process.env.NODE_APP_INSTANCE == undefined){ //se viene lanciato su pm2 solo il primo processo deve lanciare i cron
    const cron = require('../utils/cron');
    cron.initScheduledJobs();
}

var app = express();
app.disable("x-powered-by");

//rotte
var um = require('../routes/um');
var api = require('../routes/api');
var agendaOperatori = require('../routes/agendaOperatori');
var bdnfvg = require('../routes/bdnfvg');
var spid = require('../routes/spid');
var documenti = require('../routes/documenti');
var cu = require('../routes/cu');
var fatturazione = require('../routes/fatturazione');
var anagraficaunica = require('../routes/anagraficaunica');
var verbali_cu = require('../routes/verbali');
var preaccettazione = require('../routes/preaccettazione');
var geolocalizzazioneIndirizzo = require('../routes/geolocalizzazioneIndirizzo');
var rbac = require('../routes/rbac');
const  auth  = require('../utils/auth.js');


app.use(compression());
if(process.argv[2] != 'local' && process.argv[2] != 'dev')
    app.use(minify());

app.enable('trust proxy');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json({limit: '100mb'}));

// enable files upload
app.use(fileUpload({createParentPath: true}));


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
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization, Location");
    res.header('Access-Control-Allow-Credentials', true);

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
app.use(conf.path + '/um', um);
app.use(conf.path + '/api', api);
app.use(conf.path + '/agendaOperatori', agendaOperatori);
app.use(conf.path + '/bdnfvg', bdnfvg);
app.use(conf.path + '/spid', spid);
app.use(conf.path + '/documenti', documenti);
app.use(conf.path + '/cu', cu);
app.use(conf.path + '/fatturazione', fatturazione);
app.use(conf.path + '/anagraficaunica', anagraficaunica);
app.use(conf.path + '/verbali_cu', verbali_cu);
app.use(conf.path + '/preaccettazione', preaccettazione);
app.use(conf.path + '/geolocalizzazioneIndirizzo', geolocalizzazioneIndirizzo);
app.use(conf.path + '/rbac', rbac);

app.use(conf.path + '/manuali/*(pdf)', auth.authenticateToken, (req, res) => {
    var path = require('path');
    console.log('manuali');
    console.log(req.baseUrl);
    res.download(path.join('static', req.baseUrl.replace(conf.path, '')));
} );

mountedRoutes = [conf.path + '/um', conf.path + '/api', conf.path + '/agendaOperatori', 
conf.path + '/bdnfvg', conf.path + '/spid', conf.path + '/documenti', conf.path + '/cu', conf.path + '/fatturazione', 
conf.path + '/anagraficaunica', conf.path + '/verbali_cu', conf.path + '/preaccettazione', conf.path + '/rbac'];

// monto static
app.use(express.static('static'));

app.set("view options", {layout: false, index: 'index.html'});
app.set('view engine', 'ejs');
app.use(conf.path + '/', express.static('views'));
app.use(conf.path + '/', express.static('static'));
app.use(conf.path + '/angular-packages', express.static('static/angular/pkg'));


exports.app = app;