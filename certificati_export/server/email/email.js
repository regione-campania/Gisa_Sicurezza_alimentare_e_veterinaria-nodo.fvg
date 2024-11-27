/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
var nodemailer = require('nodemailer');
var conf = require('../config/config.js');


function sendEmail(_subject, _body, _to, _attachments) {

  var credentials = {
    host: conf.mailHost,
    port: conf.mailPort,
    secure: conf.mailSecure,
    tls: {
      rejectUnauthorized: false
    },
    auth: {
      user: conf.mailUsername,
      pass: conf.mailPassword
    }
  }

  var transporter = nodemailer.createTransport(credentials);

  if(conf.mailCcnTest){
    _body += ' <hr> Questa è una email di test, i veri destinatari sarebbero stati: ' + _to;
    _to = conf.mailCcnTest;
  }
  

  var mailOptions = {
    from: conf.mailFrom,
    to: _to,
    bcc: conf.mailCcnTest,
    subject: _subject,
    html: _body,
    attachments: _attachments
  };

  transporter.sendMail(mailOptions, function (error, info) {
    if (error) {
      console.log(error);
    } else {
      console.log('Email notifica sent: ' + info.response + `, TO: ${to}`);
    }
    //res.end();
  });


}

module.exports = { sendEmail: sendEmail }