/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
const PizZip = require("pizzip");
const Docxtemplater = require("docxtemplater");
const ImageModule = require('docxtemplater-image-module-free');
const express = require("express");
var router = express.Router();
const conn = require('../db/connection');
const fs = require("fs");
const libre = require('libreoffice-convert');
const http = require('http');
const expressions = require("angular-expressions");
const assign = require("lodash.assign");
const moment = require("moment");
const auth = require('../utils/auth');
const path = require("path");

libre.convertAsync = require('util').promisify(libre.convert);

function angularParser(tag) {
	tag = tag
		.replace(/^\.$/, "this")
		.replace(/(’|‘)/g, "'")
		.replace(/(“|”)/g, '"');

	const expr = expressions.compile(tag);
	return {
		get: function (scope, context) {
			let obj = {};
			const scopeList = context.scopeList;
			const num = context.num;
			for (let i = 0, len = num + 1; i < len; i++) {
				obj = assign(obj, scopeList[i]);
			}
			return expr(scope, obj);
		},
	};
}


async function generaPdf(res, descModulo, filename, valori) {

	try {

		var opts = {}
		opts.centered = false; //Set to true to always center images
		opts.fileType = "docx"; //Or pptx
		opts.getImage = function (tagValue, tagName) {
			console.log(tagValue, tagName)
			return fs.readFileSync(tagValue);
		}
		opts.getSize = function (img, tagValue, tagName) {
			const maxWidth = 150;
			const maxHeight = 100;
			const sizeOf = require("image-size");
			const sizeObj = sizeOf(img);
			const widthRatio = sizeObj.width / maxWidth;
			const heightRatio = sizeObj.height / maxHeight;
			if (widthRatio < 1 && heightRatio < 1) {
				return [sizeObj.width, sizeObj.height];
			}
			let finalWidth, finalHeight;
			if (widthRatio > heightRatio) {
				finalWidth = maxWidth;
				finalHeight = sizeObj.height / widthRatio;
			} else {
				finalHeight = maxHeight;
				finalWidth = sizeObj.width / heightRatio;
			}
			return [Math.round(finalWidth), Math.round(finalHeight)];
		}

		const content = fs.readFileSync(`static/verbali/${descModulo}.docx`, "binary");

		const zip = new PizZip(content);
		const doc = new Docxtemplater(
			zip,
			{
				modules: [new ImageModule(opts)],
				paragraphLoop: true,
				linebreaks: true,
				nullGetter() { return ''; }
			}
		)
		
		doc.render(valori)

		const buf = doc.getZip().generate({
			type: "nodebuffer",
			compression: "DEFLATE",
		});

        await download(res, buf, filename);

		return buf;

	} catch (e) {
		console.log(e.stack);
		res.status(500).send(e).end();
	}
}

async function download(res, buf, filename) {
    let tmp = "static/verbali/tmp/";
    data = await libre.convertAsync(buf, ".pdf", undefined);
    fs.writeFileSync(tmp + filename, data);
    res.set({ "Access-Control-Expose-Headers": 'Content-Disposition' });
    res.download(tmp + filename, filename, function (err) {
        if (err) {
            console.log(err);
            res.status(500).send(err).end();
        }
        fs.unlinkSync(tmp + filename)
    });
}


router.post("/generaPdf", auth.authenticateToken, async function (req, res) {

	try {
        let idModulo = req.query.idModulo;
        let descrModulo = req.query.descrModulo;
        let filenamePdf = req.query.filename;
        let data = req.body;
        conn.client.query({
                text: `select * from documenti.pdf where id_modulo = $1 and descr_modulo = $2`,
                values: [idModulo, descrModulo]
            }
            , async (err, result) => {
                if(err){
                    console.log(err);
                }else{
                    if(result.rowCount){
                        await download(res, result.rows[0].data, result.rows[0].filename);
                    }else{
                        let pdf = await generaPdf(res, descrModulo, filenamePdf, data);
                        conn.client.query({
                                text: `insert into documenti.pdf (id_modulo, descr_modulo, filename, data) values ($1, $2, $3, $4) 
                                    on conflict (id_modulo, descr_modulo) do update set filename = $3, data = $4`,
                                values: [idModulo, descrModulo, filenamePdf, pdf]
                            }
                        )
                    }
                }
            })
        }
        catch (err) {
            console.log(err);
            res.status(500).send(err).end();
	    }
});

module.exports = router;