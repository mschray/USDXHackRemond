using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using LumenWorks.Framework.IO.Csv;
using Microsoft.Azure.Devices.Client;
using Newtonsoft.Json;

namespace ProxfinityIOTDataParser
{
    class Program
    {

        private const string DeviceConnectionString = "your connect string";
        static DeviceClient deviceClient;

        static void Main(string[] args)
        {
            try
            {
                deviceClient = DeviceClient.CreateFromConnectionString(DeviceConnectionString);

                if (deviceClient == null)
                {
                    Console.WriteLine("Failed to create DeviceClient!");
                }
                else
                {
                   ReadCsv();

                }

                Console.WriteLine("Exited!\n");

            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in sample: {0}", ex.Message);
            }
            Console.WriteLine("Hit any key to exit...");
            Console.ReadLine();

        }

        
        static async void ReadCsv()
        {
            // open the file "data.csv" which is a CSV file with headers
            //ProxfinityQuickTest.csv
            //Results_10000201 (Autosaved).csv

            int count = 0;

            using (CsvReader csv =
                   new CsvReader(new StreamReader(@"C:\Users\mschray\Documents\mschray\Microsoft\FY17\AscendPlus\ProxfinityQuickTest.csv"), true))
            {
                int fieldCount = csv.FieldCount;
                ProxfinityIOTData proxfinityRecord = new ProxfinityIOTData();

                string[] headers = csv.GetFieldHeaders();
                while (csv.ReadNextRecord())
                {
                    int i = 0;
                    proxfinityRecord.id = csv[i++];
                    proxfinityRecord.booth_visit = csv[i++];
                    proxfinityRecord.cat_subcat = csv[i++];
                    proxfinityRecord.left_badgeId = csv[i++];
                    proxfinityRecord.left_email = csv[i++];
                    proxfinityRecord.left_firstname = csv[i++];
                    proxfinityRecord.left_flags = csv[i++];
                    proxfinityRecord.left_initials = csv[i++];
                    proxfinityRecord.left_lastname = csv[i++];
                    proxfinityRecord.left_matchShortId = csv[i++];
                    proxfinityRecord.left_maxRssi = csv[i++];
                    proxfinityRecord.left_missing_results = csv[i++];
                    proxfinityRecord.left_playerShortId = csv[i++];
                    proxfinityRecord.left_tickCount = csv[i++];
                    proxfinityRecord.right_badgeId = csv[i++];
                    proxfinityRecord.right_email = csv[i++];
                    proxfinityRecord.right_firstname = csv[i++];
                    proxfinityRecord.right_flags = csv[i++];
                    proxfinityRecord.right_initials = csv[i++];
                    proxfinityRecord.right_lastname = csv[i++];
                    proxfinityRecord.right_matchShortId = csv[i++];
                    proxfinityRecord.right_maxRssi = csv[i++];
                    proxfinityRecord.right_missing_results = csv[i++];
                    proxfinityRecord.right_playerShortId = csv[i++];
                    proxfinityRecord.right_tickCount = csv[i++];
                    proxfinityRecord.status = csv[i++];

                    string output = JsonConvert.SerializeObject(proxfinityRecord);

                    Message eventMessage = new Message(Encoding.UTF8.GetBytes(output));
                    Console.WriteLine("\t{0}> Sending message: {1}, Data: [{2}]", DateTime.Now.ToLocalTime(), ++count, output);

                    await deviceClient.SendEventAsync(eventMessage);
                                        
                }
            }
        }

    }
}




