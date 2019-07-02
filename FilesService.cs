using System;
using System.Collections.Generic;
using System.IO;
using Newtonsoft.Json;

namespace camada_rede
{
    public class FilesService
    {

        private static string version = "4";
        private static string ihl = "5";
        private static string tos = "2";

        private static string id = "0";
        private static string flags = "0";
        private static string offset = "0";

        private static string ttl = "32";
        private static string protocol = "6";
        private static string checksum = "0";

        public string MakeIpPDU(string sourceIp, string destinIp, string data)
        {
            string line1 = "VERSION: " + version + " IHL: " + ihl + " TOS: " + tos + " LENGTH: " + data.Length;
            string line2 = "ID: " + id + " FLAGS: " + flags + " OFFSET: " + offset;
            string line3 = "TTL: " + ttl + " PROTOCOL: " + protocol + " CHECKSUM: " + checksum;
            string line4 = sourceIp;
            string line5 = destinIp;

            return line1 + "\n" + line2 + "\n" + line3 + "\n" + line4 + "\n" + line5 + "\n" + data;
        }

        public string GetSourceIp(string PDU)
        {
            var lines = PDU.Split('\n');
            return lines[3];
        }

        public string GetDestinationIp(string PDU)
        {
            var lines = PDU.Split('\n');
            return lines[4];
        }

        public string ReadFile(string path)
        {
            var content = string.Empty;
            using (var reader = new StreamReader(path))
            {
                content = reader.ReadToEnd();
                return content;
            }
        }
    }
}