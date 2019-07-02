using System;
using System.Collections.Generic;
using System.IO;
using Newtonsoft.Json;

namespace camada_rede
{
    public class HostsTableService
    {
        private HostsTable HostsTable;
        private NetworkServices networkServices = new NetworkServices();

        public HostsTable GetHosts(string path)
        {
            using (var reader = new StreamReader(path))
            {
                var content = reader.ReadToEnd();
                HostsTable = JsonConvert.DeserializeObject<HostsTable>(content);
                return HostsTable;
            }
        }

        public Host CheckIP(string myIP, string destIP, string myMask)
        {
            //to make sure HostsTable exists
            if (HostsTable == null || HostsTable.Hosts == null || HostsTable.Hosts.Count == 0)
            {
                GetHosts("hostsTable.json");
            }

            foreach (var host in HostsTable.Hosts)
            {
                if (networkServices.BitwiseAndOperation(destIP, host.Mask) == host.NetworkIP)
                {
                    return host;
                }
            }
            return null;
        }
    }
}