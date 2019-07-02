using System;

namespace camada_rede
{
    public class Program
    {
        public static FilesService filesService = new FilesService();
        public static NetworkServices networkService = new NetworkServices();
        public static string hostsPath = "hostsTable.json";

        public static void Main(string[] args)
        {
            var hostsTable = filesService.GetHosts(hostsPath);

            if (args.Length > 0 && args[0] == "-g")
            {
                Console.WriteLine("Gateway mode");
                
            }
            else
            {
                Console.WriteLine(networkService.IsIPInMyNetwork("192.168.1.0", "192.168.2.0", "255.255.255"));
                Console.WriteLine(hostsTable.Hosts[0].Mask);
            }
        }
    }
}
