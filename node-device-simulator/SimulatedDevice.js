'use strict';

var fs = require('fs'), 
    parse = require('csv-parse'),
    nconf = require('nconf');

// Create nconf environment to load keys and connections strings
// which should not end up on GitHub
    nconf 
        .file({ file: './config.json' }) 
        .env(); 

// load file name/path from console cmd args or config.json
var csvFile = process.argv[2] || nconf.get("fileName");

// configure and instantiate the Azure IoT client and message
var connectionString = nconf.get("connectionString");
var clientFromConnectionString = require('azure-iot-device-amqp').clientFromConnectionString;
var Message = require('azure-iot-device').Message;
var client = clientFromConnectionString(connectionString);

// *****
// Util method to print result of Azure IoT Hub .send() method to the console
// *****
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

        // Client data does not include unique event name;
        // We're going to grab an "eventName" value from config.json
        var eventName = nconf.get("eventName");

        // Take the piped array data from fs.createReadStream and iterative over each line.
        // Using setInterval to throttle, send data to the IoT Hub for each row.
        var parser = parse({delimiter: ',', columns: true}, function(err, data){
            
            var x = 0;
            var interval = setInterval( function (){

                // add "eventName" value from config.json to each record
                data[x]["eventName"] = eventName;

                var message = new Message(JSON.stringify(data[x]));
                
                // Send device message to IoT Hub client
                client.sendEvent(message, printResultFor('send'));

                console.log(data[x].id);
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

// Open a connection to Azure IoT hub
client.open(connectCallback);
