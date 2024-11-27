/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
const conf = require("../config/config");
const request = require('request');

const izsveEP = `${conf.izsveServices.protocol}://${conf.izsveServices.host}:${conf.izsveServices.port}${conf.izsveServices.path}`;

var izse = {

    login: async function () {
        let url = `${izsveEP}/Connessione.Login?utente=${conf.izsveServices.username}&password=${conf.izsveServices.password}`;
        return new Promise((resolve, reject) => {
            request.get(
                url, function (error, response, data) {
                    if (error) {
                        console.log(err);
                        reject(err);
                    }
                    else if (!error && response.statusCode == 200) {
                        console.log(data);
                        resolve(data.toString());
                    }
                })
        });
    },


    logout: async function (sid) {
        let url = `${izsveEP}/Connessione.Logout?sid=${sid}`;
        request.get(
            url, function (error, response, data) {
                if (error) {
                    console.log(err);
                }
                else if (!error && response.statusCode == 200) {
                    console.log(data);
                }
            })
    },

    importaAccettazione: async function (xml, sid) {
        let url = `${izsveEP}/Accettazione.ImportaAccettazioni?sid=${sid}`;
        return new Promise((resolve, reject) => {
            request.post(
                { url: url, body: xml }, function (error, response, data) {
                    if (error) {
                        console.log(err);
                        reject(false);
                    }
                    else if (!error && response.statusCode == 200) {
                        console.log(data);
                        resolve(data.toString());
                    } else {
                        console.log(data);
                        resolve(false);
                    }
                })
        });
    },

    esportaAccettazione: async function (codice, sid) {
        let url = `${izsveEP}/Accettazione.EsportaAccettazioni?sid=${sid}&codInvio=${codice}`;
        return new Promise((resolve, reject) => {
            request.get(
                url, function (error, response, data) {
                    if (error) {
                        console.log(err);
                        reject(err);
                    }
                    else if (!error && response.statusCode == 200) {
                        console.log(data);
                        resolve(data.toString());
                    }
                })
        });
    },

    listaAccettazioni: async function (dataini, datafine, sid) {
        let url = `${izsveEP}/Accettazione.ListaAccettazioni?sid=${sid}&dataini=${dataini}&datafine=${datafine}`;
        return new Promise((resolve, reject) => {
            request.get(
                url, function (error, response, data) {
                    if (error) {
                        console.log(err);
                        reject(err);
                    }
                    else if (!error && response.statusCode == 200) {
                        console.log(data);
                        resolve(data.toString());
                    }
                })
        });
    },

    ListaRdpFirmati: async function (dataini, datafine, sid) {
        let url = `${izsveEP}/Accettazione.ListaRdpFirmati?sid=${sid}&firmadataini=${dataini}&firmadatafine=${datafine}`;
        return new Promise((resolve, reject) => {
            request.get(
                url, function (error, response, data) {
                    if (error) {
                        console.log(err);
                        reject(err);
                    }
                    else if (!error && response.statusCode == 200) {
                        console.log(data);
                        resolve(data.toString());
                    }
                })
        });
    },

    RefertoPDF: async function (rdpCod, sid, httpRes) {
       // rdpCod = 4605256 //da commenta
        httpRes.redirect(`${izsveEP}/Accettazione.RefertoPDF?rdpcod=${rdpCod}&sid=${sid}`);
        /*let url = `${izsveEP}/Accettazione.RefertoPDF?rdpcod=${rdpCod}&sid=${sid}`;
        return new Promise((resolve, reject) => {
            request.get(
                url, function (error, response, data) {
                    if (error) {
                        console.log(err);
                        reject(err);
                    }
                    else if (!error && response.statusCode == 200) {
                        console.log(data);
                        filename = response.headers["content-disposition"]?.split('filename=')[1];
                        resolve({esito: true, filename: filename, data: data});
                    }else if (!error && response.statusCode == 500) {
                        console.log(data);
                        reject({esito: false, info: data.toString()});
                    }
                })
        });*/
    }



}

module.exports = izse;