/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
var utils = {

    italianStringDateToIsoDate: function(date){
        let s = date.split('-')
        return s[2]+'-'+s[1]+'-'+s[0];
    },

    getXmlValueByTagName: function(string, tag){
        var re = new RegExp(`<*${tag}.*>(.*?)<\/.*${tag}>`, "gmi");
        var res = re.exec(string);
        if(res)
            return res[1];
        return null;
    },

    getXmlValueByTagNameMultipleLines: function (string, tag) {
        var re = new RegExp(`<${tag}>([\\s\\S]*?)<\/.*${tag}>`, "gmi");
        var res;
        var allMatches = [];

        do {
            res = re.exec(string);
            if (res) {
                allMatches.push(res[1]);
            }
        } while (res);

        if (allMatches.length > 0) return allMatches;
        return null;
    },

    getInlineXmlValueByTagName: function (string, tag) {
        var re = new RegExp(`<${tag}(.*?)\/>`, "gmi");
        var res = re.exec(string);
        if (res)
            return res[1];
        return null;
    },

    getNestedXmlValueByTagName: function (string, tag) {
        var re = new RegExp(`<${tag}>(.*?)<.*${tag}>`, "gmi");
        var res = re.exec(string);
        if (res)
            return res[0];
        return null;
    },

    getAttributeFromXmlTag: function (string, tag) {
        var re = new RegExp(` ${tag}="(.*?)"`, "gmi");
        var res = re.exec(string);
        if (res)
            return res[1];
        return null;
    },
    
    getJSONFromRows: function(rows, livelloColumnName) {
        // console.log("rows:", rows);

        let livello = 'livello';
        if (livelloColumnName) livello = livelloColumnName;
        
        let json = '';
        let json2 = ' {';
        let count = 0;
        let descr = null;
        const keys = Object.keys(rows[0]);
        let lev_start = lev_prec = rows[0][livello];

        // Albero JSON ...
        rows.forEach(row => {
            if (lev_prec == row[livello] && row[livello] != lev_start) {
                json = json + '},';
            } else if (lev_prec < row[livello]) {
                json = json + `, "children": [  `;
                lev_prec = row[livello];
            } else if (row[livello] != lev_start) {
                for (let i = row[livello]; i < lev_prec; i++) {
                    json = json + '}';
                    for (let j = lev_start; j < i; j++) {
                        json = json + '    ';
                    }
                    json = json + ']';
                }
                json = json + '},';
                lev_prec = row[livello];
            }
            json = json + `
            `;
            for (let i = lev_start; i < lev_prec; i++) {
                json = json + '    ';
            }
            let additiveText = '';
            json2 = ' {';
            keys.forEach((key, index) => {
                additiveText = (index == 0 ? '' : ', ');
                if(typeof row[key] == 'string'){
                    let stringa = row[key].trim();
                    stringa = stringa.replace(/'/g, `\'`);
                    stringa = stringa.replace(/\r\n|\n|\r/g, '');
                    json2 = json2 + additiveText + `"${key}":"${stringa}"`;
                }
                else
                    json2 = json2 + additiveText + `"${key}":"${row[key]}"`;
            })
            json2 = json2 + `, "count":"${count}"`;
            count++;
            json = json + json2;
        })
        for(let i = lev_start; i < lev_prec; i++) {
            json = json + '} ]';
        }
        json = json + '} ';

        console.log(json);
        return JSON.parse(json);
    }
}

module.exports = utils;