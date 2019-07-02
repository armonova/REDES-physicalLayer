using System;
using System.Collections.Generic;
using System.IO;
using Newtonsoft.Json;

namespace camada_rede
{
    public class HostsTableService
    {
        private HostsTable HostsTable;
        
        public HostsTable GetHosts(string path)
        {
            using (var reader = new StreamReader(path))
            {
                var content = reader.ReadToEnd();
                return JsonConvert.DeserializeObject<HostsTable>(content);
            }
        }

        public Host CheckIP(string ip)
        {

            return null;
        }
    }
}