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

async function compilaVerbaleCU(res, filename, valori) {

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

    // Load the docx file as binary content
    const content = fs.readFileSync(path.resolve("static/verbali/verbale_cu.docx"), "binary");
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

    // compila il verbale
    valori.image = path.resolve("static/images/" + String(valori.anag[0].asl_descr).trim().replace(" ", "_") + ".jpg")
    doc.render(valori);

    const buf = doc.getZip().generate({
        type: "nodebuffer",
        compression: "DEFLATE",
    });

    await download(res, buf, filename);

    return buf;
}

async function compilaRiepilogoStab(res, filename, valori) {

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

    // Load the docx file as binary content
    const content = fs.readFileSync(path.resolve("static/verbali/riepilogo_stabilimento.docx"), "binary");
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

    // compila il verbale
    valori.image = path.resolve("static/images/" + String(valori.stabilimento.asl_descr).trim().replace(" ", "_") + ".jpg")
    doc.render(valori);

    const buf = doc.getZip().generate({
        type: "nodebuffer",
        compression: "DEFLATE",
    });

    await download(res, buf, filename);

    return buf;
}

router.post("/getVerbaleCU", function (req, res) {
    try {
        //console.log("req:");
        //console.log(req);
        var isNew = req.query.nuovoPdf;
        console.log("Nuovo verbale:" + isNew);

        let data = req.body;
        let filename = "verbale_cu_" + data.cu.id_cu;

        if (isNew == "true")
            compilaVerbaleCU(res, filename, data);

    } catch (err) {
        console.log(err);
        res.status(500).send(err).end();
    }
});

router.post("/getRiepilogoStabilimento", auth.authenticateToken, async function (req, res) {
    try {
        let data = req.body;
        let filename = "riepilogo_stabilimento_" + data.stabilimento.id_stabilimento;

        await compilaRiepilogoStab(res, filename, data);

    } catch (err) {
        console.log(err);
        res.status(500).send(err).end();
    }
})

async function download(res, buf, filename) {
    let tmp = "static/verbali/tmp/";
    data = await libre.convertAsync(buf, ".pdf", undefined);
    let _f = { f: tmp + filename };
    let _d = { d: data };
    fs.writeFileSync(_f[Object.keys(_f)[0]], _d[Object.keys(_d)[0]]);
    res.set({ "Access-Control-Expose-Headers": 'Content-Disposition' });
    res.download(tmp + filename, filename, function (err) {
        if (err) {
            console.log(err);
            res.status(500).send(err).end();
        }
        fs.unlinkSync(tmp + filename)
    });
}

module.exports = router;