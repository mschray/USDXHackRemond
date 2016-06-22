'use strict';

var fs = require('fs'), 
    parse = require('csv-parse'),
    nconf = require('nconf');

    // Create nconf environtment 
    nconf 
        .file({ file: './config.json' }) 
        .env(); 

var connectionString = nconf.get("connectionString");

var clientFromConnectionString = require('azure-iot-device-amqp').clientFromConnectionString;
var Message = require('azure-iot-device').Message;

var client = clientFromConnectionString(connectionString);
var csvFile = process.argv[2] || nconf.get("fileName");

function printResultFor(op) {
    return function printResult(err, res) {
        if (err) {
            console.log(op + ' error: ' + err.toString());
        }
        if (res) console.log(op + ' status: ' + res.constructor.name);
    };
}

var connectCallback = function (err) {
    if (err) {
        console.log('Could not connect: ' + err);
    } else {
        console.log('Client connected');

        var eventName = nconf.get("eventName")
        var parser = parse({delimiter: ',', columns: true}, function(err, data){
            
            var x = 0;
            var interval = setInterval( function (){

                data[x]["eventName"] = eventName;

                var message = new Message(JSON.stringify(data[x]));
                
                // Send device message to IoT Hub client
                client.sendEvent(message, printResultFor('send'));

                console.log(x);
                x++;
                if (x == data.length) {
                    clearInterval(interval);
                }     
            }, 100);

        });

        console.log("Reading " + csvFile);
        fs.createReadStream(csvFile).pipe(parser);

  }
};

client.open(connectCallback);
