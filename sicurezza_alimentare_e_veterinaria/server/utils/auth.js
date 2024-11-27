/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
const jwt = require('jsonwebtoken');
const conf = require('../config/config.js');



function generateAccessToken(data) {
    return jwt.sign(data, conf.tokenSecret, { expiresIn: '12h' }).split("").reverse().join("");
}

function authenticateToken(req, res, next) {
    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1].split("").reverse().join("")

    if(req.headers["access-control-request-headers"] == 'authorization'){
        next();
        return;
    }

    if (token == null){
        console.log("AuthToken null");
        return res.sendStatus(401);
    } 

    jwt.verify(token, conf.tokenSecret, (err, decryptedData) => {

        if (err){
            console.log("AuthToken non valido");
            console.log("Sessione scaduta " + JSON.stringify(decryptedData))
            return res.sendStatus(403);
        } 
        req.authData = decryptedData;
        console.log("Utente autorizzato " + JSON.stringify(req.authData))
        next()
    })
}

function getUser(req, res) {
    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1].split("").reverse().join("");

    jwt.verify(token, conf.tokenSecret, (err, decryptedData) => {

        if (err){
            console.log("AuthToken non valido");
            console.log(err);
            return res.sendStatus(403);
        } 
        req.authData = decryptedData;
        console.log("Utente autorizzato " + JSON.stringify(req.authData))
        res.send(req.authData).end();
    })
}

async function checkAccessilibitaMenu(req, res, funzione, args, idUtente, conn) {
    if (funzione != 'get_portali' && funzione != 'get_menu' && funzione != 'get_avvisi_for_risorsa'){
        const queryCheck = {
            text: ` call ag_srv.get_dati($1, $2, $3, '{}')`,
            values: ['get_menu', '{"menu": "check"}', idUtente]
        }
        let result = await conn.client.query(queryCheck);
        let sezioni = JSON.parse(result.rows[0].joutput.info);
        //console.log(sezioni);
        for(let sez of sezioni){
            if(req.headers.location.includes(sez.cod)){ // controllo se la sezione da cui sto chiedendo i dati è controlabile
                console.log('portale ' + req.headers.location.split('/portali/')[1].split('/')[0]);
                const queryCheck2 = {
                    text: ` call ag_srv.get_dati($1, $2, $3, '{}')`,
                    values: ['get_menu', '{"menu": "' + req.headers.location.split('/portali/')[1].split('/')[0].replace('fvg','') + '"}', idUtente]
                }
                result = await conn.client.query(queryCheck2);
                    
                let sezioni2 = JSON.parse(result.rows[0].joutput.info);

                let found = false;
                console.log("controllo " + req.headers.location )
                if(sezioni2){
                    for(let sez of sezioni2){
                        if(req.headers.location.includes(sez.cod)){
                            console.log('AUTORIZED ' + sez.cod)
                            found = true;
                        }else{
                        // console.log('UNAUTORIZED ' + sez.cod)
                        }
                    }
                    if(!found){
                        console.log('UNAUTORIZED');
                    //  res.sendStatus(403);
                        return false;
                    } 
                }
            }
        }
        return true;
    }else{
        return true;
    }
}


exports.generateAccessToken = generateAccessToken;
exports.authenticateToken = authenticateToken;
exports.getUser = getUser;
exports.checkAccessilibitaMenu = checkAccessilibitaMenu;
